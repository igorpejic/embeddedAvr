/*
 * AssemblerApplication3.asm
 *
 *  Created: 26.10.2015. 20:39:31
 *   Author: User
 */ 

 .equ LED_PORT=PORTA
 .equ LED_PORT_DDR=DDRA
 .equ BUT_PORT=PORTB
 .equ BUT_PIN_DDR=PINB
 .def tmp=r23
 .def temp=r18
 .def mode=r26


 .cseg

 rjmp reset
 reset:
	ldi tmp, 0xff
	out LED_PORT_DDR, tmp
	ldi tmp, 0
	out BUT_PIN_DDR, tmp
ldi tmp, 0xff

mode0:

	ldi tmp, 0b01010101
	out LED_PORT, tmp
	rcall delay
	ldi tmp, 0b10101010
	out LED_PORT, tmp
	rcall delay
	ldi temp, 0x01
	in r24, BUT_PORT
	cp r24, temp
	breq increase
rjmp mode0

mode1:
	ldi temp, 0b00000001
	in r24, BUT_PORT
	cp r24, temp
	breq increase
	rol tmp
	out LED_PORT, tmp
	rcall delay
rjmp mode1

mode2:
	ldi temp, 0x01
	in r24, BUT_PORT
	cp r24, temp
	breq increase
	ldi tmp, 0b11111110
	rol tmp
	out LED_PORT, tmp
	rcall delay
rjmp mode2

increase:
	inc mode
	ldi temp, 0
	cp mode, temp
	breq mode0
	ldi temp, 1
	ldi tmp, 0b11111110
	cp mode, temp
	breq mode1
	ldi temp, 2
	cp mode, temp
	breq mode2
	clr mode
	clr tmp
	rjmp mode0

delay:
	clr r20
	clr r21
	clr r22
	
	delay_loop:
		dec r20
		brne delay_loop
		dec r21
		brne delay_loop
	ret