# dockerOpenwrt
Compile Openwrt firmware with docker (e.g. macOS or Windows)

## WHY
Official Openwrt [no longer supports all][1] legacy hardware [after 17.01][2] (some [after 18.06][3]). However, as you might've modded your hardware as I did, let's compile openwrt oursleves to fit our own hardware mods.

[1]: https://openwrt.org/supported_devices/432_warning
[2]: https://openwrt.org/supported_devices/openwrt_on_432_devices
[3]: https://openwrt.org/toh/tp-link/tl-wr740n

## HOW
The Dockerfile here is used to merely create a linux environement (ubuntu). 

```bash
docker build --rm -t docker-openwrt:latest .
```

Once docker container is launched from the image being built via the Dockerfile, you can choose which script to run according to your needs.

```bash 
docker run --rm --name openwrt-compiler -it docker-openwrt
```
Each hardware mods are supported via shell script. (e.g. hardware mods info, add legacy hardware to config menu, etc.) 
**Note.** You may be asked to choose the correct time zone.

```bash
./tl-wr703n.sh
```
After configuring build parameters (e.g. target hardware, packages, drivers, etc.), save and start building with *make* inside the source code folder (aka. openwrt).

Once done building, you can find the *factory.bin* and *sysupgrade.bin* inside the folder */openwrt/bin/targets/ar71xx/generic/*, which can be then copied out at the docker host's terminal with command

```bash
docker cp openwrt-compiler:*FILE_PATH* *LOCAL_PATH*

```
ps. Your can clean up docker leftovers after compile work

```bash
docker system prune -a
```

## Supported Hardware
|     Hardware    |Flash(NAND)/RAM now|Openwrt version|
|:---------------:|:-----------------:|:-------------:|
|TP-Link TL-WR703N|      8MB ([winbond 25Q64FVSIG](https://www.winbond.com/resource-files/w25q64fv%20revq%2006142016.pdf)) / 64MB ([ELPIDA D5116AFTA-5B-E](https://pdf1.alldatasheet.com/datasheet-pdf/view/210989/ELPIDA/EDD5116AFTA-5B-E.html))     |    19.07.6    |

<!-- |  MECOOL BB2 Pro |      16GB/3GB     |    porting    | -->