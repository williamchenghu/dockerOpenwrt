FROM ubuntu:22.04

#Update apt-get & install sudo
RUN apt-get update &&\
    apt-get install -y sudo g++ build-essential curl file gawk gettext git libncurses5-dev libssl-dev libelf-dev python2.7 python3 python3-distutils rsync subversion swig unzip wget ecj fastjar zlib1g-dev java-propose-classpath nano time &&\
    apt-get -y autoremove &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/*  &&\
# Create user 'build' and give it sudo rights without password, copy scripts into container, set working directory
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers &&\
    useradd -c "OpenWrt Builder" -m -d /home/build -G sudo -s /bin/bash build
COPY --chown=build:build ./scripts/*.sh /home/build/
# COPY --chown=build:build . /home/build/openwrt/
# RUN chown build:build /home/build/openwrt/

# Set environment parameters
USER build
ENV HOME /home/build
WORKDIR /home/build

# Make scripts executable
RUN chmod +x *.sh