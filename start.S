#
# Copyright © 2023 inpyjama.com. All Rights Reserved.
# Author: Mahmad Bharmal <mahmad@inpyjama.com>
#

.section ".init"
_start:
    mrs     x1, mpidr_el1
    and     x1, x1, #3
    ldr     x3, =_start
    mov     x2, 0x100
    mul     x2, x2, x1
    sub     x3, x3, x2
    mov     sp, x3
    mrs     x1, mpidr_el1
    and     x1, x1, #3
    cbnz    x1, 1f
    mov     x0, x1
    bl      main
    b       .
1:
    mov     x0, x1
    cmp     x0, #1
    beq     second_main
    cmp     x0, #2
    beq     third_main
    cmp     x0, #3
    beq     fourth_main
    b       .
 second_main:
    bl      second_core_main
    b       .
third_main:
    bl      third_core_main
    b       .
fourth_main:
    bl      fourth_core_main
    b       .
