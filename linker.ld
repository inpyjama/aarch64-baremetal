/**
 * Copyright © 2023 inpyjama.com. All Rights Reserved.
 * Author: Piyush Itankar <piyush@inpyjama.com>
 */

MEMORY
{
    RAM : ORIGIN = 0x80000, LENGTH = 4K
}

SECTIONS
{
    .text : {
        *(.init*)
        *(.text*)
    } > RAM

    .data : {
        . = ALIGN(8);
        *(.data*)
    } > RAM

    .bss : {
        . = ALIGN(8);
        *(.bss*)
    } > RAM

    .rodata : {
        . = ALIGN(8);
        *(.rodata*)
    } > RAM
}
