#Escreva um algoritmo que calcule a divisao inteira e o resto da divisao de dois numeros.

.data	#Parte na qual se declara as variaveis

	quociente: .asciiz "\nQuociente = "	#O "\n" significa uma quebra de linha
	resto: .asciiz "\nResto = "	#O "\n" significa uma quebra de linha
	dividendo: .asciiz "Digite o dividendo: "
	divisor: .asciiz "Digite o divisor: "

.text	
main:

    	# Exibicao do "dividendo"
    	la $a0, dividendo
    	li $v0, 4
    	syscall
    	
	#Lendo o valor "dividendo":
	li $v0, 5 #Instrucao(li-5) que le o inteiro digitado
	syscall
	
	#Como o valor $v0 sera usado depois, para que esse valor nao seja perdido, devera ser movido(salvo) para o registrador temporario $t0.
	move $t0, $v0	#$v0 sendo movido para um registrador temporario ($t0) para ser salvo
	
    	# Exibicao do "divisor"
    	la $a0, divisor
   	li $v0, 4
   	syscall
   	
	#Lendo o valor "divisor":
	li $v0, 5 #Instrucao(li-5) que le o inteiro digitado
	syscall
	   	
	#Como o valor $v0 sera usado depois, para que esse valor nao seja perdido, devera ser movido(salvo) para o registrador temporario $t1(o $t0 já foi usado).
	move $t1, $v0	#$v0 sendo movido para um registrador temporario ($t1)
	
	#O resto nesse momento recebera o valor do dividendo(guardado em $t0). O registrador $s0 sera o utilizado para guardar o valor "dividendo".
	move $s0, $t0
	
	#$s1 sera o registrador destinado a receber o valor do "quociente". Inicialmente recebe o valor 0.
	li $s1, 0
	
	while: #Enquanto resto ($s0) >= divisor($t1) esse loop sera executado com o while
		blt $s0, $t1, exit_while #Se resto < divisor, o loop para e salta para o final do while
		##Se a condicao anterior nao for atendida, o loop vai continuar
		sub $s0, $s0, $t1 #Nessa instrucao, o valor do divisor eh retirado do resto
		addi $s1, $s1, 1 #Nessa instrucao ocorre o incremento do quociente em 1
		
		j while #Aqui acontece o retorno para o inicio do loop
		
		
	exit_while:  #Nessa posicao, o loop eh finalizado
	
	li $v0, 4  #Sera impressa na tela uma string
	la $a0, quociente  #Necessariamente, a string tem que estar no registrador $a0 para a impressao. A string da variavel quociente eh passada para esse registrador
	syscall
	
	li $v0, 1 #Essa instrucao imprime na tela um inteiro
	move $a0, $s1 #O inteiro para ser impresso deve estar em $a0. Aqui o quociente ($s1) eh enviado para $a0.
	syscall
	
	#Mesmo processo para imprimir o resto
	li $v0, 4  #Sera impressa na tela uma string
	la $a0, resto
	syscall
	
	li $v0, 1
	move $a0, $s0
	syscall
	
	#Encerramento do programa
	li $v0, 10
