transmission-dsl5028en
------------

Transmission BitTorrent client for the Aztech DSL5028EN (1T1R) Linux wireless router, built using a MIPS32 GCC 4.8.5 toolchain with uClibc 0.9.33.2.

![screenshot](http://i.imgur.com/JbDS9Zd.png)

## Why?

This is one of those *"because I can"* projects - while the core functionality is there, it doesn't run as well as I want to.
The tiny amount of RAM on this router makes Transmission run slowly, coupled with the fact that the router's USB port isn't 3.0.

## What's included?

* cURL 7.50.1
* OpenSSL 1.0.2h
* Zlib 1.2.8
* libevent 2.0.22
* Transmission 2.92
* uClibc 0.9.33.2 sysroot libs (needed to run Transmission)

## How to use

1. Make sure you have the right router and that you have a spare USB drive. The capacity doesn't matter (pick one that will fit your downloads), but ideally you should use one that has fast read/write speeds.
2. [Download the source tree](https://github.com/aureljared/transmission-dsl5028en/archive/master.zip) and unzip the contents to your USB drive. Make sure the folders (`bin`, `include`, `install`, `lib`, `share`, and `ssl`) are at the **root** of your USB drive and not in a subfolder.
3. **Linux/Mac only:** Open a terminal and `cd` into your USB drive, then `cd install && chmod +x ./prepare.sh`.
4. **Linux/Mac only:** If your USB disk is formatted as FAT32 or NTFS, execute `./prepare.sh -n`. **OR** if your USB disk is formatted as EXT3 or EXT4, execute `./prepare.sh`.
5. **Windows only:** For every item in `install\applets.txt`, duplicate `bin\busybox` into the item (e.g. `bin\[`, `bin\[[`, `bin\acpid`, and so on).
6. **Windows only:** For every line in `install\libs.txt`, duplicate the file before the comma in `lib` (e.g. `lib\ld-uClibc-0.9.33.2.so`) into the file after the comma (e.g. `ld-uClibc.so.0`).
7. Unmount your disk and plug it into your router.
8. **Windows only:** Make sure you have an SSH client, such as [PuTTY](http://www.putty.org), and that you know how to use it.
9. SSH into your router (the default password is `bayandsl`):
```
$ ssh admin@192.168.1.1
admin@192.168.1.1's password: 🔑
#
```
Run the Transmission daemon in foreground mode to see if things are working:
```
cd /tmp/mnt/usb1_1
bin/chroot /tmp/mnt/usb1_1
export TRANSMISSION_WEB_HOME=/share/transmission/web
transmission-daemon -f
```
Open a browser and go to `192.168.1.1:9091` to see if the Tranmission Web Interface loads.

If it runs, congrats! Terminate the daemon by pressing `Ctrl`+`C` (it may segfault, that's okay) and re-run it in normal mode.
```
transmission-daemon
```
