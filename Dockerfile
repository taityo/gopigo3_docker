FROM ros:kinetic-ros-core-xenial

WORKDIR /home

RUN apt-get update -y \
  && apt-get install -y \
    git \
    ntp \
    ros-kinetic-rosserial-python \
    ros-kinetic-rosserial-server \
    ros-kinetic-rosserial-client \
    ros-kinetic-rosserial-msgs \
    ros-kinetic-amcl \
    ros-kinetic-map-server \
    ros-kinetic-move-base \
    ros-kinetic-urdf \
    ros-kinetic-xacro \
    ros-kinetic-gmapping \
    ros-kinetic-navigation \
    ros-kinetic-gazebo-ros-pkgs \
    ros-kinetic-gazebo-ros-control \
    ros-kinetic-rviz \
    ros-kinetic-robot-state-publisher \
    ros-kinetic-joint-state-publisher \
    ros-kinetic-rqt \
    ros-kinetic-rqt-common-plugins \
  && apt-get autoremove -y \
  && rm -rf /var/lib/apt/lists/ \
  && mkdir -p catkin_ws/src \
  && cd catkin_ws/src \
  && git clone https://github.com/iot-magi/gopigo3_navigation.git \
  && cd /home/catkin_ws \
  && bash -c "source /opt/ros/kinetic/setup.bash \
  && catkin_make"

COPY ./entry.sh /
COPY ./ntp.conf /etc/

RUN chmod +x /entry.sh

ENTRYPOINT ["/entry.sh"]
CMD ["bash"]
