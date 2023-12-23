#
# Copyright © 2023 inpyjama.com. All Rights Reserved.
# Author: Mahmad Bharmal <mahmad@inpyjama.com>
#

.section ".init"
_start:
    /* A simple check to verify we booted in EL3 */
    /* If we booted in non-EL3 this access would result in an exception */
    msr     vbar_el3, x0
    mrs     x2, scr_el3
    msr     scr_el3, x2
    isb
    dmb     sy

    mrs     x1, mpidr_el1
    and     x1, x1, #3
    cbnz    x1, 1f
    ldr     x1, =_start
    mov     sp, x1
    bl      main
1:
    wfe
    b       1b
