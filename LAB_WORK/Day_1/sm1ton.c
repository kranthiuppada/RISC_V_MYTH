//C program from 1to n in virtualbox

#include  <stdio.h>

int main(){
	int i,sum = 0, n = 5;
	for (i = 1; i <= n; i++){
		sum += i;
	}
	printf("Sum of numbers from 1 to %d is %d\n",n, sum);
	return 0;
}
//compile by command
gcc sm1ton.c
// output by command
 ./a.out
sum of numbers 1 to 5 is 15
	
