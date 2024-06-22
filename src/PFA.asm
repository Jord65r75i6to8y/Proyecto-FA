.data
display: .space 1024
term1: .space 3
term2: .space 3
.text

li $t0, 0x007f1c
.globl main

main:
    li $v0, 8         # Leer cadena
    la $a0, term1     # Direccion de la cadena
    li $a1, 4         # Longitud maxima de la cadena
    syscall
    
    jal print
    
    li $v0, 10        # Salir
    syscall
    
read:
	li $t1, 0
	jr $ra

print:
    li $t1, 0         # Inicializar indice de caracteres
    li $t5, 16

print_loop:

    lb $t2, term1($t1)   # Cargar caracter de term1[$t1]
    beqz $t2, end_print
    
    sub $t2, $t2, '0'       # Convertir ASCII a entero
    
    # Calcular la direccion en display
    mul $t4, $t1, $t5       # Calcular el desplazamiento en display
    add $a2, $t4, $a1       # Sumar al desplazamiento de la direccion base de display
    
    # Saltar a la subrutina correspondiente
    beq $t2, 0, print_0
    beq $t2, 1, print_1
    beq $t2, 2, print_2
    beq $t2, 3, print_3
    beq $t2, 4, print_4
    beq $t2, 5, print_5
    beq $t2, 6, print_6
    beq $t2, 7, print_7
    beq $t2, 8, print_8
    beq $t2, 9, print_9
    
    addi $t1, $t1, 1 # Incrementar el ïndice de caracteres
    j print_loop

end_print:
    jr $ra

print_0 :
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	addi $a2, $a2, 248
	sw $t0, display($a2)
	addi $a2, $a2, 8
	sw $t0, display($a2)
	addi $a2, $a2, 248
	sw $t0, display($a2)
	addi $a2, $a2, 8
	sw $t0, display($a2)
	addi $a2, $a2, 248
	sw $t0, display($a2)
	addi $a2, $a2, 8
	sw $t0, display($a2)
	addi $a2, $a2, 248
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	
	jr $ra
	
	
print_1 :
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	addi $a2, $a2, 256
	sw $t0, display($a2)
	addi $a2, $a2, 256
	sw $t0, display($a2)
	addi $a2, $a2, 256
	sw $t0, display($a2)
	addi $a2, $a2, 252
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	
	
	jr $ra
	
print_2 : 
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	addi $a2, $a2, 256
	sw $t0, display($a2)
	addi $a2, $a2, 252
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	addi $a2, $a2, 248
	sw $t0, display($a2)
	addi $a2, $a2, 256
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	
	jr $ra
	
print_3 : 
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	addi $a2, $a2, 256
	sw $t0, display($a2)
	addi $a2, $a2, 248
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	addi $a2, $a2, 256
	sw $t0, display($a2)
	addi $a2, $a2, 248
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	
	jr $ra
	
print_4 :
	sw $t0, display($a2)
	addi $a2, $a2, 8
	sw $t0, display($a2)
	addi $a2, $a2, 248
	sw $t0, display($a2)
	addi $a2, $a2, 8
	sw $t0, display($a2)
	addi $a2, $a2, 248
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	addi $a2, $a2, 256
	sw $t0, display($a2)
	addi $a2, $a2, 256
	sw $t0, display($a2)
	
	jr $ra
	
print_5:
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	addi $a2, $a2, 248
	sw $t0, display($a2)
	addi $a2, $a2, 256
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	addi $a2, $a2, 256
	sw $t0, display($a2)
	addi $a2, $a2, 248
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	
	jr $ra

print_6:
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	addi $a2, $a2, 248
	sw $t0, display($a2)
	addi $a2, $a2, 256
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	addi $a2, $a2, 248
	sw $t0, display($a2)
	addi $a2, $a2, 8
	sw $t0, display($a2)
	addi $a2, $a2, 248
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	
	jr $ra
	
print_7:
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	addi $a2, $a2, 256
	sw $t0, display($a2)
	addi $a2, $a2, 252
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	addi $a2, $a2, 248
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	addi $a2, $a2, 252
	sw $t0, display($a2)
	
	
	jr $ra
print_8:
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	addi $a2, $a2, 248
	sw $t0, display($a2)
	addi $a2, $a2, 8
	sw $t0, display($a2)
	addi $a2, $a2, 248
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	addi $a2, $a2, 248
	sw $t0, display($a2)
	addi $a2, $a2, 8
	sw $t0, display($a2)
	addi $a2, $a2, 248
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	
	jr $ra
	
print_9:
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	addi $a2, $a2, 248
	sw $t0, display($a2)
	addi $a2, $a2, 8
	sw $t0, display($a2)
	addi $a2, $a2, 248
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	addi $a2, $a2, 4
	sw $t0, display($a2)
	addi $a2, $a2, 256
	sw $t0, display($a2)
	addi $a2, $a2, 256
	sw $t0, display($a2)
	
	jr $ra
