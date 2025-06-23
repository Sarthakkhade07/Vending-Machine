module vending_machine_tb;
    // inputs
    reg clk;
    reg rst;
    reg [1:0] in;

    // outputs
    wire out;   
    wire [1:0] change;
    wire [1:0] c_state;
    wire [1:0] n_state;

    vending_machine uut (
        .clk(clk),
        .rst(rst),
        .in(in),
        .out(out),
        .change(change),
        .c_state(c_state),
        .n_state(n_state)
    );

    initial begin
        // Initialize inputs
        $dumpfile("vending_machine.vcd");
        $dumpvars(1,vending_machine_tb, uut);
        clk = 0;
        rst = 1;

        #6 rst = 0; 
        in = 1;
        #11 in = 1;
        #16 in = 1;
        #25 $finish;

    end
    always #5 clk = ~clk; // Clock generation

endmodule