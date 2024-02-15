Problem Description:
---
Your task is to write an assembly language function to count the number of digits in a base-10 number. The function will be called digitcounter:

```
unsigned int digitcounter(long value);
```

If we pass 1218 it will return 4. If we pass 3, it returns 1. It returns the number of digits in the value, assuming that leading zeros do not count. If we wrote this in C, it would be as simple as:

```
unsigned int digitcounter(long  value) 
{
    unsigned int counter = 0;
    while(value > 0) 
    {
        counter++;
        value /= 10;
    }
    
    return counter;
}
```

But, you are going to write it in assembly language, of course.
