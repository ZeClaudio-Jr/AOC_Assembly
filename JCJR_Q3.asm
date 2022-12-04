#Escreva um procedimento recursivo que calcule a exponencial de um numero.
#Entrada: Consiste de dois n�meros inteiros positivos, a base e o expoente respectivamente.
#Sa�da: O n�mero que corresponde ao resultado dessa opera��o: 
#Exemplo de entrada: 2, 8. Sa�da correspondente: 256

.data #�rea para dados da mem�ria principal. Especifica��o/declara��o de vari�veis.
	Base: .asciiz "Insira o numero inteiro positivo corresponente a base: " #O "\n" significa uma quebra de linha. O ".asciiz" serve para uma cadeia de caracteres
	Expoente: .asciiz "\nInsira o numero inteiro positivo corresponente ao expoente: " #O "\n" significa uma quebra de linha. O ".asciiz" serve para uma cadeia de caracteres
	Resultado: .asciiz "\nResultado = " #O "\n" significa uma quebra de linha. O ".asciiz" serve para uma cadeia de caracteres

.text  #�rea para as instru��es do programa. Local onde vamos colocar as instru��es em si.
main:

	# Exibir mensagem base
	la $a0, Base #Indica o endere�o onde est� a mensagem
	li $v0, 4 #Instru��o para impress�o de string
	syscall #Fa�a!

	# Ler o inteiro inserido (base) 
	li $v0, 5 #Instrucao para ler um numero inteiro
	syscall #Fa�a!
    
	# Salva base em $s0
	move $s0, $v0 #Como o valor $v0 sera usado depois, para que esse valor nao seja perdido, devera ser movido(salvo) para o registrador $s0.

	#Exibir mensagem expoente
	la $a0, Expoente #Indica o endere�o onde est� a mensagem
	li $v0, 4 #Instru��o para impress�o de string
	syscall #Fa�a!

	#Ler o inteiro inserido (expoente)
	li $v0, 5 #Instrucao para ler um numero inteiro
	syscall #Fa�a!
    
	#Salva o expoente ($v0) em $s1
	move $s1, $v0

	move $t0, $s0 # resultado = base
	subi $t1, $s1, 1 #O aux ser� igual ao expoente menos 1. (aux = expoente - 1)
	jal power # Eh chamado o procedimento

	#Exibir mensagem resultado
	li $v0, 4 #Instru��o para impress�o de string
	la $a0, Resultado #Indica o endere�o onde est� a mensagem
	syscall #Fa�a!
    
	li $v0, 1 # Imprimir resutado
	la $a0, ($t0) #Carrega o valor do endereco do resultado
	syscall #Fa�a!

	#Encerramento do programa
	li $v0, 10
	syscall #Fa�a!

.text #�rea para as instru��es do programa. Local onde vamos colocar as instru��es em si.
power:

	bne $s1, $zero, else #Caso expoente seja diferente de zero (!= zero), Else � usado
	li $t0, 1 #Resultado sera igual a 1 (= 1)
	jr $ra #Desvia e salva o endereco de retorno do procedimento em $ra 
else: 
	mul  $t0, $t0, $s0 # resultado = resultao * base
	subi $t1, $t1, 1 #Aux -- (menos o immed, de valor 1)
	bne  $t1, $zero, power #Caso aux seja diferente de zero (!= zero), power � usado
	jr $ra #Desvia e salva o endereco de retorno do procedimento em $ra
exit: 
