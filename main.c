/*******************************************************************************
FILE NAME   : main.c
DESCRIPTION : Calling assembly function from C file.
	      

Copyright   : Ahmad Sebak
            : 2015
	    : All Rights Reserved
*******************************************************************************/
typedef enum {
  false,
  true
} bool;

int array[] = { -41, 30, -120, 2, 108, 0, 126, 1, 3, 109 }; 

extern void BubbleSort(int A[], int cnt, bool asc);

void main() {

  int count = sizeof(array)/sizeof(int);
  
  BubbleSort(array, count, false);

}
