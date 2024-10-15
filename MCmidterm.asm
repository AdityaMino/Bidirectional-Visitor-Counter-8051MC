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