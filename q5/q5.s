.section .rodata

input_name:
	.asciz "input.txt"
yes:
	.asciz "Yes"
no:
	.asciz "No"

.section .text
.globl main

main:
	addi sp, sp, -64
	
     sd ra, 56(sp)
	 sd s0, 48(sp)
	 sd s1, 40(sp)
	 sd s2, 32(sp)
	 sd s3, 24(sp)

	
	 la a0, input_name

	 li a1, 0
     call open

	 mv s0, a0
	 blt s0, zero, .print_no

	 mv a0, s0
	 li a1, 0
	 li a2, 2

	 call lseek
	 mv s1, a0

	 blt s1, zero, .no_cl

	 li s2, 0
    addi s3, s1, -1

.loop_check:
	bge s2, s3, .yes_cl

	mv a0, s0
	addi a1, sp, 0
	li a2, 1
	mv a3, s2

	call pread

	li t0, 1
	bne a0, t0, .no_cl

	mv a0, s0
	addi a1, sp, 1
	li a2, 1
	mv a3, s3

	call pread

	li t0, 1
	bne a0, t0, .no_cl

	lbu t1, 0(sp)
	lbu t2, 1(sp)
	bne t1, t2, .no_cl

	addi s2, s2, 1
	addi s3, s3, -1
j .loop_check

.yes_cl:

	mv a0, s0
	call close

	la a0, yes

	call puts
j .done

.no_cl:
	mv a0, s0
	call close

.print_no:

la a0, no
call puts

.done:

  li a0, 0

	ld s3, 24(sp)
	ld s2, 32(sp)
	ld s1, 40(sp)
	ld s0, 48(sp)
	ld ra, 56(sp)

  addi sp, sp, 64
ret