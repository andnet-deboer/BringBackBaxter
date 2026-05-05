#!/usr/bin/env bash

# Exit immediately if any command fails
set -e 

echo "Building ROS 2 Workspace"
(
    # Isolate the environment to only Foxy
    source /opt/ros/foxy/setup.bash
    cd ~/ros2_ws
    rm -rf build install log
    colcon build
)

echo "Building ROS 1 Workspace"
(
    # Isolate the environment to only Noetic
    source /opt/ros/noetic/setup.bash
    cd ~/rethink_ws
    catkin_make --pkg baxter_core_msgs baxter_maintenance_msgs intera_core_msgs  
    catkin_make
)

echo "Building Bridge Workspace"
(
    # Soruce in proper order
    source /opt/ros/noetic/setup.bash
    source ~/rethink_ws/devel/setup.bash
    source /opt/ros/foxy/setup.bash
    source ~/ros2_ws/install/setup.bash
    
    cd ~/bridge_ws
    
    # wipe the bridge cache since the ros2_ws underneath it changed
    rm -rf build install log 
    
    colcon build --symlink-install --packages-select ros1_bridge --cmake-force-configure
)

echo "Build Complete!"