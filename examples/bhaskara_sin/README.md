# Implementation of Bhaskara I Sin Approximation

This is an implementation of the [Bhaskara sin approximation](https://datagenetics.com/blog/july12019/index.html).

```bash
/workspace/bhaskara_sine # iverilog bhaskara_sin.vl
/workspace/bhaskara_sine # ./a.out
theta: 0        sin: 0
theta: 0.785398163      sin: 0.7058823526609758
theta: 1.570796327      sin: 1
theta: 2.35619449       sin: 0.7058823530768713
theta: 3.141592654      sin: -4.176226052382529e-10
bhaskara_sin.vl:44: $finish called at 22 (1s)
```
