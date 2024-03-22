FROM osrf/ros:melodic-desktop-full

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install -y git \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /catkin_ws/src/

RUN git clone --recurse-submodules https://github.com/RobotResearchRepos/keenan-burnett_yeti_radar_odometry /catkin_ws/src/yeti_radar_odometry

RUN . /opt/ros/$ROS_DISTRO/setup.sh \
 && apt-get update \
 && rosdep install -r -y \
     --from-paths /catkin_ws/src \
     --ignore-src \
 && rm -rf /var/lib/apt/lists/*

RUN . /opt/ros/$ROS_DISTRO/setup.sh \
 && cd /catkin_ws \
 && catkin_make
 
 
