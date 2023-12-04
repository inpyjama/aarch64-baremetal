#
# Copyright © 2023 inpyjama.com. All Rights Reserved.
# Author: Mahmad Bharmal <mahmad@inpyjama.com>
#

.section ".init"
_start:
    mrs     x1, mpidr_el1
    and     x1, x1, #3
    cbnz    x1, 1f
    ldr     x1, =_start
    mov     sp, x1
    bl      main
1:
    wfe
    b       1b
