FROM masszhou/ros-indigo-cuda8-opengl4
MAINTAINER Zhiliang Zhou <zhouzhiliang@gmail.com>

# this Dockerfile is modified from Dockerfile from CPFL/Autoware/1.1.2
# reference link https://github.com/CPFL/Autoware/blob/1.1.2/docker/Dockerfile
# Major different parts
# add missing dependencies
# apt-get install libglew-dev ros-indigo-grid-map ros-indogo-sicktoolbox ros-indigo-sicktoolbox-wrapper ros-indigo-velocity-controllers

# Intall ROS dependencies
RUN apt-get update && apt-get install -y \
        ros-indigo-nmea-msgs \
        ros-indigo-nmea-navsat-driver ros-indigo-sound-play \
        ros-indigo-jsk-visualization \
        ros-indigo-perception-pcl \
        ros-indigo-openni-launch \
        ros-indigo-turtlebot-simulator \
        ros-indigo-grid-map \
        ros-indigo-sicktoolbox \
        ros-indigo-sicktoolbox-wrapper \
        ros-indigo-velocity-controllers \
        libnlopt-dev freeglut3-dev qtbase5-dev \
        libqt5opengl5-dev libssh2-1-dev libarmadillo-dev \
        libpcap-dev gksu \
        && rm -rf /var/lib/apt/lists/*

# Development dependencies
RUN apt-get update && apt-get install -y \
        libboost-all-dev \
        libflann-dev \
        libgsl0-dev \
        libgoogle-perftools-dev \
        libeigen3-dev \
        && rm -rf /var/lib/apt/lists/*

# GUI and sound libs
RUN apt-get update && apt-get install -y \
        xz-utils file locales dbus-x11 pulseaudio dmz-cursor-theme \
        fonts-dejavu fonts-liberation hicolor-icon-theme \
        libcanberra-gtk3-0 libcanberra-gtk-module libcanberra-gtk3-module \
        libasound2 libgtk2.0-0 libdbus-glib-1-2 libxt6 libexif12 \
        libgl1-mesa-glx libgl1-mesa-dri libglew-dev \
        gnome-terminal cmake-qt-gui \
        && rm -rf /var/lib/apt/lists/* \
        && update-locale LANG=C.UTF-8 LC_MESSAGES=POSIX

# Install OpenCV dependencies
RUN apt-get update && apt-get -y \
        install libopencv-dev build-essential \
        cmake git libgtk2.0-dev pkg-config python-dev python-numpy \
        libdc1394-22 libdc1394-22-dev libjpeg-dev libpng12-0 libjasper-dev \
        libavcodec-dev libavformat-dev libswscale-dev libgstreamer0.10-dev \
        libgstreamer-plugins-base0.10-dev libv4l-dev libtbb-dev libqt4-dev \
        libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev \
        libtheora-dev libvorbis-dev libxvidcore-dev x264 v4l-utils unzip \
        && rm -rf /var/lib/apt/lists/*

# Install OpenCV 2.4.13
RUN git clone -b "2.4.13" --single-branch https://github.com/opencv/opencv.git /root/opencv \
        && cd /root/opencv \
        && mkdir build \
        && cd build \
        && cmake -D WITH_TBB=ON -D BUILD_NEW_PYTHON_SUPPORT=ON -D WITH_V4L=ON -D CUDA_GENERATION=Auto -D WITH_QT=ON -D WITH_OPENGL=ON -D WITH_VTK=ON .. \
        && make -j8 \
        && make install

ENV PKG_CONFIG_PATH $PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
ENV PULSE_SERVER /run/pulse/native

# Install Autoware
RUN git clone -b "1.1.2" --single-branch https://github.com/CPFL/Autoware.git /root/Autoware
RUN /bin/bash -c "source /opt/ros/indigo/setup.bash \
        && cd /root/Autoware/ros/src \
        && catkin_init_workspace \
        && cd .. \
        && ./catkin_make_release"

# setup entrypoint, need entrypoint.sh in the same folder with Dockerfile
COPY ./autoware_entrypoint.sh /

ENTRYPOINT ["/autoware_entrypoint.sh"]

# Change Terminal Color
RUN gconftool-2 --set "/apps/gnome-terminal/profiles/Default/use_theme_background" --type bool false
RUN gconftool-2 --set "/apps/gnome-terminal/profiles/Default/use_theme_colors" --type bool false
RUN gconftool-2 --set "/apps/gnome-terminal/profiles/Default/background_color" --type string "#FFFFFF"

CMD ["gnome-terminal"]
