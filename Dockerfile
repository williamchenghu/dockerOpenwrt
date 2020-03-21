FROM ubuntu
MAINTAINER Cheng (cheng@cheng.com)

#Update apt-get & install sudo
RUN apt-get update &&\
    apt-get install -y sudo &&\
# Create user 'build' and give it sudo rights without password, copy scripts into container, set working directory
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers &&\
    useradd -c "OpenWrt Builder" -m -d /home/build -G sudo -s /bin/bash build
COPY --chown=build:build ./*.sh /home/build/
# COPY --chown=build:build . /home/build/openwrt/
# RUN chown build:build /home/build/openwrt/

# Set environment parameters
USER build
ENV HOME /home/build
WORKDIR /home/build

# Make scripts executable
RUN chmod +x *.sh