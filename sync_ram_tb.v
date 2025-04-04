`timescale 1ns / 1ps

module synchronous_ram_tb;

    reg clk,we;
    reg [7:0] addr;
    reg [31:0] data_in;
    wire [31:0] data_out;

    synchronous_ram dut(.clk(clk), .we(we), .addr(addr), .data_in(data_in), .data_out(data_out));

    always #5 clk = ~clk;

    initial begin
        clk = 0; we = 0; addr = 0; data_in = 0;

        #10 we = 1; addr = 8'd10; data_in = 32'h12345678;
        #10 we = 0; 

        #10 addr = 8'd10;

        #10 we = 1; addr = 8'd20; data_in = 32'hAABBCCDD;
        #10 we = 0;

        #10 addr = 8'd20;

        #10 $finish;
    end

    initial begin
        $monitor("Time = %0t | we = %b | addr = %d | data_in = %h | data_out = %h",
                 $time, we, addr, data_in, data_out);
    end

endmodule