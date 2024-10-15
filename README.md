[![Proteus](https://img.shields.io/badge/Proteus-%230079C1.svg?style=flat&logo=proteus&logoColor=white)](https://www.labcenter.com/)
[![Arduino IDE](https://img.shields.io/badge/Arduino%20IDE-%2300979D.svg?style=flat&logo=arduino&logoColor=white)](https://www.arduino.cc/)

# Bidirectional Visitor Counter using 8051 Microcontroller
Buildings where the lights are switched on throughout the whole day even when nobody is there results in inefficient lighting and energy wastage which needs to be mitigated using a bidirectional visitor counter.  

A bidirectional visitor counter and automatic room light controller using a 8051 microcontroller is a reliable circuit that takes over the task of controlling the room light as well as counting the number of persons visiting the room very accurately. This device that would perform two tasks simultaneously, it would count the number of people currently in the room and display it via a **16×2 LCD display**. Moreover, it will automatically adjust the lighting of the room based on the number of people present, according to a set standard. The **8051 MC** is programmed through **Keil Microvison**, in Assembly Language, interfaced with IR Sesnors and a LCD Display

## Working Principle 
The logic of the project is implemented by the 2 Infrared sensors. One of the sensors will be placed closer to the door and the one will be placed on the same level as the first one, but a little farther from the door. Initially, the output from the sensors will be logically low.

When a person enters the room, they will first make contact with the first IR sensor, which will trigger External Interrupt 0 (INT 0). This will run a program block to increment the counter by 1 and simultaneously give the data to the LCD display.

![image](https://github.com/user-attachments/assets/0709d73c-0402-4f15-bfaf-6d0a3fe17d69)

**Block Diagram Of the Project**

When a person exits the room, they will first make contact with the second IR sensor, away from the door, which will trigger External Interrupt 1(INT 1). This will run a program block to decrement the counter by 1 and simultaneously give the data to the LCD display.
Another Program block will check the counter:

1.	If the number of people in the room is < 20. LED 1 will turn on.
2.	If the number of people in the room is < 40. LED 1 and LED 2 will turn on.
3.	If the number of people in the room is <= 60. LED 1, LED 2 and LED 3 will turn on.

## Components 
This project would require an AT89C51 Microcontroller, which would act as the heart of the system. Other peripherals include-

1.)	2 Infrared sensors - To detect people entering and exiting the room. 
2.)	16×2 LCD display - To display the number of people currently in the room.
3.)	3 LEDs - To vary the lighting according to the number of people in the room.
4.)	Breadboard - To have a base for the components.
5.)	Single-strand wires - To make smooth connections between the peripherals.

![image](https://github.com/user-attachments/assets/98eba943-d50f-4d77-b071-58875c745cb4)

**Flowchart of the Bidirectional Visitor Counter Project**

There are certain constraints associated with the project including -
1.)	We will be using 3 LEDs to mimic the lighting system of a room. The room would be divided into 3 sections. Each section will light up based on the number of people present.
2.)	The Maximum number of people in the room will be 60.
3.)	The first person that enters the room would have to occupy the frontmost seat/space in the front zone. Only after the front zone is filled, then people can occupy seats in the middle zone and after that in the back zone.

## Software Simulation & Results
The internal code, used to program the 8051 Microcontroller was tested using Keil Microvison and then the Hardware Circuit on Proteus
```
org 0000h
	lcall main
	org 0030h
		mov r0,#00h
		counter:jb p0.0,out
				jb p3.4,up
				jb p3.5,down
			sjmp counter
			up: inc r0
			sjmp counter
			down: dec r0
			sjmp counter
			
			out:nop
			count: db r0
				
				mov a,#38h
				acall cmd1
				mov a,#0fh
				acall cmd1
				mov a,#01h
				acall cmd1
				mov a,#06h
				acall cmd1
				mov a,#80h
							
			acall cmd1
			mov dptr,#count
			repeat1000:clr a
			movc a,@a+dptr
			jz last22
			acall data11
			inc dptr
			sjmp repeat1000
			
			cmd1:acall ready1
			clr p2.0
			clr p2.1
			mov p1,a
			setb p2.2
			nop
			clr p2.2
			ret
			
			data11:acall ready1
			setb p2.0
			clr p2.1
			mov p1,a
			setb p2.2
			nop
			clr p2.2
			ret
			
			ready1:setb p1.7
			clr p2.0
			setb p2.1
			loop1:clr p2.2
			nop
			setb p2.2
			jb p1.7,loop1
			ret
			last22: ljmp last222
	main:
	mov a,#38h
	acall cmd
	mov a,#0fh
	acall cmd
	mov a,#01h
	acall cmd
	mov a,#06h
	acall cmd
	mov a,#80h
	
	acall cmd
	mov dptr,#text1
	repeat100:clr a
	movc a,@a+dptr
	jz last2
	acall data1
	inc dptr
	sjmp repeat100
		
	text1:db 'Welcome',0
	text2:db 'Entry Count Is',0	
		
	cmd:acall ready
	clr p2.0
	clr p2.1
	mov p1,a
	setb p2.2
	nop
	clr p2.2
	ret
	
	data1:acall ready 
	setb p2.0
	clr p2.1
	mov p1,a
	setb p2.2
	nop
	clr p2.2
	ret
	
	ready:setb p1.7
	clr p2.0
	setb p2.1
	loop:clr p2.2
	nop
	setb p2.2
	jb p1.7,loop
	ret
	
	last2:mov a,#0c0h
	acall cmd
	mov dptr,#text2
	repeat200:clr a
	movc a,@a+dptr
	jz finisher
	acall data1
	inc dptr
	sjmp repeat200
	
	
	finisher: nop
	mov r1,#0fh
	l1:mov r2,#0ffh
	l2:mov r3,#0ffh
	l3:djnz r3,l3
	djnz r2,l2
	djnz r1,l1
	ret
	last222:nop
	wait:sjmp wait
end
```


## **Proteus Simulation of the Project**
![Picture11](https://github.com/user-attachments/assets/a5507252-ed76-493e-b5ed-6010eb18f1e7)

