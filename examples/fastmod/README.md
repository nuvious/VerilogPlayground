# Fast Mod Example

This is just a direct implementation of the below referenced fastmod algorithm. Was my exploration into algorithms which
do not depend on sequential logic. Just set the `n` and `d` registers with desired numerators or denominators and the
`r` register will reflect the remainder. This can be used for divisibility as well simply by checking if the remainder
is 0 or not.

```bash
/workspace/fastmod # iverilog fastmod.vl
fastmod.vl:33: warning: Port 1 (n) of fastmod expects 16 bits, got 8.
fastmod.vl:33:        : Padding 8 high bits of the port.
fastmod.vl:33: warning: Port 2 (d) of fastmod expects 16 bits, got 8.
fastmod.vl:33:        : Padding 8 high bits of the port.
/workspace/fastmod # ./a.out
n:  75  d:  5   r:                   0
n:  75  d:  4   r:                   3
n:  75  d:  3   r:                   0
n:  75  d:  2   r:                   1
fastmod.vl:50: $finish called at 22 (1s)
```

![](fastmod-diagram.png)
![](fastmod-trace.png)

Above diagram was generated by [Yosys verilog visualizer/simulator](http://digitaljs.tilk.eu/#82fff906770385b49a913fd660751099144ee88e96ab31c30871b0e0f5764596).

## References

- [Faster remainders when the divisor is a constant: beating compilers and libdivide](https://lemire.me/blog/2019/02/08/faster-remainders-when-the-divisor-is-a-constant-beating-compilers-and-libdivide/)
- [Faster Remainder by Direct Computation Applications to Compilers and Software Libraries](https://arxiv.org/pdf/1902.01961.pdf)