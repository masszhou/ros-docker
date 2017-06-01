#### 1. Description
original ros-indigo-desktop-full do not support openGL hardware rendering, which makes rviz not able to run from docker. I build this image from NVidia repository for Ubuntu 14.04 + ROS indigo desktop full with support of GPU and OpenGL 4.8 hardware rendering.

#### 2. Requirements
nvidia-docker

#### 3. Build
need ros_entrypoint.sh in the same folder with Dockefile

#### 4. Usage
Open X service for all user. (easy way but not safe) [source](http://wiki.ros.org/docker/Tutorials/GUI) 

    xhost +

##### Launch master node and rviz in single container

    nvidia-docker run -it --rm --env="DISPLAY" --env="QT_X11_NO_MITSHM=1" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" <image id> roscore

Open a new terminal

    docker exec -it <container id> bash
    $ source /opt/ros/indigo/setup.bash
    $ rosrun rviz rviz
