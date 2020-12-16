# docker4hokuyo

## Networking containers across multiple hosts (in the same network)

Based on [the Docker docs](https://docs.docker.com/network/network-tutorial-overlay/#use-an-overlay-network-for-standalone-containers).

1. In external PC
```
docker swarm init
```
(keep the token step 2)

2. In robot PC
```
docker swarm join --token <TOKEN> <IP-ADDRESS-OF-MANAGER>:2377
```

3. In external PC
```
docker network create -d overlay --attachable rosnet
```

4. In robot PC
```
docker run --rm -it --net=rosnet --name turtlebot \
  --env ROS_HOSTNAME=pioneer \
  --env ROS_MASTER_URI=http://pioneer:11311 \
  --device=/dev/ttyACM0:/dev/ttyACM0 \
  hokuyo:kinetic
```

5. In external PC
```
xhost +local:root
docker run --rm -it --net=rosnet --name client \
  --env="DISPLAY" --env="QT_X11_NO_MITSHM=1" \
  --env ROS_HOSTNAME=client \
  --env ROS_MASTER_URI=http://pioneer:11311 \
  --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
  osrf/ros:kinetic-desktop-full rosrun rviz rviz
xhost -local:root
```
