.data
display: .space 16384     # Reserva 16384 bytes para display
term1: .space 5           # Reserva 5 bytes para el primer término
operador: .space 1        # Reserva 1 byte para el operador
term2: .space 5           # Reserva 5 bytes para el segundo término
hla: .asciiz "\n\n"       
.text
li $t0, 0x007f1c # Carga en $t0 el valor 0x007f1c
main:
   # Leer primer número
	la $a0, term1         # Carga la dirección de term1 en $a0
 	jal Leer_entrada      # Salta a la subrutina Leer_entrada
	
    	li $a1, 0             
    	li $a2, 16            
    	la $a3, term1         # Carga la dirección de term1 en $a3
    	jal print             # Llama al sistema para imprimir
	
	li $v0, 4
	la $a0, hla		# Carga la dirección de hla en $a0
	syscall
	
	#operador
	la $a0, operador	# Carga la dirección de "operador" en $a0
	jal Leer_entrada
	
	li $a1, 80
	li $a2, 16
	la $a3, operador
	jal print

	li $v0, 4
	la $a0, hla
	syscall
	
	# segundo número
	la $a0, term2
	jal Leer_entrada
	
	li $a1, 112
	li $a2, 16
	la $a3, term2
	jal print
	
	li $v0, 10
	syscall 

# Subrutina para leer entrada del teclado
Leer_entrada:
	li $t1, 0
	li $t2, 0xFFFF0004  # Dirección del teclado
	li $t3, 0xFFFF0000  # Dirección del estado del teclado
	
Loop_de_leer:
	lw $t4, 0($t3)       # lee el estado del teclado en loop (en la direccion de t3)
	andi $t4, $t4, 0x01  # AND lógico con 0x01 para verificar si hay entrad
	beqz $t4, Loop_de_leer # condicional de, si $t4 es cero se repite el loop
	
	lb $t5, 0($t2)      # Lee un byte del teclado (con la direccion del estado actual del teclado)
	sb $t5, 0($a0)       # Almacena el byte leído en la dirección de $a0
	addi $a0, $a0, 1     
	li $t6, 0x0A         # Carga el valor de nueva línea en $t6 (con el valor de ASCII)
	beq $t5, $t6, Fin_del_loop_de_leer  # Si se lee nueva línea, fin del loop
	
	j Loop_de_leer          

Fin_del_loop_de_leer:
	sb $zero, 0($a0)     # Almacena 0 en la dirección de $a0 (termina la cadena)
	jr $ra			# Retorna a la dirección de retorno (en el jal)

print:
	li $t1, 0
	move $t5, $ra		# Copia la dirección de retorno a $t5
	
	print_loop:

		lb $t2, 0($a3)		# Lee un byte de la dirección en $a3
		beqz $t2, exit_loop	# Si $t2 es cero, termina el loop

		sub $t2, $t2, '0' 	# Convierte el carácter a número
	
		mul $t4, $t1, $a2      # Multiplica $t1 por $a2 y guarda el resultado en $t4
		add $t3, $t4, $a1	# Suma $a1 a $t4 y guarda el resultado en $t3
		li $t6, 0

		bne $t2, $t6, number_1	 # Si $t2 no es 0, salta a number_1
		jal print_0
number_1:	addi $t6, $t6, 1
		bne $t2, $t6, number_2	# Si $t2 no es 1, salta a number_2
		jal print_1
number_2:	addi $t6, $t6, 1
		bne $t2, $t6, number_3	# Si $t2 no es 1, salta a number_3
		jal print_2
number_3:	addi $t6, $t6, 1
		bne $t2, $t6, number_4 # Si $t2 no es 1, salta a number_4
		jal print_3
number_4:	addi $t6, $t6, 1
		bne $t2, $t6, number_5 # Si $t2 no es 1, salta a number_5
		jal print_4
number_5:	addi $t6, $t6, 1
		bne $t2, $t6, number_6 # Si $t2 no es 1, salta a number_6
		jal print_5
number_6:	addi $t6, $t6, 1
		bne $t2, $t6, number_7 # Si $t2 no es 1, salta a number_7
		jal print_6
number_7:	addi $t6, $t6, 1
		bne $t2, $t6, number_8 # Si $t2 no es 1, salta a number_8
		jal print_7
number_8:	addi $t6, $t6, 1
		bne $t2, $t6, number_9 # Si $t2 no es 1, salta a number_9
		jal print_8
number_9:	addi $t6, $t6, 1
		bne $t2, $t6, mod
		jal print_9
mod:		addi $t6, $t6, -20
		bne $t2, $t6, Mult # Si $t2 no es '%', salta a Mult
		jal print_Mod
Mult:		addi $t6, $t6, 5
		bne $t2, $t6, plus # Si $t2 no es '*', salta a plus
		jal print_Mult
plus:		addi $t6, $t6, 1
		bne $t2, $t6, substract # Si $t2 no es '+', salta a substract
		jal print_plus
substract:	addi $t6, $t6, 2
		bne $t2, $t6, Division # Si $t2 no es '-', salta a Division
		jal print_substract
Division:	addi $t6, $t6, 2
		bne $t2, $t6, log # Si $t2 no es '/', salta a log
		jal print_Division
log:		addi $t6, $t6, 29
		bne $t2, $t6, pow # Si $t2 no es '??', salta a pow
		jal print_log
pow:		addi $t6, $t6, 18
		bne $t2, $t6, root # Si $t2 no es '^', salta a substract
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
	
	

	
	
	
	
