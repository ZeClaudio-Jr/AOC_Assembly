#Depois de desenvolver o algoritmo que calcula o resto de uma divisao, utilize-o como procedimento para um programa que verifica se um numero eh par ou impar.
#Entrada: Corresponde a um número inteiro positivo.
#Saída: Para cada caso, mostre uma mensagem indicando se o número é ímpar ou par. 
#Exemplo de entrada: 13. Saída correspondente: Impar



.data #Área para dados da memória principal. Especificação/declaração de variáveis.

	num: .asciiz "Digite um numero: " #O "\n" significa uma quebra de linha. O ".asciiz" serve para uma cadeia de caracteres
	par: .asciiz "\nPar" #O "\n" significa uma quebra de linha. O ".asciiz" serve para uma cadeia de caracteres
	impar: .asciiz "\nImpar" #O "\n" significa uma quebra de linha. O ".asciiz" serve para uma cadeia de caracteres
	

.text #Área para as instruções do programa. Local onde vamos colocar as instruções em si.

	# Exibicao da mensagem "num"
    	la $a0, num #Indica o endereço onde está a mensagem
    	li $v0, 4 #Instrução para impressão de string
    	syscall #Faça!

	li $v0, 5 #Instrucao para ler um numero inteiro
	syscall #Faça!
	
	#Como o valor $v0 sera usado depois, para que esse valor nao seja perdido, devera ser movido(salvo) para o registrador $a0.
	move $a0, $v0 
	
	#Um 2 eh passado como parametro no registrador $a1
	li $a1, 2
	
	jal resto_div #Eh chamada a funcao
	
	beq $v0, $zero, if #Se o resto ($v0) = 0, o procedimento seguinte eh pular para a LABEL if
	j else #Caso contrario, pula para LABEL else
	
	if:
	#No caso, sendo o resto igual a zero, o numero é par
	li $v0, 4 #Instrucao que ler string
	la $a0, par #A string PAR é guardada no registrador $a0
	syscall #Faça!
		
	#Encerrando o programa
	li $v0, 10 
	syscall #Faça!
	
	else:
	#O numero eh impar quando o resto nao eh igual a zero
	li $v0, 4 #Instrucao para imprimir string
	la $a0, impar #A string impar eh passada para o registrador $a0.
	syscall #Faça!
		
	#Encerramento do programa
	li $v0, 10
	syscall #Faça!
	
	resto_div:
	move $v0, $a0 #Inicialmente, o "resto" recebe o valor do "dividendo".Depois ele sera o retorno da funcao, o registrador $v0.
		
	#O quociente($t0) comeca recebendo 0
	li $t0, 0
		
	while: #Enquanto resto >= divisor, esse loop sera executado com o while
	blt $v0, $a1, exit_while #Se resto < divisor, o loop para e salta para o final do while
	#Se a condicao anterior nao for atendida, o loop vai continuar
	sub $v0, $v0, $a1 #Nessa instrucao, o valor do divisor eh retirado do resto
	addi $t0, $t0, 1 #Nessa instrucao ocorre o incremento do quociente em 1
		
	j while #Aqui acontece o retorno para o inicio do loop
		
		
	exit_while: #Saida do loop
		
	jr $ra #Endereço de retorno da função
