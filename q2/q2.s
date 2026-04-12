.section .text
.globl main


main:
    addi sp,sp,-64
    sd ra,56(sp)
    sd s0,48(sp)
    sd s1,40(sp)
    sd s2,32(sp)
    sd s3,24(sp)
    sd s4,16(sp)
    sd s5,8(sp)
    sd s6,0(sp)

    mv s0,a0
    mv s1,a1
    addi s2,s0,-1


    slli a0,s2,2
    call malloc
     mv s3,a0


    slli a0,s2,2
   call malloc
    mv s4,a0


    slli a0,s2,3
    call malloc
    mv s5,a0

    li s6,-1


    li t0,0
.prs_lp:
        bge t0,s2,.prs_done
        addi t1,t0,1
        slli t1,t1,3
        add t1,s1,t1
        ld a0,0(t1)
        addi sp,sp,-16
        sd t0,8(sp)
        call atoi
        ld t0,8(sp)
        addi sp,sp,16
        slli t1,t0,2
        add t1,s3,t1
        sw a0,0(t1)
        addi t0,t0,1
        j .prs_lp

.prs_done:
        li t0,0
.ri_lp:
        bge t0,s2,.ri_done
     slli t1,t0,2
        add t1,s4,t1
        li t2,-1
        sw t2,0(t1)
        addi t0,t0,1
        j .ri_lp

.ri_done:
    addi t0,s2,-1

.ng_lp:
    bltz t0,.ng_done


.pw_lp:
        bltz s6,.pw_done

        slli t1,s6,3
       add t1,s5,t1
        ld t2,0(t1)
        slli t3,t2,2
       add t3,s3,t3
        lw t3,0(t3)

        slli t4,t0,2
        add t4,s3,t4
        lw t4,0(t4)

        bgt t3,t4,.pw_done
        addi s6,s6,-1

    j .pw_lp

.pw_done:

        bltz s6,.ng_push
            slli t1,s6,3
        add t1,s5,t1
        ld t2,0(t1)
        slli t3,t0,2
        add t3,s4,t3
        sw t2,0(t3)

.ng_push:
        addi s6,s6,1
        slli t1,s6,3
        add t1,s5,t1
        sd t0,0(t1)

        addi t0,t0,-1
        j .ng_lp

.ng_done:

   li t0,0
.pr_lp:
    bge t0,s2,.pr_done
    addi sp,sp,-16
    sd t0,8(sp)
    beqz t0,.pr_nosp
     li a0,' '
    call putchar
.pr_nosp:
    slli t1,t0,2
    add t1,s4,t1
    lw a0,0(t1)
    call pi
      ld t0,8(sp)
    addi sp,sp,16
    addi t0,t0,1
    j .pr_lp

.pr_done:

    li a0,'\n'
   call putchar

        li a0,0
        ld ra,56(sp)
        ld s0,48(sp)
         ld s1,40(sp)
        ld s2,32(sp)
        ld s3,24(sp)
        ld s4,16(sp)
        ld s5,8(sp)
        ld s6,0(sp)
        addi sp,sp,64
    ret


pi:
    addi sp,sp,-32
    sd ra,24(sp)
    sd s0,16(sp)
    sd s1,8(sp)

    mv s0,a0

    bgez s0,.pi_pos
    li a0,'-'
    call putchar
    neg s0,s0

.pi_pos:
    li s1,10
    div t0,s0,s1
    beqz t0,.pi_dig
    mv a0,t0
    call pi

.pi_dig:

    rem t0,s0,s1
    addi a0,t0,'0'
    call putchar

    ld ra,24(sp)
    ld s0,16(sp)
    ld s1,8(sp)
    addi sp,sp,32
    ret
