#
# Copyright © 2023 inpyjama.com. All Rights Reserved.
# Author: Piyush Itankar <piyush@inpyjama.com>
#

img:
	@echo "Building image for RPi 4+"
	@aarch64-linux-gnu-gcc -T linker.ld -Wall -nostdlib -nostartfiles -ffreestanding main.c start.S -o kernel8.elf
	@aarch64-linux-gnu-objcopy kernel8.elf -O binary kernel8.img
	@echo "generated: kernel8.img"
	@echo "Zipping content"
	@zip -j sd-card.zip sd-card/* kernel8.img > /dev/null
	@echo "Done! please download and extract sd-card.zip to local SD card"

clean:
	@rm -rf *.o *.img *.elf *.zip