#!/bin/bash

git clone https://github.com/openwrt/openwrt.git &&\
cd openwrt &&\
git checkout v19.07.10 &&\
./scripts/feeds update -a &&\
./scripts/feeds install -a &&\

# Change the firmware build size from 4MB to 8MB to match with the HW mod.
# in case of 16MB HW mod, tplink-4m shall be changed to tplink-16m, and tplink-4mlzma shall be tplink-16mlzma.
sed -i 's|$(Device/tplink-4m)|$(Device/tplink-8m)|g' ./target/linux/ar71xx/image/tiny-tp-link.mk &&\
sed -i 's|$(Device/tplink-4mlzma)|$(Device/tplink-8mlzma)|g' ./target/linux/ar71xx/image/tiny-tp-link.mk &&\

make defconfig &&\
make menuconfig