/*******************************************************************************
File name       : bsort.s
Description     : Assembly File to do bubble sort
Author          : Ahmad Sebak    
Created         : 11/04/2015 
*******************************************************************************/
  
  PUBLIC BubbleSort                
  SECTION `.text`:CODE:NOROOT(1)
  THUMB

/*******************************************************************************
Function Name   : BubbleSort
Description     : Sorts an array using the bubble sort algorithm
C Prototype     : void BubbleSort(int A[], int cnt, bool asc)
                : Where int A[] is the array to initialize
                : cnt is the size of A, and asc is a flag to set the order.
Parameters      : R0: Address of A
                : R1: cnt, number of elements
                : R2: asc, ascending order flag
Return value    : None
*******************************************************************************/
BubbleSort:
  PUSH  {R3-R7, LR}             ;; Save Context in the registers we will use.
  MOV   R3,#+1                  ;; set swapped register as true

OuterLoop:
  CMP   R3,#+1                  ;; check if swapped register is true
  BNE   FINISH                  ;; if (swapped == false) -> finish
  MOV   R3,#+0                  ;; set swapped register as false
  MOV   R4,#+1                  ;; initialize for loop to start at i = 1
  B     InnerLoop               ;; go to the inner loop
  
InnerLoop:  
  CMP   R4,R1                   ;; check for more elements r4 -> i index of array
  BNE   Compare_Array           ;; if not at the end of the foor loop compare elements in array
  B     OuterLoop               ;; once inner loop completes go back to outer loop

Compare_Array:
  SUB   R5,R4,#+1               ;; r5 <- i - 1
  LDR   R6,[R0,R5,LSL #+2]      ;; r6 <- A[r5]
  LDR   R7,[R0,R4,LSL #+2]      ;; r7 <- A[r4]
  CMP   R2,#+1                  ;; compare to see if ascending flag is set    
  BEQ   Ascending
  BNE   Descending
  
Ascending:
  CMP   R6,R7                   ;; compare  A[i-1] > A[i]
  B     Swap_and_Increment
  
Descending:
  CMP   R7,R6                   ;; compare  A[i-1] < A[i] 
  B     Swap_and_Increment

Swap_and_Increment:
  BGT   Swap                    ;; if flags are set from either Ascending or Descending labels
  B     Increment               ;; increment array index

Swap:
  STR   R6,[R0, R4, LSL #+2]    ;; A[r6 ]-> @(r0 [r4 << 2] word shift
  STR   R7,[R0, R5, LSL #+2]    ;; A[r7] -> @(r0 [r5 << 2] word shift
  MOV   R3,#+1                  ;; set swapped register as true
  B Increment                   ;; increment array index
  
Increment:
  ADD   R4,R4,#+1               ;; Next element number
  B     InnerLoop               ;; repeat
  
FINISH:  
  POP   {R3-R7}                 ;; restore context
  MOV   pc,lr                   ;; return
  END
