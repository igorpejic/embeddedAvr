

/*
 * AssemblerApplication3.asm
 *
 *  Created: 26.10.2015. 20:39:31
 *   Author: User
 */ 

.equ LED_PORT=PORTA
.equ LED_PORT_DDR=DDRA
.equ BUT_DDR=DDRB
.equ BUT_PIN=PINB

.def tmp=r16
.def temp=r17
.def mode=r19
;init
	ldi tmp, 0xff
	out LED_PORT_DDR, tmp
	ldi tmp, 0x00
	out BUT_DDR, tmp
	ldi tmp, low(RAMEND)
	out SPL, tmp
	ldi tmp, high(RAMEND)
	out SPH, tmp
	ldi tmp, 0b00000001
main1:
	rcall delay
	
	ldi tmp, 0x0f
	out LED_PORT, tmp
	rcall delay
	ldi tmp, 0xf0
	out LED_PORT, tmp
	rcall delay
	rcall btnchk
	ldi temp, 0x01
	cp mode, temp
	brne main2
rjmp main1

main2:
	ldi tmp, 0x01
	loop2:
		rol tmp
		out LED_PORT, tmp
		rcall delay
		rcall btnchk
		ldi temp, 0b10000000
		cp mode, temp
		brne main1
		

		cp temp, tmp
		brne loop2
		ldi tmp, 0b00000001

rjmp main2

btnchk:
	in r18, BUT_PIN
	sbrs r18, 0
	ret
	ldi temp, 1
	eor mode, temp
	ret

delay:
	clr r20
	clr r21
	ldi r22, 20
	loop:
		dec r20
		brne loop
		dec r21
		brne loop
		dec r22
		brne loop
	ret