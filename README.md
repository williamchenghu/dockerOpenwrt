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
docker build -t docker-openwrt:latest .
```

Once docker container is launched from the image being built via the Dockerfile, you can choose which script to run according to your needs.

```bash
docker run --rm --name openwrt-compiler -it docker-openwrt
```

Each version is supported via a shell script named after their version number. By executing the script, a commandline menu will be shown for one to tweak build preferences (e.g., target system, subtarget (generic, tiny, nand, etc.), target images (which hardware is one building the image for), kernel modules, various packages).

**Note.**

- You may be asked to choose the correct time zone.
- For v19.07, one shall choose `Atheros AR7xxx/AR9xxx` under `Target System` instead of `Atheros ATH79 (DTS)`
- some `Target Profiles` (e.g., tp-wr703n, tp-wr740n) can be found by choosing `Devices with small flash` (aka. tiny) in `Subtarget`.

```bash
./v19_07_10.sh
```

After configuring build parameters, choose `Exit` and one will be asked if preferences shall be saved, go ahead and confirm. At this point, one can enter the source code folder (aka. openwrt), and do the compilation.

```bash
cd openwrt
make
```

Once done building, you can find the _factory.bin_ and _sysupgrade.bin_ inside the folder _/openwrt/bin/targets/ar71xx/tiny/_, which can be then copied out at the docker host's terminal with command

```bash
docker cp openwrt-compiler:*FILE_PATH* *LOCAL_PATH*

```

ps. Your can clean up docker leftovers after compile work

```bash
docker system prune -a
```

## Supported Hardware

|                            Hardware                            |                                                                                                   Flash(NAND)/RAM now                                                                                                    | Openwrt version |
| :------------------------------------------------------------: | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: | :-------------: |
| [TP-Link TL-WR703N](https://openwrt.org/toh/tp-link/tl-wr703n) | 8MB ([winbond 25Q64FVSIG](https://www.winbond.com/resource-files/w25q64fv%20revq%2006142016.pdf)) / 64MB ([ELPIDA D5116AFTA-5B-E](https://pdf1.alldatasheet.com/datasheet-pdf/view/210989/ELPIDA/EDD5116AFTA-5B-E.html)) |    19.07.10     |
| [TP-Link TL-WR740N](https://openwrt.org/toh/tp-link/tl-wr740n) | 8MB ([winbond 25Q64FVSIG](https://www.winbond.com/resource-files/w25q64fv%20revq%2006142016.pdf)) / 64MB ([ELPIDA D5116AFTA-5B-E](https://pdf1.alldatasheet.com/datasheet-pdf/view/210989/ELPIDA/EDD5116AFTA-5B-E.html)) |    19.07.10     |

<!-- |  MECOOL BB2 Pro |      16GB/3GB     |    porting    | -->
