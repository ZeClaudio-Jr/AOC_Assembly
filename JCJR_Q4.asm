#Escreva o procedimento do programa ao lado que ordena um vetor com N posi��es e mostre os elementos desse vetor em ordem crescente.
#Entrada: A primeira linha da entrada consiste em um inteiro positivo N, que indica a quantidade de elementos que o vetor possui. As N linhas seguintes correspondem aos valores de cada elemento do vetor.
#Sa�da: Consiste de duas linhas, a primeira mostra os n�meros do vetor na sequ�ncia que foi lida e a segunda, os n�meros em ordem crescente.
#Exemplo de entrada: 5, 3, 7, 4, 8, 1. Sa�da correspondente: 3 7 4 8 1		1 3 4 7 8 


.data #�rea para dados da mem�ria principal. Especifica��o de algumas vari�veis.
	v: .asciiz "Digite o Tamanho do vetor: " #.asciiz serve para uma cadeia de caracteres
	element: .asciiz "Digite o elemento " #.asciiz serve para uma cadeia de caracteres
	element_S: .asciiz " do vetor: " #.asciiz serve para uma cadeia de caracteres
	blank: " " 
	_break:"\n"

.text #�rea para as instru��es do programa. Local onde vamos colocar as instru��es em si.
.globl main
main:
	li $t1,0 #valor de p
	jal tam_vetor
	jal read_vetor
	jal _break_
	jal Print_vetor
	jal _break_
	move $a0, $t1 #t1 armazena o valor de p
	move $a2,$s7 #s7 armazena o tamanho do vetor
	jal ord
	jal Print_vetor
	jal Exit

_break_:
	la  $a0,_break
	li $v0,4 #Instru��o para impress�o de string
	syscall #Fa�a!

	jr $ra #Endere�o de retorno da fun��o

Print_vetor:
	li $s1,0 # s1 vai ser o �ndece

loop:
	bge $s1,$s7,else
	sll $s2,$s1,2 
	addu $t0,$s0,$s2
	li $v0,4
	la $a0, blank
	syscall #Fa�a!

	lw $a0,($t0)
	li $v0,1
	syscall #Fa�a!

	addi $s1,$s1,1
	j loop

else:
	jr $ra #Endere�o de retorno da fun��o

tam_vetor:
	la $a0, v
	li $v0,4
	syscall #Fa�a!

	li $v0,5
	syscall #Fa�a!

	move $s7,$v0
	jr $ra #Endere�o de retorno da fun��o

read_vetor:
#Aloca��o de mem�ria
#Multiplicando o tamanho do vetor por 4, pois $a0 ir� receber o n�mero de bytes necess�rios, e um inteiro possui 4 bytes, logo
#TamVetor(n�mero de elemtos do vetor) x 4
	sll $t4,$s7,2 
	move $a0,$t4
	li $v0,9
	syscall #Fa�a!

	move $s0,$v0 # $s0 armazena a primeira posi��o de mem�ria alocada e consequentemente a nossa primeria posi��o do vetor

	li $s1, 0 # inicializando o registrador com o valor do indice

loop2:
	bge $s1,$s7,else
	# faz a o promt dos elementos do vetor
	la $a0, element
	li $v0,4
	syscall #Fa�a!

	addi $a0,$s1,1
	li $v0,1
	syscall #Fa�a!

	la $a0, element_S
	li $v0,4
	syscall #Fa�a!

	li $v0,5
	syscall #Fa�a!
	#Armazena os elementos do vetor na mem�ria alocada
	sll $t3,$s1,2 # vou multiplicar o indice por 4 e armazenar em $t3 o valor do offset onde deve ser armazenado o inteiro
	addu $a1, $s0, $t3 # somando o endere�o da memoria alocada na heap e somando com o offset
	sw $v0, ($a1)
	#Incremetando o �ndIce
	addi $s1,$s1,1
	j loop2

ord:
	# move $a0, $t1 #t1 armazena o valor de p
	# move $a1,$s0  # armazena o endere�o inicial do vetor
	# move $a2,$s7 #s7 armazena o tamanho do vetor

	addi $sp,$sp,-4 #Armazenei apenas o $ra pois n�o dependemos de nehum tipo de retorno do procedimento recursivo realizado anteriormente
	sw $ra, 0($sp) 
	bge $a0,$a2,return
	add $a3,$a0,$zero # a3 ir� armazenar nosso �ndice i.
	jal loop_3
	addi $a0,$a0,1
	jal ord

return:
	lw $ra, 0($sp) 
	addi $sp, $sp, 4
	jr $ra #Endere�o de retorno da fun��o

loop_3:
	bge $a3,$a2, volte
	addi $sp,$sp,-4
	sw $ra, 0($sp)
	#offset em rela��o ao �ndece i
	sll $t2,$a3,2
	#offset em rela��o ao �ndice p
	sll $t3,$a0,2
	#somando os offset
	addu $t4,$t2,$s0 # lembrando que $s0 armazena o emdere�o da mem�ria alocada  # $t4 armazena o endere�o i do vetor
	addu $t5,$t3,$s0 # lembrando que $s0 armazena o emdere�o da mem�ria alocada  # $t5 armazena o endere�o de p do vetor

	#trazendo os resultados dessas posi��es de mem�ria
	lw $s1, 0($t4) #$s1 armazena o conte�do de v[i]
	lw $s2, 0($t5) #$s2 armazena o conte�do de v[p]
	jal if
	addi $a3,$a3,1
	j loop_3

volte:
	lw $ra, 0($sp)
	addi $sp,$sp,4
	jr $ra #Endere�o de retorno da fun��o

if:
	bge $s1,$s2, else
	move $t6,$s1
	sw $t6, 0($t5)
	sw $s2, 0($t4)
	jr $ra #Endere�o de retorno da fun��o

Exit:
	li $v0,10
	syscall #Fa�a!
