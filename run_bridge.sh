#!/usr/bin/env bash
# 1. Source base ROS distributions
source /opt/ros/noetic/setup.bash
source /opt/ros/foxy/setup.bash

# 2. Source your custom workspaces in the exact dependency order
source ~/rethink_ws/devel/setup.bash
source ~/ros2_ws/install/setup.bash
source ~/bridge_ws/install/local_setup.bash

# 3. Set your Baxter network environment variables
export ROS_MASTER_URI=http://10.42.0.2:11311
export ROS_IP=10.42.0.1
unset ROS_HOSTNAME

# 4. Run the bridge
ros2 run ros1_bridge dynamic_bridge --bridge-all-topics