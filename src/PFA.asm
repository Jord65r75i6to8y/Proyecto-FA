.data
display: .space 1024
.text

li $t0, 0x007f1c
li $t1, 0
.globl main

main: 
	li $a1, 4
	jal print_0
	
	li $a1, 20
	jal print_1
	
	li $a1, 36
	jal print_2
	
	li $a1, 52
	jal print_3
	
	li $a1, 68
	jal print_4
	
	li $a1, 84
	jal print_5
	
	li $a1, 100
	jal print_6
	
	li $a1, 116
	jal print_7
	
	li $a1, 132
	jal print_8
	
	li $a1, 148
	jal print_9
	
	li $v0, 10
	syscall

print_0 :
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	addi $a1, $a1, 248
	sw $t0, display($a1)
	addi $a1, $a1, 8
	sw $t0, display($a1)
	addi $a1, $a1, 248
	sw $t0, display($a1)
	addi $a1, $a1, 8
	sw $t0, display($a1)
	addi $a1, $a1, 248
	sw $t0, display($a1)
	addi $a1, $a1, 8
	sw $t0, display($a1)
	addi $a1, $a1, 248
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	
	jr $ra
	
print_1 :
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	addi $a1, $a1, 256
	sw $t0, display($a1)
	addi $a1, $a1, 256
	sw $t0, display($a1)
	addi $a1, $a1, 256
	sw $t0, display($a1)
	addi $a1, $a1, 252
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	
	
	jr $ra
	
print_2 : 
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	addi $a1, $a1, 256
	sw $t0, display($a1)
	addi $a1, $a1, 252
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	addi $a1, $a1, 248
	sw $t0, display($a1)
	addi $a1, $a1, 256
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	
	jr $ra
	
print_3 : 
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	addi $a1, $a1, 256
	sw $t0, display($a1)
	addi $a1, $a1, 248
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	addi $a1, $a1, 256
	sw $t0, display($a1)
	addi $a1, $a1, 248
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	
	jr $ra
	
print_4 :
	sw $t0, display($a1)
	addi $a1, $a1, 8
	sw $t0, display($a1)
	addi $a1, $a1, 248
	sw $t0, display($a1)
	addi $a1, $a1, 8
	sw $t0, display($a1)
	addi $a1, $a1, 248
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	addi $a1, $a1, 256
	sw $t0, display($a1)
	addi $a1, $a1, 256
	sw $t0, display($a1)
	
	jr $ra
	
print_5:
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	addi $a1, $a1, 248
	sw $t0, display($a1)
	addi $a1, $a1, 256
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	addi $a1, $a1, 256
	sw $t0, display($a1)
	addi $a1, $a1, 248
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	
	jr $ra

print_6:
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	addi $a1, $a1, 248
	sw $t0, display($a1)
	addi $a1, $a1, 256
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	addi $a1, $a1, 248
	sw $t0, display($a1)
	addi $a1, $a1, 8
	sw $t0, display($a1)
	addi $a1, $a1, 248
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	
	jr $ra
	
print_7:
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	addi $a1, $a1, 256
	sw $t0, display($a1)
	addi $a1, $a1, 252
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	addi $a1, $a1, 248
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	addi $a1, $a1, 252
	sw $t0, display($a1)
	
	
	jr $ra
print_8:
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	addi $a1, $a1, 248
	sw $t0, display($a1)
	addi $a1, $a1, 8
	sw $t0, display($a1)
	addi $a1, $a1, 248
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	addi $a1, $a1, 248
	sw $t0, display($a1)
	addi $a1, $a1, 8
	sw $t0, display($a1)
	addi $a1, $a1, 248
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	
	jr $ra
	
print_9:
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	addi $a1, $a1, 248
	sw $t0, display($a1)
	addi $a1, $a1, 8
	sw $t0, display($a1)
	addi $a1, $a1, 248
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	addi $a1, $a1, 4
	sw $t0, display($a1)
	addi $a1, $a1, 256
	sw $t0, display($a1)
	addi $a1, $a1, 256
	sw $t0, display($a1)
	
	jr $ra
	
	
	



	