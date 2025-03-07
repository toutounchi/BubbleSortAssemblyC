.pos 0x1000


                    ld $0, r0       #r0 = y'
                    ld $n, r1       #r1 = &n
                    ld (r1), r1     #r1 = n
                    ld $s, r2       #r2 = &*s
                    ld (r2), r2       #r2 = *s


Valid_Iter:         mov r0, r3     #r3 = y'
                    not r3          #r3 = -y' -1
                    inc r3          #r3 = -y'
                    add r1, r3      #r3 = n - y'
                    bgt r3, INNER_FL #gotto INNERFL if (n-y > 0)
                    br END_AVG      #gotto END_AVG


INNER_FL:            ld $0, r6        #r6 = 0 = x'
Valid_AVG:          ld $4, r5        #r5 = 4
                    mov r6, r4       #r4 = x'
                    not r4           #r4 = -x' -1
                    inc r4           #r4 = -x'    
                    add r5, r4       #r4 = 4-x
                    bgt r4, LOOP_AVG #gotto LOOP_AVG if (0 < 4-x)         
                    br LOOP_END      #else gotto LOOP END

LOOP_AVG:           ld 4(r2), r7     #r7 = s[1]
                    ld 8(r2), r4     #r4 = s[2]
                    add r7, r4       #r4 = s[1] + s[2]
                    ld 12(r2), r7    #r7 = s[3]
                    add r7, r4       #r4 = s[1] + s[2] + s[3]
                    ld 16(r2), r7    #r7 = s[4]
                    add r7, r4       #r4 = s[1] + s[2] + s[3] + s[4]
                    shr $2, r4       #r4 = AVG
                    st  r4, 20(r2)   #s->average = r4

                    inc r6           #x'++
                    br  Valid_AVG    #gotto Valid_AVG

LOOP_END:           ld  $24, r4     #r4 = 24
                    add r4, r2      #r2 = next*s
                    inc r0          #y'++
                    br Valid_Iter   #gotto Validation for iteration over pointer

END_AVG:            br BUBBLE_SORT  #gotto BUBBLE_SORT to initialize sorting
END_OUT_LOOP:       j END           #gotto END (helper for outer Loop)

BUBBLE_SORT:        ld $s, r0       #r0 = &s
                    ld (r0), r0     #r0 = s
                    ld $n, r1       #r1 = &n
                    ld (r1), r1     #r1 = n
                    dec r1          # i' = n - 1 (Number of elements we want to go trough)

OUTER_LOOP:         beq r1, END_OUT_LOOP #gotto END_OUT_LOOP if (n-1 == 0)
                    ld $1, r2       #r2 = 1 
                    mov r1, r3      #r3 = n 
                    not r3          #r3 = -n - 1
                    ld $0, r4       #r4 = 0 = j' 


INNER_LOOP:         mov r3, r5         # r5 = -n
                    add r2, r5         # r5 = i -n
                    beq r5, END_INNER_LOOP   #gotto END_INNER_LOOP if (i-n == 0)
                    mov r2, r5         # r5 = j
                    mov r2, r6         # r6 = j
                    shl $3, r5         # r5 = j * 8
                    shl $4, r6         # r6 = j * 16
                    add r6, r5         # r5 = j * 24 (Explained in the end section)
                    ld $s, r6          # r6 = &s
                    ld (r6), r6        # r6 = s
                    add r5, r6         # r6 = s +  (j * 24)
                    mov r6, r7         # s + j => r7
                    mov r7, r4         # r7 = j'
                    ld $-24, r5        # r5 = -24
                    add r5, r6         # r6 = s[j * 24] - 24
                    ld $20, r5         #r5 = 20
                    add r5, r6         # r6 = &s[j]->average 
                    ld (r6), r6        # r6 = s[j]->average
                    add r5, r7         # r7 = &s[j -1]->average 
                    ld (r7), r7        # r7 = s[j -1]->average 
                    not r7             # r7 = -(s[j -1]->average) -1 
                    inc r7             # r7 = -(s[j -1]->average)
                    add r6, r7         # r7 = s[j]->average -(s[j -1]->average)
                    bgt r7, SWAP
                    
NEXT_OUTER:         inc r2              #j++
                    j INNER_LOOP        #gotto INNER_LOOP
END_INNER_LOOP:        dec r1           #n--
                    j OUTER_LOOP        #gotto OUTER_LOOP
SWAP:
                    ld $-24, r6     #r6 = -24
                    add r4, r6      # &s[y'] - 24 last element in array
                    ld $-6, r5       #r5 = -6(number of times we have to loop to completely copy content)

SWAP_ITER:          beq r5, END_SWAP_ITER #gotto end_swap_loo 
                    ld (r4), r0      #r0 = s[y'->next] first element
                    ld (r6), r7      #r7 = s[y'->prev] first element
                    st r7, (r4)      #Swap
                    st r0, (r6)      #swap      
                    inca r4          #r4 = &s[y'->next] next element 
                    inca r6          #r7 = s[y'->prev] next element
                    inc r5           #n--
                    br SWAP_ITER    #gotto SWAP_ITER

END_SWAP_ITER:      j NEXT_OUTER


END:                ld $n, r0       #r0 = &n
                    ld (r0), r1     #r1 = n
                    shr $1 , r1		#r1 = n/2 the value that lies in the middle (median)			
				    mov r1 , r2     #r2 = n/2
				    shl $3 , r1     #r1 = n/2 * 8
				    shl $4 , r2     #r2 = n/2 * 16
				    add r2 , r1		#r1 = n/2 (8 + 16) = n/2* 24		median position
                    ld  $s, r4      #r4 = &s
                    ld (r4), r4     #r4 = *s
				    add r1, r4 		#r0 = &s->sid for the median
				    ld (r4) , r0	#r0 = s->sid for the median
				    ld $m , r3		#r3 = &m
				    st r0 , (r3)	#m = s->sid for the median
				
				    halt





.pos 0x2000

n:      .long 4       # just one student
m:      .long 0       # put the answer here
s:      .long base    # address of the array
base:   .long 1234    # student ID      base[0]
        .long 80      # grade 0
        .long 60      # grade 1
        .long 78      # grade 2
        .long 90      # grade 3
        .long 0       # computed average        
        .long 1234    # student ID      base[1]
        .long 50      # grade 0
        .long 60      # grade 1
        .long 78      # grade 2
        .long 100      # grade 3
        .long 0       # computed average   
        .long 1234    # student ID      base[2]
        .long 80      # grade 0
        .long 20      # grade 1
        .long 78      # grade 2
        .long 40      # grade 3
        .long 0       # computed average   
        .long 1234    # student ID      base[3]
        .long 80      # grade 0
        .long 90      # grade 1
        .long 78      # grade 2
        .long 30      # grade 3
        .long 0       # computed average   
