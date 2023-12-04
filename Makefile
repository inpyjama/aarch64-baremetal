#
# Copyright © 2023 inpyjama.com. All Rights Reserved.
# Author: Piyush Itankar <piyush@inpyjama.com>
#

img:
	@echo "Building image for RPi 4+"
	@aarch64-linux-gnu-gcc -T linker.ld -Wall -nostdlib -nostartfiles -ffreestanding main.c start.S -o kernel8.elf
	@aarch64-linux-gnu-objcopy kernel8.elf -O binary kernel8.img
	@echo "generated: kernel8.img"

clean:
	@rm -rf *.o *.img *.elf