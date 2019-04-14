# Ejercicio 2
# Programa misterioso que obtiene la potencia de un número en base a otro
# b elevado a un número a (b^a)

.data
a: .word 5
b: .word 4

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

.text

main: 	# Preambulo main
	subi	$sp, $sp, 32	# 1 Reservar memoria para el marco
	sw	$ra, 16($sp)	# 3 Guardar $ra
	sw	$fp, 20($sp)	# 4 Guardar $fp
	addi	$fp, $sp, 24	# 4 Establecer $fp
	
	# Invocacion de mist_1
	lw $a0, a 		# Guarda a en $a0
	lw $a1, b 		# Guada b en $a1
	jal	mist_1		# 3 Brincar a subrutina
	
	# Retorno de mist_1
	move	$t0, $v0	# Copiar el valor de mist_1
	print_intr($v0)
	
	# Conclusion main
	lw	$ra, 16($sp)	# 3 Restaurar $ra
	lw	$fp, 20($sp)	# 4 Restaurar $fp
	fin 
	
	#Para este punto, la rutina ya termino, por lo que lo siguiente no se ejecuta
	# mist_1 recibe como argumentos $a0 y $a1
	#move $a0, $t0 # Se pasa el argumento $a0
	#move $a1, $t1 # Se pasa el argumento $a1

mist_1: # Preambulo mist_1
	subi	$sp, $sp, 40	# 1 Reservar memoria para el marco
	sw	$s0, 16($sp)	# 3 Guardar $ra
	sw	$ra, 20($sp)	# 4 Guardar $fp
	sw	$fp, 24($sp)
	addi	$fp, $sp, 36	# 4 Establecer $fp
	
	
	move 	$s0, $a0
	move 	$t0, $a1
	li 	$t1, 1

loop_1: beqz $s0, end_1
	# Invocación de mist_0
	sw	$t0, 28($sp) # Guardando registros temporales
	sw	$t1, 32($sp) # Guardando registros temporales
	
	move 	$a0, $t0 # Se pasa el argumento $a0
	move 	$a1, $t1 # Se pasa el argumento $a1
	jal	mist_0	# 3 Brincar a subrutina
	
	# Retorno de mist_0
	lw	$t0, 28($sp)	# Restaurar $s0 con el valor de a
	lw	$t1, 32($sp)	# Restaurar $t0 con el valor de b
	
	move $t1, $v0
	subi $s0, $s0, 1
	j loop_1
	
end_1: # Conclusion mist_1
	move $v0, $t1 # Se retorna el resultado en $v0
	lw	$s0, 16($sp)	# 3 Restaurar $ra
	lw	$ra, 20($sp)	# 4 Restaurar $fp
	lw 	$fp, 24($sp)
	addi	$sp, $sp, 40
	jr	$ra
	
	#Para este punto, la rutina ya termino, por lo que lo siguiente no se ejecuta
	# mist_0 recibe como argumentos $a0 y $a1
	#move $a0, $t0 # Se pasa el argumento $a0
	#move $a1, $t1 # Se pasa el argumento $a1

mist_0: # Preambulo mist_0
	subi	$sp, $sp, 32	# 1 Reservar memoria para el marco
	sw	$ra, 16($sp)	# 3 Guardar $ra
	sw	$fp, 20($sp)	# 4 Guardar $fp
	addi	$fp, $sp, 28	# 4 Establecer $fp
	
	mult $a0, $a1
	mflo $v0 # Se retorna el resultado en $v0
	
	# Conclusion mist_0
	lw	$ra, 16($sp)	# 3 Restaurar $ra
	lw	$fp, 20($sp)	# 4 Restaurar $fp
	addi	$sp, $sp 32
	jr $ra
	
	
	
