


`timescale 1ns/1ns

module tb_FP32_commutativity;

reg [31:0] op_a, op_b;
reg [1:0] op_code;
reg clk, rst, start, mode_fp;
wire [31:0] result;
wire [4:0] flags;
wire valid_out;

FP_ALU_if uut (.op_a(op_a), .op_b(op_b), .op_code(op_code),
.clk(clk), .rst(rst), .start(start), .mode_fp(mode_fp),
.result(result), .flags(flags), .valid_out(valid_out));

always #5 clk=~clk;

initial begin
clk=0; rst=1; start=0; mode_fp=0; op_a=0; op_b=0; op_code=0;
#10 rst=0;

op_code=2'b00;
op_a={16'b0,16'h4000}; op_b={16'b0,16'h4200}; start=1; #10; start=0; #20;
op_a={16'b0,16'h4200}; op_b={16'b0,16'h4000}; start=1; #10; start=0; #20;

op_code=2'b10;
op_a={16'b0,16'h4200}; op_b={16'b0,16'h3E00}; start=1; #10; start=0; #20;
op_a={16'b0,16'h3E00}; op_b={16'b0,16'h4200}; start=1; #10; start=0; #20;

$finish;
end

initial begin $dumpfile("fp32_comm.vcd"); $dumpvars(0, tb_FP32_commutativity); end

endmodule
