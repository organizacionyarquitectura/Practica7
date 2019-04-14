# Ejercicio 1
# Rutina que calcula recursivamente el coeficiente binomial de n en
# k utilizando la identidad de Pascal


# macros

# entrada de los números
###
.macro	scan_intr()
	li	$v0 5
	syscall
.end_macro
###


# fin de programa
###
	.macro fin
	li $v0 10
	syscall
	.end_macro
###

# imprimir entero
###
	.macro print_intr(%n)
	move	$t0 $v0
	move	$t1 $a0
	move	$a0 %n
	li	$v0 1
	syscall
	move	$v0 $t0
	move	$a0 $t1
	.end_macro
###

# preámbulo subrutina
###
	.macro pream

	# paso 1: reservar memoria para el marco
	subi $sp $sp 32
	# paso 2: almacenar registros guardados
	sw $s0 16($sp)
	sw $s1 20($sp)
	# paso 3: guardar dirección de retorno
	sw $ra 24($sp)
	# paso 4: respaldar y actualizar la dirección del marco
	sw $fp 28($sp)
	addi $fp $sp 28
	.end_macro
###

#conclusión subrutina
###
	.macro concl
	# paso 1: guardar resultados
	move $v0 $s0
	# paso 2: restaurar valores anteriores no temporales
	lw $s0 16($sp)
	lw $s1 20($sp)
	lw $ra 24($sp)
	lw $fp 28($sp)
	# paso 3: elimininar espacio del marco actual
	addi $sp $sp 32
	# paso 4: regresar a la subrutina invocadora
	jr $ra
	.end_macro
###

# invocación subrutina
###
	.macro invc(%n, %k)
	# paso 1: guardar los registros temporales
	sw $a0 ($sp)
	sw $a1 4($sp)
	# paso 2: pasar los argumentos a la subrutina
	move $a0 %n
	move $a1 %k
	# paso 3: pasar el control
	jal coef_bin
	.end_macro
	
###

# retorno subrutina
###
	.macro ret
	# paso 1: restaurar valores temporales
	lw $a0 ($sp)
	lw $a1 4($sp)
	.end_macro
###
	 
# programa
	.text
	#Introduce el valor de n
	scan_intr()
	move	$a0 $v0
	#Introduce el valor de k
	scan_intr()
	move	$a1 $v0
	#Invocación a coef
	jal	coef_bin 
	#Retorno de valores
	print_intr($v0) 
	#Fin del programa
	fin 

# subrutina para calcular el coeficiente binomial
coef_bin:	
	#preámbulo
	pream
	
	# casos base
	beqz	$a1 k0 
	beqz	$a0 n0
	
	# llamada recursiva coef_bin(n-1, k-1)
	subi $t0 $a0 1
	subi $t1 $a1 1
	invc($t0, $t1)
	#retorno
	ret
	
	move $s0 $v0
	
	# llamada recursiva coef_bin(n-1, k)
	subi $t0 $a0 1
	move $t1 $a1
	invc($t0, $t1)
	ret
	
	# caso recursivo: coef_bin(n, k) = coef_bin(n-1, k-1) + coef_bin(n-1, k)
	add $s0 $s0 $v0
	j done
	
	# coef (n, 0) = 1
k0:	li $s0 1
	j done
	
	# coef (0, k) = 0; k > 0
n0:	li $s0 0

done:	concl

