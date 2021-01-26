#!/bin/bash

sudo apt-get update && \
sudo apt-get install -y \
    g++ \
    build-essential \
    curl \
    file \
    gawk \
    gettext \
    git \
    libncurses5-dev \
    libssl-dev \
    libelf-dev \
    python2.7 \
    python3 \
    python3-distutils \
    rsync \
    subversion \
    sudo \
    swig \
    unzip \
    wget \
    ecj \
    fastjar \
    zlib1g-dev \
    java-propose-classpath \
    nano \
    time && \
sudo apt-get -y autoremove && \
sudo apt-get clean && \
sudo rm -rf /var/lib/apt/lists/*

git clone https://github.com/openwrt/openwrt.git && \
cd openwrt
git checkout v19.07.6 && \
./scripts/feeds update -a && \
./scripts/feeds install -a && \
cat >> ./target/linux/ar71xx/image/generic-tp-link.mk <<\EOF
define Device/tl-wr703n-v1
  $(Device/tplink-8mlzma)
  DEVICE_TITLE := TP-LINK TL-WR703N v1
  DEVICE_PACKAGES := kmod-usb-core kmod-usb2
  BOARDNAME := TL-WR703N
  DEVICE_PROFILE := TLWR703
  TPLINK_HWID := 0x07030101
  CONSOLE := ttyATH0,115200
  IMAGE/factory.bin := append-rootfs | mktplinkfw factory -C US
endef
TARGET_DEVICES += tl-wr703n-v1
EOF
rm -rf .config*
wget https://downloads.openwrt.org/releases/19.07.6/targets/ar71xx/generic/config.buildinfo -O .config && \
cat >> .config <<\EOF
CONFIG_TARGET_DEVICE_ar71xx_generic_DEVICE_tl-wr703n-v1=y
CONFIG_TARGET_DEVICE_PACKAGES_ar71xx_generic_DEVICE_tl-wr703n-v1=""
EOF
make defconfig && \
make menuconfig