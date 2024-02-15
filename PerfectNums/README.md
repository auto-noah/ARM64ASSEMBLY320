Your task now is to write a program in ARM assembly language that will compute all Perfect Numbers in the range 1 to 10000. A Perfect number is defined as a number that is equal to the sum of it's proper divisors. For example, 6 is a perfect number. The proper divisors of 6 are 1, 2, and 3 and 1+2+3=6. A proper divisor of n is any number that is a divisor of n other than n itself.

Please create a directory named perfect under system7 for this task.

To make this even easier, here's a working C version of the program you will need to write:

------------------------------------------------------------------------
/**
 * Program that computes all perfect 
 * numbers from 1 to 10,000!
 */
#include <stdio.h>

int main()
{
    long number, divisor, sum;
    
    printf("\nAll Perfect numbers from 1 to 10000:\n\n");

    for(number=1; number<=10000; number++)
    {
        sum = 0;

        for(divisor=1;  divisor<number; divisor++) 
        {
            if(number % divisor == 0) {
                sum += divisor;
            }
        }

        if(number == sum) {
            printf("Perfect: %d\n", number);
        }
    }
    
    return 0;
}
------------------------------------------------------------------------

Important Rule:
You may push only x29 and x30 to the stack - no other variables may be pushed to the stack! You must use local variables to solve this problem.
You are also not allowed to use any registers other than x0-x3.
