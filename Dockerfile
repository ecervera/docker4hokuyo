FROM ros:kinetic-ros-base

RUN apt-get update && apt-get install -y \
    ros-kinetic-urg-node \
    && rm -rf /var/lib/apt/lists/*

ADD urg_node.launch /root

CMD ["roslaunch", "/root/urg_node.launch"]
