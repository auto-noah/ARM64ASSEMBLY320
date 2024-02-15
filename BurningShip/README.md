Problem Description:
---
Your task is to write a program that creates a Burning Ship fractal image:

![image](https://github.com/auto-noah/ARM64ASSEMBLY320/assets/151595012/569b80ce-0c18-46c3-b02c-9ab1d9af1e3f)

A burning ship is closely related to the Mandelbrot set. It's just not as cliché. In a complex space, a point c=x+yi is inside the burning ship if the mapping:

![Screen Shot 2024-02-14 at 9 37 55 PM](https://github.com/auto-noah/ARM64ASSEMBLY320/assets/151595012/bf575458-c104-406b-b5d3-450cb29f436d)

is bounded. In this equation, Re(zn) means the real part of zn and Im(zn) is the imaginary part of zn. This means if you keep plugging z into the equation over and over again, the result does not become unbounded (growing bigger and bigger).

The function you will implement will plug a value c into that mapping repeatedly and look for when it becomes unbounded. If it never does for some number of iterations, the point will display as black. If it does become unbounded, the number of iterations before it becomes unbounded determines the pixel color. I provide all of the code to determine the pixel color and write the PNG image; you are only required to implement the function that makes the bounded/unbounded determination for some point c=x+yi.

In a file ship.S, create an assembly-language implementation of the function ship:

```
int ship(double xn0, double yn0)
{
    double x = 0;
    double y = 0;
    int iteration = 0;
    while((x*x + y*y) < 4 && iteration < 255)
    {
        x = x >= 0 ? x : -x;
        y = y >= 0 ? y : -y;
        double xn1 = x*x - y*y + xn0;
        double yn1 = 2*x*y + yn0;
        x = xn1;
        y = yn1;

        iteration++;
    }

    return iteration;
}
```

**WHEN BUILDING SOLUTION:**
---
When you do a make, the program will be built as the executable: ship. It expects a filename for a .png file when you run the program:
```
./ship ship.png
```
This will create a file named ship.png that is the computed burning ship image. It should look like the image above.
