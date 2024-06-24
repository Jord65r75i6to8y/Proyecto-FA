.data
display: .space 16384       # Espacio para la pantalla
term1: .space 7             # Espacio para el primer número
operador: .space 1          # Espacio para el operador
term2: .space 7             # Espacio para el segundo número
hla: .asciiz "\n\n"         # Nueva línea
max_digits: .asciiz "99999999999999"  # Máximo dígitos para el número
result: .space 15           # Espacio para el resultado
invalid_op_message: .asciiz "Operador no válido. Fin del programa.\n"
.text
li $t0, 0x007f1c
.globl main

main:
    # Leer primer número
    la $a0, term1
    jal Leer_entrada

    # Mostrar primer número
    li $a1, 4
    li $a2, 16
    la $a3, term1
    jal print

    # Salto de línea
    li $v0, 4
    la $a0, hla
    syscall

    # Leer operador
    la $a0, operador
    jal Leer_entrada

    # Mostrar operador
    li $a1, 116
    li $a2, 16
    la $a3, operador
    jal print

    # Salto de línea
    li $v0, 4
    la $a0, hla
    syscall

    # Leer segundo número
    la $a0, term2
    jal Leer_entrada

    # Mostrar segundo número
    li $a1, 148
    li $a2, 16
    la $a3, term2
    jal print

    # Convertir term1 a entero
    la $a0, term1
    jal string_to_int
    move $t1, $v0  # Guardar entero en $t1

    li $v0, 4
    la $a0, hla
    syscall

    li $v0, 1
    move $a0, $t1
    syscall

    # Convertir term2 a entero
    la $a0, term2
    jal string_to_int
    move $t2, $v0  # Guardar entero en $t2
    
    li $v0, 4
    la $a0, hla
    syscall

    li $v0, 1
    move $a0, $t2
    syscall
    
    # Realizar operación
    la $a0, operador
    lb $t3, 0($a0)
    sub $t3, $t3, '0'
    
    li $t5, '+'   # Cargar el carácter '+'
    sub $t5, $t5, '0'
    beq $t3, $t5, suma
    li $t5, '-'   # Cargar el carácter '-'
    sub $t5, $t5, '0'
    beq $t3, $t5, resta
    li $t5, '*'   # Cargar el carácter '*'
    sub $t5, $t5, '0'
    beq $t3, $t5, multiplicacion
    li $t5, '/'   # Cargar el carácter '/'
    sub $t5, $t5, '0' 
    beq $t3, $t5, division

    # En caso de operador no válido, terminar el programa
    j invalid_operator

# Operaciones
suma:
    add $t4, $t1, $t2
    j imprimir_resultado

resta:
    sub $t4, $t1, $t2
    j imprimir_resultado

multiplicacion:
    mul $t4, $t1, $t2
    j imprimir_resultado

division:
    div $t4, $t1, $t2
    j imprimir_resultado
    
invalid_operator:
    li $v0, 4
    la $a0, hla
    syscall

    li $v0, 4
    la $a0, invalid_op_message
    syscall

    li $v0, 10
    syscall

imprimir_resultado:
    li $v0, 4
    la $a0, hla
    syscall

    li $v0, 1
    move $a0, $t4
    syscall

    li $v0, 10
    syscall
    
string_to_int:
    li $v0, 0        # Inicializar el resultado en 0
    li $t5, 10       # Constante para la base decimal (10)

convert_loop:
    lb $t1, 0($a0)   # Cargar el siguiente byte del string
    beqz $t1, end_convert  # Si es el byte nulo, terminar la conversión
    
    # Verificar si el carácter es un dígito válido ('0' a '9')
    li $t2, '0'
    li $t3, '9'
    blt $t1, $t2, end_convert # Si es menor que '0', terminar la conversión
    bgt $t1, $t3, end_convert  # Si es mayor que '9', terminar la conversión

    sub $t1, $t1, '0'  # Convertir el carácter a su valor numérico
    mul $v0, $v0, $t5  # Multiplicar el resultado actual por 10
    add $v0, $v0, $t1  # Añadir el valor del carácter al resultado
    addi $a0, $a0, 1   # Avanzar al siguiente carácter
    j convert_loop     # Repetir el bucle

end_convert:
    jr $ra  # Volver al llamador
    
Leer_entrada:
	li $t1, 0
	li $t2, 0xFFFF0004  # Dirección del teclado
	li $t3, 0xFFFF0000  
	
Loop_de_leer:
	lw $t4, 0($t3)       # lee el estado del teclado en loop
	andi $t4, $t4, 0x01  
	beqz $t4, Loop_de_leer 
	
	lb $t5, 0($t2)       
	sb $t5, 0($a0)       
	addi $a0, $a0, 1     
	li $t6, 0x0A         
	beq $t5, $t6, Fin_del_loop_de_leer  
	
	j Loop_de_leer          

Fin_del_loop_de_leer:
	sb $zero, 0($a0)     
	jr $ra

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
	
	

	
	
	
	