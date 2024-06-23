.data
display: .space 16384
term1: .space 5
Operand:.space 1
term2: .space 5
hla: .asciiz  "\n\n"
.text
li $t0, 0x007f1c
.globl main

main:

	li $v0, 8
	la $a0, term1
	li $a1, 5
	syscall
	
	li $a1, 0
	li $a2, 16
	la $a3, term1
	jal print
	
	li $v0, 4
	la $a0, hla
	syscall
	
	li $v0, 8
	la $a0, Operand 
	li $a1, 2
	syscall
	
	li $a1, 80
	li $a2, 16
	la $a3, Operand
	jal print

	li $v0, 4
	la $a0, hla
	syscall
	
	li $v0, 8
	la $a0, term2
	li $a1, 5
	syscall
	
	li $a1, 112
	li $a2, 16
	la $a3, term2
	jal print
	
	li $v0, 10
	syscall 
	
print:
	li $t1, 0
	move $t5, $ra
	
	print_loop:

		lb $t2, 0($a3)
		beqz $t2, exit_loop

		sub $t2, $t2, '0' 
	
		mul $t4, $t1, $a2      
		add $t3, $t4, $a1
		li $t6, 0

		bne $t2, $t6, number_1
		jal print_0
number_1:	addi $t6, $t6, 1
		bne $t2, $t6, number_2
		jal print_1
number_2:	addi $t6, $t6, 1
		bne $t2, $t6, number_3
		jal print_2
number_3:	addi $t6, $t6, 1
		bne $t2, $t6, number_4
		jal print_3
number_4:	addi $t6, $t6, 1
		bne $t2, $t6, number_5
		jal print_4
number_5:	addi $t6, $t6, 1
		bne $t2, $t6, number_6
		jal print_5
number_6:	addi $t6, $t6, 1
		bne $t2, $t6, number_7
		jal print_6
number_7:	addi $t6, $t6, 1
		bne $t2, $t6, number_8
		jal print_7
number_8:	addi $t6, $t6, 1
		bne $t2, $t6, number_9
		jal print_8
number_9:	addi $t6, $t6, 1
		bne $t2, $t6, mod
		jal print_9
mod:		addi $t6, $t6, -20
		bne $t2, $t6, Mult
		jal print_Mod
Mult:		addi $t6, $t6, 5
		bne $t2, $t6, plus
		jal print_Mult
plus:		addi $t6, $t6, 1
		bne $t2, $t6, substract
		jal print_plus
substract:	addi $t6, $t6, 2
		bne $t2, $t6, Division
		jal print_substract
Division:	addi $t6, $t6, 2
		bne $t2, $t6, log
		jal print_Division
log:		addi $t6, $t6, 29
		bne $t2, $t6, pow
		jal print_log
pow:		addi $t6, $t6, 18
		bne $t2, $t6, root
		jal print_pow
root:		addi $t6, $t6, 24
		bne $t2, $t6, end_conditional
		jal print_root
		
end_conditional: 
    
		addi $t1, $t1, 1
		addi $a3, $a3, 1
		j print_loop
    
	exit_loop:
	
		jr $t5
	
	
print_0 :
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 248
	sw $t0, display($t3)
	addi $t3, $t3, 8
	sw $t0, display($t3)
	addi $t3, $t3, 248
	sw $t0, display($t3)
	addi $t3, $t3, 8
	sw $t0, display($t3)
	addi $t3, $t3, 248
	sw $t0, display($t3)
	addi $t3, $t3, 8
	sw $t0, display($t3)
	addi $t3, $t3, 248
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	
	jr $ra
	
	
print_1 :
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 256
	sw $t0, display($t3)
	addi $t3, $t3, 256
	sw $t0, display($t3)
	addi $t3, $t3, 256
	sw $t0, display($t3)
	addi $t3, $t3, 252
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	
	
	jr $ra
	
print_2 : 
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 256
	sw $t0, display($t3)
	addi $t3, $t3, 252
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 248
	sw $t0, display($t3)
	addi $t3, $t3, 256
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	
	jr $ra
	
print_3 : 
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 256
	sw $t0, display($t3)
	addi $t3, $t3, 248
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 256
	sw $t0, display($t3)
	addi $t3, $t3, 248
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	
	jr $ra
	
