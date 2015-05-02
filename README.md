section .bss

	bufferExpresion:	resb buffExpresionLen
	buffExpresionLen:	equ 1024

	buffVar1:			resw 10
	buffVar1Len:		equ $ - buffVar1

	buffVar2:			resw 10
	buffVar2Len:		equ $ - buffVar2

	buffVar3:			resw 10
	buffVar3Len:		equ $ - buffVar3

	buffVar4:			resw 10
	buffVar4Len:		equ $ - buffVar4

	buffVar5:			resw 10
	buffVar5Len:		equ $ - buffVar5

	buffVar6:			resw 10
	buffVar6Len:		equ $ - buffVar6

	buffVar7:			resw 10
	buffVar7Len:		equ $ - buffVar7

	buffVar8:			resw 10
	buffVar8Len:		equ $ - buffVar8

	buffVar9:			resw 10
	buffVar9Len:		equ $ - buffVar9

	buffVar10:			resw 10
	buffVar10Len:		equ $ - buffVar10

	buffVar11:			resw 10
	buffVar11Len:		equ $ - buffVar11

	buffVar12:			resw 10
	buffVar12Len:		equ $ - buffVar12

	buffVar13:			resw 10
	buffVar13Len:		equ $ - buffVar13

	buffVar14:			resw 10
	buffVar14Len:		equ $ - buffVar14

	buffVar15:			resw 10
	buffVar15Len:		equ $ - buffVar15

	buffVar16:			resw 10
	buffVar16Len:		equ $ - buffVar16

	buffVar17:			resw 10
	buffVar17Len:		equ $ - buffVar17

	buffVar18:			resw 10
	buffVar18Len:		equ $ - buffVar18

	buffVar19:			resw 10
	buffVar19Len:		equ $ - buffVar19

	buffVar20:			resw 10
	buffVar20Len:		equ $ - buffVar20

section .data

	instruccion1: 		db 10,"******************************* Proyecto #2 *******************************",10,0
	lenInstruccion1: 	equ $ - instruccion1

	instruccion2: 		db 10,"      Escriba la expresión matématica con un máximo de 20 variables:",10,0
	lenInstruccion2:	equ $ - instruccion2

	Error1: 			db "            Expresión Algebraica inválida: Paréntesis incorrectos",10,0
	lenError1:			equ $ - Error1

	ErrorGen:			db "                         Expresión Algebraica inválida",10,0
	lenErrorGen:		equ $ - ErrorGen

	Msje:				db "Esta bien",0,10
	lenMsje:			equ $ - Msje


section .text

global _start

_start:

main:

	call comenzar

ExpAlg:

	call leerExpresion


	;==================================== RESTRICCIONES ====================================================

	call verificarComa
	call verificarParentesis
	

Vars:

	call leerVariables

Operar:

	jmp  exit

imprimir:				; rsi: Mensaje a imprimir, rdx: Longitud del mensaje

	mov rax,1			; file descriptor (sys_write)
	mov rdi,1			; system call number (std out)
	syscall
	ret

leerExpresion:

	mov rax, 0						; sys_read (code 0)
	mov rdi, 0						; file descriptor (code 0 stdin)
	mov rsi, bufferExpresion		; address to the buffer to read into
	mov rdx, buffExpresionLen		; number of bytes to read
	syscall
	ret

verificarParentesis:

	mov  r9,  0 ; Contador de validación de paréntesis
	mov  rcx, 0
	mov  rsi, 0

	.inicio:

		cmp r9, 0
		jl  .parentesisDesbalanceados
		cmp byte[bufferExpresion + rsi], 28h ; Si el caracter es un paréntesis abierto '('
		je  .incrementarR9
		cmp byte[bufferExpresion + rsi], 29h ; Si el caracter es un paréntesis cerrado ')'
		je  .decrementarR9
		jmp .next

	.incrementarR9:

		inc r9
		jmp .next

	.decrementarR9:

		dec r9
		jmp .next

	.parentesisDesbalanceados:
		
		mov  rsi, Error1
		mov  rdx, lenError1
		call imprimir
		jmp  exit

	.next:

		inc rsi
		inc rcx
		cmp rcx, rax 	; Compara el max de caracteres de la expresión dada, con el número de caracteres que ha leído
		jne .inicio
		cmp r9, 0
		jne .parentesisDesbalanceados
		ret

