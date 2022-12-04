# Escreva um algoritmo que calcule a divisao inteira e o resto da divisao de dois numeros.
# Entrada: Ler dois números inteiros positivos correspondentes ao dividendo e o divisor.
# Saída: Consiste no resultado da divisão inteira, (quociente) e o resto da divisão: Exemplo de entrada: 10, 3. Saída correspondente: Quociente = 3; Resto = 1



.data	#Área para dados da memória principal. Especificação/declaração de variáveis.

	quociente: .asciiz "\nQuociente = "	#O "\n" significa uma quebra de linha. O ".asciiz" serve para uma cadeia de caracteres
	resto: .asciiz "\nResto = "	#O "\n" significa uma quebra de linha. O ".asciiz" serve para uma cadeia de caracteres
	dividendo: .asciiz "Digite o dividendo: " #O ".asciiz" serve para uma cadeia de caracteres
	divisor: .asciiz "Digite o divisor: " #O ".asciiz" serve para uma cadeia de caracteres

.text	 #Área para as instruções do programa. Local onde vamos colocar as instruções em si.
main:	#Facultativa sua escrita

    	# Exibicao do "dividendo"
    	la $a0, dividendo #indicar o endereço onde está a mensagem
    	li $v0, 4 #Instrução para impressão de string
    	syscall #Faça!
    	
	#Lendo o valor "dividendo":
	li $v0, 5 #Instrucao(li->5) que le o inteiro digitado
	syscall #Faça!
	
	#Como o valor $v0 sera usado depois, para que esse valor nao seja perdido, devera ser movido(salvo) para o registrador temporario $t0.
	move $t0, $v0	#$v0 sendo movido para um registrador temporario ($t0) para ser salvo
	
    	# Exibicao do "divisor"
    	la $a0, divisor #indicar o endereço onde está a mensagem
   	li $v0, 4 #Sera impressa na tela uma string
   	syscall #Faça!
   	
	#Lendo o valor "divisor":
	li $v0, 5 #Instrucao(li-5) que le o inteiro digitado
	syscall #Faça!
	   	
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
		
		
	exit_while: #Nessa posicao, o loop eh finalizado
	
	li $v0, 4 #Sera impressa na tela uma string
	la $a0, quociente  #indicar o endereço onde está a mensagem. Necessariamente, a string tem que esta no registrador $a0 para a impressao. A string da variavel quociente eh passada para esse registrador
	syscall #Faça!
	
	li $v0, 1 #Essa instrucao imprime na tela um inteiro
	move $a0, $s1 #O inteiro para ser impresso deve estar em $a0. Aqui o quociente ($s1) eh enviado para $a0.
	syscall #Faça!
	
	#Mesmo processo para imprimir o resto
	li $v0, 4  #Sera impressa na tela uma string
	la $a0, resto #Indica o endereço onde está a mensagem.
	syscall #Faça!
	
	li $v0, 1 #Sera impressa na tela um inteiro
	move $a0, $s0 #Aqui o resistrador $s0 será gravado em $a0.
	syscall #Faça!
	
	#Encerramento do programa
	li $v0, 10
