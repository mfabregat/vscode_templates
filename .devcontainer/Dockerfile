FROM tecnalia-robotics-docker-dev-local.artifact.tecnalia.dev:443/g1-ros-base-devel:humble

ARG USER=marc
ARG USER_UID=1000
ARG USER_GID=1000
ARG HOME=/home/${USER}
ARG WORKSPACE_PATH=${HOME}/Documents/code/workspace

ENV DEBIAN_FRONTEND=noninteractive

# Essential dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo \
    curl \
    git \
    git-lfs \
    openssh-client \
    gpg \
    mesa-utils \
    python3-pip \
    python-is-python3 \
    && rm -rf /var/lib/apt/lists/*

# Remove user if exists and create the new user
RUN (userdel -r $(getent passwd ${USER_UID} | cut -d: -f1) 2>/dev/null || true) && \
    (groupdel $(getent group ${USER_GID} | cut -d: -f1) 2>/dev/null || true) && \
    groupadd -g ${USER_GID} "${USER}" && \
    useradd --no-log-init -l -u ${USER_UID} -g ${USER_GID} -s /bin/bash \
            -d "${HOME}" -m "${USER}" && \
    echo "${USER} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/devcontainer_user && \
    chmod 0440 /etc/sudoers.d/devcontainer_user && \
    usermod -aG sudo "${USER}" 2>/dev/null || true && \
    touch ${HOME}/.sudo_as_admin_successful # Silence the sudo warning

# Cache the ros2 workspace dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-${ROS_DISTRO}-rmw-zenoh-cpp \
    python3-evdev \
    ros-${ROS_DISTRO}-gz-ros2-control \
    libapr1-dev \
    libaprutil1-dev \
    ros-${ROS_DISTRO}-apriltag-ros \
    python3-mock \
    cython3 \
    ros-${ROS_DISTRO}-tf-transformations \
    python3-netifaces \
    xdot \
    python3-wxgtk4.0 \
    && rm -rf /var/lib/apt/lists/*

USER ${USER}


RUN echo "if [ -f /opt/ros/${ROS_DISTRO}/setup.bash ]; then source /opt/ros/${ROS_DISTRO}/setup.bash; fi" >> ${HOME}/.bashrc && \
    echo "if [ -f ${WORKSPACE_PATH}/install/setup.bash ]; then source ${WORKSPACE_PATH}/install/setup.bash; fi" >> ${HOME}/.bashrc

USER ${USER}
CMD [ "/bin/bash" ]