verificarComa:

	sub rax, 2
	xor rcx, rcx
	mov rsi, bufferExpresion

	.buscarComa:

		cmp byte[rsi + rcx], ','
		je .CompararFinal
		cmp rcx, rax
		je .Error  					; Ĺlegó al final y no había comas
		inc rcx
		jmp .buscarComa

	.CompararFinal:

		cmp rax, rcx
		jne .Error
		ret

	.Error:

		mov rsi, ErrorGen
		mov rdx, lenErrorGen
		call imprimir
		jmp exit

leerVariables: 

	.Var1:
		mov rax, 0						; sys_read (code 0)
		mov rdi, 0						; file descriptor (code 0 stdin)
		mov rsi, buffVar1
		mov rdx, buffVar1Len
		syscall
		mov rcx, 0
		call .ciclo
		cmp rcx, -1
		je .terminar

	.Var2:
		mov rax, 0						; sys_read (code 0)
		mov rdi, 0						; file descriptor (code 0 stdin)
		mov rsi, buffVar2
		mov rdx, buffVar2Len
		syscall
		mov rcx, 0
		call .ciclo
		cmp rcx, -1
		je .terminar 

	.Var3:
		mov rax, 0						; sys_read (code 0)
		mov rdi, 0						; file descriptor (code 0 stdin)
		mov rsi, buffVar3
		mov rdx, buffVar3Len
		syscall
		mov rcx, 0
		call .ciclo
		cmp rcx, -1
		je .terminar

	.Var4:
		mov rax, 0						; sys_read (code 0)
		mov rdi, 0						; file descriptor (code 0 stdin)
		mov rsi, buffVar4
		mov rdx, buffVar4Len
		syscall
		mov rcx, 0
		call .ciclo
		cmp rcx, -1
		je .terminar

	.Var5:
		mov rax, 0						; sys_read (code 0)
		mov rdi, 0						; file descriptor (code 0 stdin)
		mov rsi, buffVar5
		mov rdx, buffVar5Len
		syscall
		mov rcx, 0
		call .ciclo
		cmp rcx, -1
		je .terminar

	.Var6:
		mov rax, 0						; sys_read (code 0)
		mov rdi, 0						; file descriptor (code 0 stdin)
		mov rsi, buffVar6
		mov rdx, buffVar6Len
		syscall
		mov rcx, 0
		call .ciclo
		cmp rcx, -1
		je .terminar

	.Var7:
		mov rax, 0						; sys_read (code 0)
		mov rdi, 0						; file descriptor (code 0 stdin)
		mov rsi, buffVar7
		mov rdx, buffVar7Len
		syscall
		mov rcx, 0
		call .ciclo
		cmp rcx, -1
		je .terminar

	.Var8:
		mov rax, 0						; sys_read (code 0)
		mov rdi, 0						; file descriptor (code 0 stdin)
		mov rsi, buffVar8
		mov rdx, buffVar8Len
		syscall
		mov rcx, 0
		call .ciclo
		cmp rcx, -1
		je .terminar

	.Var9:
		mov rax, 0						; sys_read (code 0)
		mov rdi, 0						; file descriptor (code 0 stdin)
		mov rsi, buffVar9
		mov rdx, buffVar9Len
		syscall
		mov rcx, 0
		call .ciclo
		cmp rcx, -1
		je .terminar

	.Var10:
		mov rax, 0						; sys_read (code 0)
		mov rdi, 0						; file descriptor (code 0 stdin)
		mov rsi, buffVar10
		mov rdx, buffVar10Len
		syscall
		mov rcx, 0
		call .ciclo
		cmp rcx, -1
		je .terminar

	.Var11:
		mov rax, 0						; sys_read (code 0)
		mov rdi, 0						; file descriptor (code 0 stdin)
		mov rsi, buffVar11
		mov rdx, buffVar11Len
		syscall
		mov rcx, 0
		call .ciclo
		cmp rcx, -1
		je .terminar

	.Var12:
		mov rax, 0						; sys_read (code 0)
		mov rdi, 0						; file descriptor (code 0 stdin)
		mov rsi, buffVar12
		mov rdx, buffVar12Len
		syscall
		mov rcx, 0
		call .ciclo
		cmp rcx, -1
		je .terminar 

	.Var13:
		mov rax, 0						; sys_read (code 0)
		mov rdi, 0						; file descriptor (code 0 stdin)
		mov rsi, buffVar13
		mov rdx, buffVar13Len
		syscall
		mov rcx, 0
		call .ciclo
		cmp rcx, -1
		je .terminar

	.Var14:
		mov rax, 0						; sys_read (code 0)
		mov rdi, 0						; file descriptor (code 0 stdin)
		mov rsi, buffVar14
		mov rdx, buffVar14Len
		syscall
		mov rcx, 0
		call .ciclo
		cmp rcx, -1
		je .terminar

	.Var15:
		mov rax, 0						; sys_read (code 0)
		mov rdi, 0						; file descriptor (code 0 stdin)
		mov rsi, buffVar15
		mov rdx, buffVar15Len
		syscall
		mov rcx, 0
		call .ciclo
		cmp rcx, -1
		je .terminar

	.Var16:
		mov rax, 0						; sys_read (code 0)
		mov rdi, 0						; file descriptor (code 0 stdin)
		mov rsi, buffVar16
		mov rdx, buffVar16Len
		syscall
		mov rcx, 0
		call .ciclo
		cmp rcx, -1
		je .terminar

	.Var17:
		mov rax, 0						; sys_read (code 0)
		mov rdi, 0						; file descriptor (code 0 stdin)
		mov rsi, buffVar17
		mov rdx, buffVar17Len
		syscall
		mov rcx, 0
		call .ciclo
		cmp rcx, -1
		je .terminar

	.Var18:
		mov rax, 0						; sys_read (code 0)
		mov rdi, 0						; file descriptor (code 0 stdin)
		mov rsi, buffVar18
		mov rdx, buffVar18Len
		syscall
		mov rcx, 0
		call .ciclo
		cmp rcx, -1
		je .terminar

	.Var19:
		mov rax, 0						; sys_read (code 0)
		mov rdi, 0						; file descriptor (code 0 stdin)
		mov rsi, buffVar19
		mov rdx, buffVar19Len
		syscall
		mov rcx, 0
		call .ciclo
		cmp rcx, -1
		je .terminar

	.Var20:
		mov rax, 0						; sys_read (code 0)
		mov rdi, 0						; file descriptor (code 0 stdin)
		mov rsi, buffVar20
		mov rdx, buffVar20Len
		syscall
		mov rcx, 0
		call .ciclo
		cmp rcx, -1
		je .terminar

	.ciclo:
		cmp byte[rsi+rcx], 0; si llegue al final de lo que escribio y no encontre una coma
			je .salir
		cmp byte[rsi+rcx],','; si es una coma, se cambia de linea y termina el ciclo
			je .seguir
		inc rcx
		jmp .ciclo; continuo	

	.seguir:
		ret

	.salir:
		mov rcx, -1
		ret

	.terminar:
		ret

comenzar:

	mov rsi, instruccion1
	mov rdx, lenInstruccion1
	call imprimir

	mov rsi, instruccion2
	mov rdx, lenInstruccion2
	call imprimir

	ret

exit:

	mov rax, 60
	mov rdi, 0
	syscall

