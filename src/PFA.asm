.data
# Sección de Datos
# En esta sección se declaran las variables y se reserva espacio en memoria para varios elementos 
# utilizados en el programa. Esto incluye espacio para la pantalla, los números ingresados, el operador 
# y otros elementos necesarios para la ejecución del programa.
display: .space 16384       # Espacio para la pantalla
term1: .space 7             # Espacio para el primer número
operador: .space 1          # Espacio para el operador
term2: .space 7             # Espacio para el segundo número
hla: .asciiz "\n\n"         # Nueva línea
max_digits: .asciiz "9999999999999" 
result: .space 14
invalid_op_message: .asciiz "Operador no válido. Fin del programa.\n"
.text
li $t0, 0x007f1c
.globl main


# Sección de Texto
# En esta sección se encuentra el código que se ejecuta. Aquí se define el punto de entrada del 
# programa, las instrucciones para leer y escribir datos, y las operaciones necesarias para realizar el 
# cálculo solicitado por el usuario. Esta sección también contiene el manejo de errores y la lógica para
# cálculo solicitado por el usuario. Esta sección también contiene el manejo de errores y la lógica para
# realizar operaciones aritméticas basadas en el operador ingresado.
main:
 
    la $a0, term1
    jal Leer_entrada

  
    li $a1, 4
    li $a2, 16
    la $a3, term1
    jal print


    li $v0, 4
    la $a0, hla
    syscall

 
    la $a0, operador
    jal Leer_entrada


    li $a1, 116
    li $a2, 16
    la $a3, operador
    jal print

    
    li $v0, 4
    la $a0, hla
    syscall

  
    la $a0, term2
    jal Leer_entrada

   
    li $a1, 148
    li $a2, 16
    la $a3, term2
    jal print


    la $a0, term1
    jal string_to_int
    move $a1, $v0  

    li $v0, 4
    la $a0, hla
    syscall
    
   
    la $a0, term2
    jal string_to_int
    move $a2, $v0 
    
    li $v0, 4
    la $a0, hla
    syscall

  
    la $a0, operador
    lb $t3, 0($a0)
    sub $t3, $t3, '0'
    
    li $t5, '+'   
    sub $t5, $t5, '0'
    beq $t3, $t5, suma
    li $t5, '-'   
    sub $t5, $t5, '0'
    beq $t3, $t5, resta
    li $t5, '*'   
    sub $t5, $t5, '0'
    beq $t3, $t5, multiplicacion
    li $t5, '/'   
    sub $t5, $t5, '0' 
    beq $t3, $t5, division
    li $t5, 'v'
    sub $t5, $t5, '0' 
    beq $t3, $t5, OperationRoot
    li $t5, '%'
    sub $t5, $t5, '0' 
    beq $t3, $t5, OperationMod
    li $t5, 'L'
    sub $t5, $t5, '0' 
    beq $t3, $t5, OperationLog

    
    j invalid_operator

# Sección de Procesamiento de Datos:
# En esta parte del código, se realiza el procesamiento de los datos ingresados. Dependiendo del 
# operador ingresado (+, -, *, /), se ejecuta la operación aritmética correspondiente entre los dos
# números ingresados.

suma:
    add $t4, $a1, $a2
    j imprimir_resultado

resta:
    sub $t4, $a1, $a2
    j imprimir_resultado

multiplicacion:
    mul $t4, $a1, $a2
    j imprimir_resultado

division:
    div $t4, $a1, $a2
    j imprimir_resultado
    
OperationRoot:
    li $t4, 0         

root_loop:
    mul $t5, $t4, $a1   
    bge $t5, $a2, end_root  
    
    addi $t4, $t4, 1    
    j root_loop        

end_root:
    bne $t5, $a2, RootSubstract   
    j imprimir_resultado          

RootSubstract:
    subi $t4, $t4, 1    
    j imprimir_resultado            
    
OperationMod:
    div $a1, $a2       
    mfhi $t4           
    j imprimir_resultado
     
OperationLog:
    li $t4, 1           

log_loop:
    mul $t5, $a2, $a2   
    bge $t5, $a1, end_log  
    
    addi $t4, $t4, 1    
    j log_loop         

end_log:
    subi $t4, $t4, 1   
    jr $ra              
        

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

	bgt $t4, 99999999999999, seccionB 
	move $a0, $t4
	la $a1, result
	jal int_to_string
	
	li $v0, 4
	la $a0, result
	syscall
	
	li $t0, 0x007f1c
	li $a1, 1568
	li $a2, 16
	la $a3, result 
	jal print
	j lastEnd
	
	seccionB:
	
	li $t0, 0x007f1c
	li $a1, 1568
	li $a2, 16
	la $a3, max_digits
	jal print
	
	lastEnd:
	
	li $v0, 10 
	syscall
    
int_to_string:
    move $t0, $a0      
    li $t2, 10       
    la $t3, result + 14 
    li $t4, 0           
    sb $zero, -1($t3)   

convert_loop:
    beqz $t0, check_zero   
    div $t0, $t0, $t2     
    mfhi $t5              
    addi $t5, $t5, '0'    
    subi $t3, $t3, 1       
    sb $t5, 0($t3)        
    addi $t4, $t4, 1       
    j convert_loop      

check_zero:
    bnez $t4, store_string 
    li $t5, '0'           
    subi $t3, $t3, 1       
    sb $t5, 0($t3)      

store_string:
    move $a2, $t3         
    move $a3, $a1         

copy_loop:
    lb $t6, 0($a2)         
    beqz $t6, end_copy     
    sb $t6, 0($a3)         
    addi $a2, $a2, 1     
    addi $a3, $a3, 1       
    j copy_loop           

end_copy:
    sb $zero, 0($a3)      
    jr $ra                 
    
string_to_int:
    li $v0, 0        
    li $t5, 10       

convert_loopINT:
    lb $t1, 0($a0)   
    beqz $t1, end_convert  
    
    li $t2, '0'
    li $t3, '9'
    blt $t1, $t2, end_convert 
    bgt $t1, $t3, end_convert  

    sub $t1, $t1, '0'  
    mul $v0, $v0, $t5  
    add $v0, $v0, $t1 
    addi $a0, $a0, 1  
    j convert_loopINT    

end_convert:
    jr $ra
    
# Sección de Lectura de Entrada
# Esta sección se encarga de leer la entrada del usuario, es decir, los números y el operador. Aquí se 
# asegura que los números ingresados sean válidos y maneja cualquier error que pueda ocurrir 
# durante la entrada.
    
Leer_entrada:
	li $t1, 0
	li $t2, 0xFFFF0004  
	li $t3, 0xFFFF0000  
	
Loop_de_leer:
	lw $t4, 0($t3)       
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
# Sección de Configuración de la Pantalla
# En esta sección, se configura la pantalla y se define cómo se mostrarán los números y los resultados
# de las operaciones. Se especifica la ubicación de los datos en la pantalla y se prepara para recibir la 
# entrada del usuario.
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