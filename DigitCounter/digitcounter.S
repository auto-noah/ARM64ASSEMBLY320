.text

.global digitcounter

/**
 * unsigned int digitcounter(long value)
 * Returns the number of digits in the value
 */
digitcounter:
  fp .req x29
  lr .req x30
            
  .equ value, 16          // dword, Must start at 16 (after fp, lr)
  .equ quotient, 24       // dword
  .equ remainder, 32      // dword
  .equ counter, 40        // word (4 bytes)
  .equ size, 48           // Must be multiple of 16!
                                
  // Store fp and lr and makes space on the stack
  stp fp, lr, [sp, #-size]!
  mov fp, sp
    
  // Save value as local variable
  str x0,[fp,#value]              // (fp + value) = x0

  // Variable to compute the size into
  mov w0, #0                      // w0 = 0
  str w0, [fp, #counter]          // (fp + counter) = w0 [counter = 0]

digitcounter_loop:
  // Loop as long as value != 0
  ldr w0, [fp, #value]            // w0 = (fp + value)
  cmp w0, #0                      
  beq digitcounter_done           // if value == 0, branch

  // Increment counter
  ldr x0, [fp, #counter]          // x0 = counter
  add x0,x0,#1                    // counter++
  str x0, [fp, #counter]          // counter = x0

  // Divide value by 10
  ldr x0, [fp,#value]             // numer (x0) = (fp + value)
  mov x1, #10                     // denom (x1) = 10
  bl ldiv                         // ldiv(numer, denom);

  // Store the quotient and remainder as local variables
  str x0, [fp, #quotient]         // (fp + quotient) = x0
  str x1, [fp, #remainder]        // (fp + remainder) = x1

  // Get a result to return
  ldr x0, [fp, #quotient]         // result (x0) = (fp + quotient)
  str x0, [fp, #value]            // (fp + value) = result (x0)
  b digitcounter_loop

digitcounter_done:
  // Return the counter's result
  ldr w0, [fp, #counter]          // w0 = (fp + counter)

  // Pop lr and fp and free stack space
  ldp x29, x30, [sp], #size
  ret
