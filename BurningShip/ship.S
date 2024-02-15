.data

.balign 8

c1: .double 0
c2: .double 2
c3: .double 4


.text

.global ship

//
// int ship(double xn0, double yn0)
// Creates a file named ship.png that is the computed burning ship image.
//
ship:
  stp x29, x30, [sp, #-16]!

  // Initialize Variables
  x .req d2                       // w2 = x
  y .req d3                       // w3 = y
  iteration .req w4               // w4 = iteration
  xn1 .req d5                     // w5 = xn1
  yn1 .req d6                     // w6 = yn1
  zero .req d10
  two .req d11
  four .req d12
  ldr x8,=c1                       // x = 0
  ldr x, [x8]
  ldr x8,=c1                       // y = 0
  ldr y, [x8]
  mov iteration,#0                // iteration = 0
  ldr x8,=c1                    // zero = 0
  ldr zero, [x8]
  ldr x8,=c2                     // two = 2
  ldr two, [x8]
  ldr x8,=c3                    // four = 4
  ldr four, [x8] 

while:
  // Loop Conditions
  fmul d7,x,x                     // aaaa x^2
  fmul d8,y,y                     // w8 = y^2
  fadd d9,d7,d8                   // w9 = x^2 + y^2
  fcmp d9,four
  bge while_end                   // If x^2+y^2 >= 4, branch
  cmp iteration,#255              
  bge while_end                   // If iteration >= 255, branch


  // x = x >= 0 ? x : -x
  fcmp x,zero
  bge absx_done                   // If x >= 0, skip
  fsub x,zero,x                   // x = 0 - (-x) = 0 + x
absx_done:

  // y = y >= 0 ? y : -y
  fcmp y,zero
  bge absy_done                   // If y >= 0, skip
  fsub y,zero,y                   // y = 0 - (-y) = 0 + y
absy_done:

  // double xn1 = x*x - y*y + xn0
  fmul d7,x,x                     // w7 = x^2
  fmul d8,y,y                     // w8 = y^2
  fsub xn1,d7,d8                  // xn1 = x^2 - y^2
  fadd xn1,xn1,d0                 // xn1 = x^2 - y^2 + xn0

  //double yn1 = 2*x*y + yn0
  fmul yn1,x,y                    // yn1 = x*y
  fmul yn1,yn1,two                // yn1 = 2*x*y
  fadd yn1,yn1,d1                 // yn1 = 2*x*y + yn0

  // x = xn1
  fmov x,xn1
  // y = yn1
  fmov y,yn1

  // Iterate and Loop
  add iteration,iteration,#1      // iteration++
  b while

while_end:
  mov w0,iteration                // w0 = iteration
return:
  ldp x29, x30, [sp], #16
  ret                             // Return

  .unreq x
  .unreq y
  .unreq iteration
  .unreq xn1
  .unreq yn1
  .unreq zero
  .unreq two

