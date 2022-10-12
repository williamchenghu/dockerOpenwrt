#!/bin/bash

git clone https://github.com/openwrt/openwrt.git &&\
cd openwrt &&\
git checkout v22.03.0 &&\
./scripts/feeds update -a &&\
./scripts/feeds install -a &&\

# Change the firmware build size from 4MB to 8MB to match with the HW mod.
# in case of 16MB HW mod, tplink-4m shall be changed to tplink-16m, and tplink-4mlzma shall be tplink-16mlzma.
sed -i 's|$(Device/tplink-4m)|$(Device/tplink-8m)|g' ./target/linux/ath79/image/tiny-tp-link.mk &&\
sed -i 's|$(Device/tplink-4mlzma)|$(Device/tplink-8mlzma)|g' ./target/linux/ath79/image/tiny-tp-link.mk &&\
# Change the DTS block size from 4MB to 8MB to match with the HW mod.
sed -i 's|0x3d0000|0x7d0000|g' ./target/linux/ath79/dts/ar9331_tplink_tl-wr703n_tl-mr10u.dtsi &&\
sed -i 's|0x3f0000|0x7f0000|g' ./target/linux/ath79/dts/ar9331_tplink_tl-wr703n_tl-mr10u.dtsi &&\
sed -i 's|0x3d0000|0x7d0000|g' ./target/linux/ath79/dts/ar7240_tplink.dtsi &&\
sed -i 's|0x3f0000|0x7f0000|g' ./target/linux/ath79/dts/ar7240_tplink.dtsi &&\

make -j $(nproc) defconfig &&\
make -j $(nproc) menuconfig