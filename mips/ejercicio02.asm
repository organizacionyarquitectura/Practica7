.data
a: .word 5
b: .word 4
.text

main: 	# Preambulo main
	subi	$sp, $sp, 32	# 1 Reservar memoria para el marco
	sw	$ra, 16($sp)	# 3 Guardar $ra
	sw	$fp, 20($sp)	# 4 Guardar $fp
	addi	$fp, $sp, 24	# 4 Establecer $fp
	lw $a0, a 		# Guarda a en $a0
	lw $a1, b 		# Guada b en $a1
	
	# Invocacion de mist_1
	jal	mist_1		# 3 Brincar a subrutina
	# Retorno de mist_1
	move	$t0, $v0	# Copiar el valor de mist_1
	lw	$s0, 32($sp)	# Restaurar $s0 con el valor de a
	lw	$s0, 28($sp)	# Restaurar $t0 con el valor de b
	
	# Conclusion main
	lw	$ra, 16($sp)	# 3 Restaurar $ra
	lw	$fp, 20($sp)	# 4 Restaurar $fp
	
	
	# mist_1 recibe como argumentos $a0 y $a1
	move $a0, $t0 # Se pasa el argumento $a0
	move $a1, $t1 # Se pasa el argumento $a1

mist_1: # Preambulo mist_1
	subi	$sp, $sp, 32	# 1 Reservar memoria para el marco
	sw	$ra, 16($sp)	# 3 Guardar $ra
	sw	$fp, 20($sp)	# 4 Guardar $fp
	addi	$fp, $sp, 24	# 4 Establecer $fp
	
	move $s0, $a0
	move $t0, $a1
	li $t1, 1

loop_1: beqz $s0, end_1
	# Invocación de mist_0
	jal	mist_0	# 3 Brincar a subrutina
	
	move $a0, $t0 # Se pasa el argumento $a0
	move $a1, $t1 # Se pasa el argumento $a1
	
	# Retorno de mist_0
	move	$t0, $v0	# Copiar el valor de mist_0
	lw	$s0, 32($sp)	# Restaurar $s0 con el valor de a
	lw	$s0, 28($sp)	# Restaurar $t0 con el valor de b
	
	move $t1, $v0
	subi $s0, $s0, 1
	j loop_1
	
end_1: # Conclusion mist_1
	lw	$ra, 16($sp)	# 3 Restaurar $ra
	lw	$fp, 20($sp)	# 4 Restaurar $fp
	
	
	move $v0, $t1 # Se retorna el resultado en $v0
	
	# mist_0 recibe como argumentos $a0 y $a1
	move $a0, $t0 # Se pasa el argumento $a0
	move $a1, $t1 # Se pasa el argumento $a1

mist_0: # Preambulo mist_0
	subi	$sp, $sp, 32	# 1 Reservar memoria para el marco
	sw	$ra, 16($sp)	# 3 Guardar $ra
	sw	$fp, 20($sp)	# 4 Guardar $fp
	addi	$fp, $sp, 24	# 4 Establecer $fp

	mult $a0, $a1
	
	# Conclusion mist_0
	lw	$ra, 16($sp)	# 3 Restaurar $ra
	lw	$fp, 20($sp)	# 4 Restaurar $fp
	
	move	$t0, $v0	# Copiar el valor de mist_1
	lw	$s0, 32($sp)	# Restaurar $s0 con el valor de a
	lw	$s0, 28($sp)	# Restaurar $t0 con el valor de b
	
	mflo $v0 # Se retorna el resultado en $v0
