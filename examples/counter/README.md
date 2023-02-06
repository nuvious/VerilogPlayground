# Simple N-Bit Counter

[counter.vl](counter.vl) is adapted from the [ChipVerify 4-bit counter example](https://www.chipverify.com/verilog/verilog-4-bit-counter).

You can play around with the wire definitions to increase the bit size of the counter. In my adaptation I increased it
to 8-bits:

```verilog
module counter (
    input clk,
    input rstn,
    output reg[7:0] out); // 8-bit output
    always @ (posedge clk) begin
        if (!rstn)
            out <= 0;
        else
            out <= out + 1;
            $display("%d\t%d", rstn, out); // display the current rst and output state after the coutner
    end
endmodule
```

This means the counter will have a range of 0-255. To see
a rollover in the testbench, I needed to adjust the finish
clock:

rollover_time = (256 + 1) * 2 * 5 = 2570

- 256 being the range of an 8 bit unsigned integer
- 1 being the necessary extra counter cycle to see the clock roll over
- 2 cycles per flip-flop of the clk
- 5 being the number of ns per cycle

```verilog
module tb;
    reg clk;
    reg rstn;
    wire [7:0] out;

    counter c0(.clk (clk),
               .rstn (rstn),
               .out (out));
    
    always #5 clk = ~clk;

    initial begin
        clk <= 0;
        rstn <= 0;

        #20 rstn <= 1;
        #80 rstn <= 0;
        #50 rstn <= 1;

        #2570 $finish;
    end
endmodule
```

```bash
/workspace # cd counter
/workspace/counter # iverilog counter.vl
/workspace/counter # ./a.out
0         x
0         0
1         0
1         1
1         2
1         3
1         4
1         5
1         6
1         7
0         8
0         0
0         0
0         0
0         0
1         0
1         1
1         2
1         3
1         4
...
1       255
1         0
counter.vl:35: $finish called at 2720 (1s)
/workspace/counter #
```

Note that the final output is 0 and the combine call finished at 2720 (20 + 80 + 50 + 2570).
