Problem Description:
---
In the sorthex project, strings of bytes are considered to be two hexadecimal values. So, 11 bytes will be 22 hexadecimal values:

![image](https://github.com/auto-noah/ARM64ASSEMBLY320/assets/151595012/a0d76b0c-498b-411b-b471-4828872ffd7e)

In the sorthex project, an index is for the hexadecimal value. So, index 0 would be the first hexadecimal character 'a'. Index 1 would be 'b'. Index 2 would be '8' and so on. Given an index, the byte is the index divided by 2. Index 13 is in byte 6 (13/2). If the index is even we are interested in the high four bits. If the index is odd, we are interested in the four low bits.

Please implement the following three assembly language functions:

**int gethex(void *data, int size, int index)**
(gethex.S) Given an array of bytes pointed to by data and where size is the number of bytes, return the hexadecimal value at the index. If index is out of range (< 0 or >= size * 2), return a zero. For example, calling gethex(data, 11, 14) on the data above will return the value f (15).

**void sethex(void *data, int size, int index, int value)**
(sethex.S) Given an array of bytes pointed to by data and where size is the number of bytes, set the hexadecimal value at the index to value. If the index is out of range, do nothing. For example, calling sethex(data, 11, 9, 0xa) on the data above would change the 4th byte (starting at zero, of course) from 13 to 1a.

**void sorthex(void *data, int size)**
(sorthex.S) Given an array of bytes pointed to by data and where size is the number of bytes, sort the array hexadecimal values in order. For the data above, calling sorthex(data, 11) would change the array to:

![image](https://github.com/auto-noah/ARM64ASSEMBLY320/assets/151595012/a2786ec9-8323-4df6-97db-ae66be28fd67)
