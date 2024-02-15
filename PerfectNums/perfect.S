//
//// Data
//
.data

.balign 4

allperf: .asciz "\nAll Perfect numbers from 1 to 10000:\n\n"

perfects: .asciz "Perfect: %d\n"


//
////
////// Text
////
//
.text
.balign 4
.global main


//
// Main Function
//
main:
  fp .req x29
  lr .req x30

  // long number, divisor, sum
  .equ number, 16       // dword, Must start at 16 (after fp, lr)
  .equ divisor, 24      // dword
  .equ sum, 32          // dword
  .equ size, 48         // Must be multiple of 16!

  // Store fp and lr and makes space on the stack
  stp fp, lr, [sp, #-size]!
  mov fp, sp

  // printf("\nAll Perfect numbers from 1 to 10000:\n\n");
  ldr x0,=allperf
  bl printf

  // for(number=1; number<=10000; number++)
  mov x0,#1             // number = 1
  str x0,[fp,#number]
outer_loop:
  // LOOP CONDITION
  ldr x0,[fp,#number]   // x0 = number
  mov x3,#10000         // x3 = 10000
  cmp x0,x3
  bgt outer_loop_end    // if number > 10000, end outer loop
    // number <= 10000

  // sum = 0;
  mov x2,#0             // sum = 0
  str x2,[fp,#sum]

  // for(divisor=1; divisor<number; divisor++) 
  mov x1,#1             // divisor = 1
  str x1,[fp,#divisor]
inner_loop:
  // LOOP CONDITION
  ldr x0,[fp,#number]   // x0 = number
  ldr x1,[fp,#divisor]  // x1 = divisor
  cmp x1,x0
  bge inner_loop_end    // if divisor >= number, end inner loop
    // divisor < number

  // if(number % divisor == 0)
  ldr x0,[fp,#number]   // x0 = number
  ldr x1,[fp,#divisor]  // x1 = divisor
  bl ldiv               // ldiv
  cmp x1,#0
  bne inner_increment   // if number % divisor != 0, DONT do next 5 lines
  
  // sum += divisor
  ldr x2,[fp,#sum]      // x2 = sum
  ldr x1,[fp,#divisor]  // x1 = divisor
  add x2,x2,x1          // sum += divisor
  str x2,[fp,#sum]

inner_increment:
  // Increment and loop
  ldr x1,[fp,#divisor]  // x1 = divisor
  add x1,x1,#1          // divisor++
  str x1,[fp,#divisor]
  b inner_loop          // loop  

inner_loop_end:
  // if(number == sum)
  ldr x1,[fp,#number]   // x1 = number
  ldr x2,[fp,#sum]      // x2 = sum
  cmp x1,x2
  beq perfect           // if number == sum, branch
perfect_done:

  // Increment number and loop
  ldr x0,[fp,#number]   // x0 = number
  add x0,x0,#1          // number++
  str x0,[fp,#number]
  b outer_loop          // go to outer loop

perfect:
  // printf("Perfect: %d\n", number);
  ldr x0,=perfects
  ldr x1,[fp,#number]   // x0 = number
  bl printf
  b perfect_done        // back to outer loop end

outer_loop_end:
  b main_ret
main_ret:
  // return 0
  mov w0,#0
  
  // Pop lr and fp and free stack space
  ldp x29, x30, [sp], #size
  ret




