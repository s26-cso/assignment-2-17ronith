.section .text

.globl make_node
.globl insert
.globl get
.globl getAtMost


make_node:
    addi sp,sp, -16
    sd ra,8(sp)
    sd   s0,0(sp)

    mv s0,a0

    li a0,24
    call malloc

     sw s0,0(a0)
     sd zero,8(a0)
     sd zero,16(a0)

    ld ra,8(sp)
    ld s0,0(sp)
    addi sp,sp,16
 ret

insert:
    addi sp,sp,-32
    sd ra,24(sp)
    sd s0,16(sp)
    sd s1,8(sp)

    mv s0,a0
    mv  s1,a1

    bnez s0,.ins_nn

    mv a0,s1
    call make_node
    j .ins_ret

.ins_nn:
    lw t0,0(s0)
    blt s1,t0,.ins_l

    ld a0,16(s0)
    mv a1,s1
    call insert
    sd a0,16(s0)
    j .ins_rr

.ins_l:
    ld a0, 8(s0)
    mv a1,s1
    call insert
    sd a0, 8(s0)

.ins_rr:
    mv a0,s0

.ins_ret:
    ld ra,24(sp)
    ld s0,16(sp)
   ld s1,8(sp)
    addi sp,sp,32
    ret

get:
 beqz a0,.g_ret

    lw t0,0(a0)
    beq a1,t0,.g_ret

    blt a1,t0,.g_l

    ld a0,16(a0)
 j get

.g_l:
   ld a0,8(a0)
 j get

.g_ret:
    ret


getAtMost:
        addi sp,sp,-32
        sd ra,24(sp)
        sd s0,16(sp)
        sd s1,8(sp)
        sd s2,0(sp)

        mv s0,a0
        mv s1,a1
        li s2, 0

.gam_lp:
    beqz s1,.gam_done

    lw t0,0(s1)

    blt s0,t0,.gam_gl

    mv s2,t0
    ld s1,16(s1)
    j .gam_lp

.gam_gl:
   ld s1,8(s1)
   j .gam_lp

.gam_done:
    mv a0,s2

    ld ra,24(sp)
    ld s0,16(sp)
    ld s1,8(sp)

    ld s2,0(sp)
    addi sp,sp,32
    ret
