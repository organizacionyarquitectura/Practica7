.data
a: .word 5
b: .word 4
.text

main: 	# Preambulo main
	subi	$sp, $sp, 24	# 1 Reservar memoria para el marco
	sw	$ra, 16($sp)	# 3 Guardar $ra
	sw	$fp, 20($sp)	# 4 Guardar $fp
	addi	$fp, $sp, 20	# 4 Establecer $fp
	# Invocacion de mist_1
	# Retorno de mist_1
	# Conclusion main
	lw	$ra, 16($sp)	# 3 Restaurar $ra
	lw	$fp, 20($sp)	# 4 Restaurar $fp
	j	finmain		# Final del programa	
	# mist_1 recibe como argumentos $a0 y $a1
	lw $a0, a
	lw $a1, b

mist_1: # Preambulo mist_1
	move $s0, $a0
	move $t0, $a1
	li $t1, 1

loop_1: beqz $s0, end_1
	# Invocación de mist_0
	move $a0, $t0 # Se pasa el argumento $a0
	move $a1, $t1 # Se pasa el argumento $a1
	# Retorno de mist_0
	move $t1, $v0
	subi $s0, $s0, 1
	j loop_1
	
end_1: # Conclusion mist_1
	move $v0, $t1 # Se retorna el resultado en $v0
	# mist_0 recibe como argumentos $a0 y $a1

mist_0: # Preambulo mist_0
	mult $a0, $a1
	# Conclusion mist_0
	mflo $v0 # Se retorna el resultado en $v0