print_4 :
	sw $t0, display($t3)
	addi $t3, $t3, 8
	sw $t0, display($t3)
	addi $t3, $t3, 248
	sw $t0, display($t3)
	addi $t3, $t3, 8
	sw $t0, display($t3)
	addi $t3, $t3, 248
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 256
	sw $t0, display($t3)
	addi $t3, $t3, 256
	sw $t0, display($t3)
	
	jr $ra
	
print_5:
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 248
	sw $t0, display($t3)
	addi $t3, $t3, 256
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 256
	sw $t0, display($t3)
	addi $t3, $t3, 248
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	
	jr $ra

print_6:
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 248
	sw $t0, display($t3)
	addi $t3, $t3, 256
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 248
	sw $t0, display($t3)
	addi $t3, $t3, 8
	sw $t0, display($t3)
	addi $t3, $t3, 248
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	
	jr $ra
	
print_7:
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 256
	sw $t0, display($t3)
	addi $t3, $t3, 252
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 248
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 252
	sw $t0, display($t3)
	
	
	jr $ra
print_8:
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 248
	sw $t0, display($t3)
	addi $t3, $t3, 8
	sw $t0, display($t3)
	addi $t3, $t3, 248
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 248
	sw $t0, display($t3)
	addi $t3, $t3, 8
	sw $t0, display($t3)
	addi $t3, $t3, 248
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	
	jr $ra
	
print_9:
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 248
	sw $t0, display($t3)
	addi $t3, $t3, 8
	sw $t0, display($t3)
	addi $t3, $t3, 248
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 256
	sw $t0, display($t3)
	addi $t3, $t3, 256
	sw $t0, display($t3)
	
	jr $ra
	
print_Division:
	addi $t3, $t3, 8
	sw $t0, display($t3)
	addi $t3, $t3, 252
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 252
	sw $t0, display($t3)
	addi $t3, $t3, 252
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 252
	sw $t0, display($t3)
	
	jr $ra

print_Mult:

	addi $t3, $t3, 256
	sw $t0, display($t3)
	addi $t3, $t3, 8
	sw $t0, display($t3)
	addi $t3, $t3, 252
	sw $t0, display($t3)
	addi $t3, $t3, 252
	sw $t0, display($t3)
	addi $t3, $t3, 8
	sw $t0, display($t3)
	
	jr $ra
	
print_plus:
	addi $t3, $t3, 260
	sw $t0, display($t3)
	addi $t3, $t3, 252
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 252
	sw $t0, display($t3)
	
	jr $ra
	
print_substract:

	addi $t3, $t3, 512
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	
	jr $ra
	
print_pow:

	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 252
	sw $t0, display($t3)
	addi $t3, $t3, 8
	sw $t0, display($t3)
	
	jr $ra
	
print_root:

	addi $t3, $t3, 256
	addi $t3, $t3, 256
	addi $t3, $t3, 256
	sw $t0, display($t3)
	addi $t3, $t3, 8
	sw $t0, display($t3)
	addi $t3, $t3, 252
	sw $t0, display($t3)	
	
	jr $ra
	
print_log:
	sw $t0, display($t3)
	addi $t3, $t3, 256
	sw $t0, display($t3)
	addi $t3, $t3, 256
	sw $t0, display($t3)
	addi $t3, $t3, 256
	sw $t0, display($t3)
	addi $t3, $t3, 256
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	
	jr $ra
	
print_Mod:
	sw $t0, display($t3)
	addi $t3, $t3, 8
	sw $t0, display($t3)
	addi $t3, $t3, 252
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 252
	sw $t0, display($t3)
	addi $t3, $t3, 252
	sw $t0, display($t3)
	addi $t3, $t3, 4
	sw $t0, display($t3)
	addi $t3, $t3, 252
	sw $t0, display($t3)
	addi $t3, $t3, 8
	sw $t0, display($t3)
	
	jr $ra

print_biggerThan:
	sw $t0, display($t3)
	addi $t3, $t3, 260
	sw $t0, display($t3)
	addi $t3, $t3, 260
	sw $t0, display($t3)
	addi $t3, $t3, 252
	sw $t0, display($t3)
	addi $t3, $t3, 252
	sw $t0, display($t3)
	
	jr $ra
	
	

	
	
	
	
