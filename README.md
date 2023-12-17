# AArch64 from scratch on RPi

This repository hosts the baremetal source code which is used to explore AArch64 architecture on Raspberry-Pi 4B.

## OpenOCD and GDB

1. Prerequisites
   ```
   sudo apt install binutils libtool pkg-config make libusb-1.0-0-dev gdb-multiarch python3-pygments
   ```

1. Install `openocd` version - `0.12`
   ```
   cd ~/Downloads
   git clone https://github.com/openocd-org/openocd.git
   cd openocd
   ./bootstrap
   ./configure --enable-ftdi
   make
   sudo make install
   ```
1. Confirm `openocd` version to be as expected
   ```
   $ openocd -v
   Open On-Chip Debugger 0.12.0+dev-01444-ge8e09b1b5 (2023-12-16-22:31)
   Licensed under GNU GPL v2
   For bug reports, read
   	http://openocd.org/doc/doxygen/bugs.html
   ```
1. Change the adptor settings in the openocd configuration file
   1. edit: `sudo nano /usr/local/share/openocd/scripts/interface/ftdi/ft232h-module-swd.cfg`
   1. find and replace `transport select swd` with `transport select jtag`
1. Attached `openocd` to the board using the following command:
   ```
   sudo openocd -f interface/ftdi/ft232h-module-swd.cfg -f target/bcm2711.cfg
   ```
1. Install GDB dashboard
   ```
   wget -P ~ https://git.io/.gdbinit
   ```
1. start gdb
   ```
   gdb-multiarch shell.elf -ex "target remote localhost:3333"
   ```

## Documentation Links
1. [Raspberry-Pi Documents](https://www.raspberrypi.com/documentation/)
   1. [BCM2711-ARM-Peripherals](https://datasheets.raspberrypi.com/bcm2711/bcm2711-peripherals.pdf)
   1. [GPIO PIN Header](https://www.raspberrypi.com/documentation/computers/raspberry-pi.html#gpio-and-the-40-pin-header)
1. [OpenOCD and JTAG setup](https://medium.com/@0xNoor/setup-openocd-with-jtag-uart-on-raspberry-pi-4-using-ft232h-da05ca01c693)