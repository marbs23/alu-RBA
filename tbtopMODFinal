/////////////tb 32 bits
`timescale 1ns/1ps
module tb_FP_ALU_if_basic;
  reg  [31:0] op_a, op_b;
  reg  [1:0]  op_code;
  reg         clk, rst, start, mode_fp;
  wire [31:0] result;
  wire [4:0]  flags;
  wire        valid_out;

  FP_ALU_if uut (
    .op_a(op_a), .op_b(op_b),
    .op_code(op_code), .clk(clk),
    .rst(rst), .start(start),
    .mode_fp(mode_fp),
    .result(result), .flags(flags), .valid_out(valid_out)
  );

  always #5 clk = ~clk;

  initial begin
    $dumpfile("tb_FP_ALU_if_basic.vcd");
    $dumpvars(0, tb_FP_ALU_if_basic);
    clk = 0; rst = 1; start = 0; mode_fp = 0;
    #0 rst = 0; #0;

    op_a=32'h3F800000; op_b=32'h40000000; op_code=2'b00; start=1; #10; start=0; #20;
    $display("Suma: %h | Flags=%b", result, flags);

    op_a=32'h40A00000; op_b=32'h40400000; op_code=2'b01; start=1; #10; start=0; #20;
    $display("Resta: %h | Flags=%b", result, flags);

    op_a=32'h40000000; op_b=32'h40800000; op_code=2'b10; start=1; #10; start=0; #20;
    $display("Mult: %h | Flags=%b", result, flags);

    op_a=32'h41000000; op_b=32'h40000000; op_code=2'b11; start=1; #10; start=0; #20;
    $display("Div: %h | Flags=%b", result, flags);

    op_a=32'h3F800000; op_b=32'h00000000; op_code=2'b11; start=1; #10; start=0; #20;
    $display("Div0: %h | Flags=%b", result, flags);

    #20 $finish;
  end
endmodule

`timescale 1ns/1ps
module tb_FP_ALU_if_special;
  reg  [31:0] op_a, op_b;
  reg  [1:0]  op_code;
  reg         clk, rst, start, mode_fp;
  wire [31:0] result;
  wire [4:0]  flags;
  wire        valid_out;

  FP_ALU_if uut(
    .op_a(op_a), .op_b(op_b),
    .op_code(op_code), .clk(clk),
    .rst(rst), .start(start),
    .mode_fp(mode_fp),
    .result(result), .flags(flags), .valid_out(valid_out)
  );

  always #5 clk = ~clk;

  initial begin
    $dumpfile("tb_FP_ALU_if_special.vcd");
    $dumpvars(0, tb_FP_ALU_if_special);
    clk = 0; rst = 1; start = 0; mode_fp = 0;
    #0 rst = 0; #0;

    // 1. Inf + Inf → NaN (flag inválido)
    op_a=32'h7F800000; op_b=32'hFF800000; op_code=2'b00; start=1; #10; start=0; #10;
    $display("Inf + (-Inf): %h | Flags=%b", result, flags);

    // 2. 1.0 / 0.0 → +Inf (flag div0)
    op_a=32'h3F800000; op_b=32'h00000000; op_code=2'b11; start=1; #10; start=0; #10;
    $display("1.0 / 0.0: %h | Flags=%b", result, flags);

    // 3. 0.0 / 0.0 → NaN (flag inválido)
    op_a=32'h00000000; op_b=32'h00000000; op_code=2'b11; start=1; #10; start=0; #10;
    $display("0.0 / 0.0: %h | Flags=%b", result, flags);

    // 4. Inf * 0.0 → NaN (flag inválido)
    op_a=32'h7F800000; op_b=32'h00000000; op_code=2'b10; start=1; #10; start=0; #10;
    $display("Inf * 0.0: %h | Flags=%b", result, flags);

    // 5. Inf / Inf → NaN (flag inválido)
    op_a=32'h7F800000; op_b=32'h7F800000; op_code=2'b11; start=1; #10; start=0; #10;
    $display("Inf / Inf: %h | Flags=%b", result, flags);

    #20 $finish;
  end
endmodule


`timescale 1ns/1ps
module tb_FP_ALU_if_denorm;
  reg  [31:0] op_a, op_b;
  reg  [1:0]  op_code;
  reg         clk, rst, start, mode_fp;
  wire [31:0] result;
  wire [4:0]  flags;
  wire        valid_out;

  FP_ALU_if uut(
    .op_a(op_a), .op_b(op_b),
    .op_code(op_code), .clk(clk),
    .rst(rst), .start(start),
    .mode_fp(mode_fp),
    .result(result), .flags(flags), .valid_out(valid_out)
  );

  always #5 clk = ~clk;

  initial begin
    $dumpfile("tb_FP_ALU_if_denorm.vcd");
    $dumpvars(0, tb_FP_ALU_if_denorm);
    clk = 0; rst = 1; start = 0; mode_fp = 0;
    #0 rst = 0; #0;

    // 1. Denorm + 1.0
    op_a=32'h00000010; op_b=32'h3F800000; op_code=2'b00; start=1; #10; start=0; #10;
    $display("Denorm + 1.0: %h | Flags=%b", result, flags);

    // 2. -Denorm + 1.0
    op_a=32'h80000010; op_b=32'h3F800000; op_code=2'b00; start=1; #10; start=0; #10;
    $display("-Denorm + 1.0: %h | Flags=%b", result, flags);

    // 3. Denorm - Denorm
    op_a=32'h00000020; op_b=32'h00000010; op_code=2'b01; start=1; #10; start=0; #10;
    $display("Denorm - Denorm: %h | Flags=%b", result, flags);

    // 4. Denorm * Denorm
    op_a=32'h00000010; op_b=32'h00000020; op_code=2'b10; start=1; #10; start=0; #10;
    $display("Denorm * Denorm: %h | Flags=%b", result, flags);

    // 5. 1.0 / Denorm
    op_a=32'h3F800000; op_b=32'h00000010; op_code=2'b11; start=1; #10; start=0; #10;
    $display("1.0 / Denorm: %h | Flags=%b", result, flags);

    #20 $finish;
  end
endmodule




///////////////tb 16 bits

`timescale 1ns/1ps
module tb_FP_ALU_if_basic_fp16;
  reg  [31:0] op_a, op_b;
  reg  [1:0]  op_code;
  reg         clk, rst, start, mode_fp;
  wire [31:0] result;
  wire [4:0]  flags;
  wire        valid_out;

  FP_ALU_if uut (
    .op_a(op_a), .op_b(op_b),
    .op_code(op_code), .clk(clk),
    .rst(rst), .start(start),
    .mode_fp(mode_fp),
    .result(result), .flags(flags), .valid_out(valid_out)
  );

  always #5 clk = ~clk;

  initial begin
    $dumpfile("tb_FP_ALU_if_basic_fp16.vcd");
    $dumpvars(0, tb_FP_ALU_if_basic_fp16);
    clk = 0; rst = 1; start = 0; mode_fp = 1; // modo FP16
    #5 rst = 0; #5;

    // 1. 1.5 + 2.5
    op_a=32'h00003E00; op_b=32'h00004000; op_code=2'b00; start=1; #10; start=0; #10;
    $display("Suma (1.5 + 2.5): %h | Flags=%b", result, flags);

    // 2. 5.5 - 2.0
    op_a=32'h00004500; op_b=32'h00004000; op_code=2'b01; start=1; #10; start=0; #10;
    $display("Resta (5.5 - 2.0): %h | Flags=%b", result, flags);

    // 3. 3.0 * 1.5
    op_a=32'h00004200; op_b=32'h00003E00; op_code=2'b10; start=1; #10; start=0; #10;
    $display("Mult (3.0 * 1.5): %h | Flags=%b", result, flags);

    // 4. 8.0 / 2.0
    op_a=32'h00004800; op_b=32'h00004000; op_code=2'b11; start=1; #10; start=0; #10;
    $display("Div (8.0 / 2.0): %h | Flags=%b", result, flags);

    // 5. 1.0 / 0.0 → Inf
    op_a=32'h00003C00; op_b=32'h00000000; op_code=2'b11; start=1; #10; start=0; #10;
    $display("Div0 (1.0 / 0.0): %h | Flags=%b", result, flags);

    #20 $finish;
  end
endmodule


`timescale 1ns/1ps
module tb_FP_ALU_if_special_fp16;
  reg  [31:0] op_a, op_b;
  reg  [1:0]  op_code;
  reg         clk, rst, start, mode_fp;
  wire [31:0] result;
  wire [4:0]  flags;
  wire        valid_out;

  FP_ALU_if uut(
    .op_a(op_a), .op_b(op_b),
    .op_code(op_code), .clk(clk),
    .rst(rst), .start(start),
    .mode_fp(mode_fp),
    .result(result), .flags(flags), .valid_out(valid_out)
  );

  always #5 clk = ~clk;

  initial begin
    $dumpfile("tb_FP_ALU_if_special_fp16.vcd");
    $dumpvars(0, tb_FP_ALU_if_special_fp16);
    clk = 0; rst = 1; start = 0; mode_fp = 1;
    #5 rst = 0; #5;

    // 1. +Inf + (-Inf) → NaN (flag inválido)
    op_a=32'h00007C00; op_b=32'h0000FC00; op_code=2'b00; start=1; #10; start=0; #10;
    $display("Inf + (-Inf): %h | Flags=%b", result, flags);

    // 2. 1.0 / 0.0 → +Inf (flag div0)
    op_a=32'h00003C00; op_b=32'h00000000; op_code=2'b11; start=1; #10; start=0; #10;
    $display("1.0 / 0.0: %h | Flags=%b", result, flags);

    // 3. 0.0 / 0.0 → NaN (flag inválido)
    op_a=32'h00000000; op_b=32'h00000000; op_code=2'b11; start=1; #10; start=0; #10;
    $display("0.0 / 0.0: %h | Flags=%b", result, flags);

    // 4. Inf * 0.0 → NaN (flag inválido)
    op_a=32'h00007C00; op_b=32'h00000000; op_code=2'b10; start=1; #10; start=0; #10;
    $display("Inf * 0.0: %h | Flags=%b", result, flags);

    // 5. Inf / Inf → NaN (flag inválido)
    op_a=32'h00007C00; op_b=32'h00007C00; op_code=2'b11; start=1; #10; start=0; #10;
    $display("Inf / Inf: %h | Flags=%b", result, flags);

    #20 $finish;
  end
endmodule


// Code your testbench here
// or browse Examples
`timescale 1ns/1ps
module tb_FP_ALU_if_denorm_fp16;
  reg  [31:0] op_a, op_b;
  reg  [1:0]  op_code;
  reg         clk, rst, start, mode_fp;
  wire [31:0] result;
  wire [4:0]  flags;
  wire        valid_out;

  FP_ALU_if uut(
    .op_a(op_a), .op_b(op_b),
    .op_code(op_code), .clk(clk),
    .rst(rst), .start(start),
    .mode_fp(mode_fp),
    .result(result), .flags(flags), .valid_out(valid_out)
  );

  always #5 clk = ~clk;

  initial begin
    $dumpfile("tb_FP_ALU_if_denorm_fp16.vcd");
    $dumpvars(0, tb_FP_ALU_if_denorm_fp16);
    clk = 0; rst = 1; start = 0; mode_fp = 1; // modo FP16
    #5 rst = 0; #5;

    // 1. Denorm + 1.0
    op_a=32'h00000010; op_b=32'h00003C00; op_code=2'b00; start=1; #10; start=0; #10;
    $display("Denorm + 1.0: %h | Flags=%b", result, flags);

    // 2. -Denorm + 1.0
    op_a=32'h00008010; op_b=32'h00003C00; op_code=2'b00; start=1; #10; start=0; #10;
    $display("-Denorm + 1.0: %h | Flags=%b", result, flags);

    // 3. Denorm - Denorm
    op_a=32'h00000020; op_b=32'h00000010; op_code=2'b01; start=1; #10; start=0; #10;
    $display("Denorm - Denorm: %h | Flags=%b", result, flags);

    // 4. Denorm * Denorm
    op_a=32'h00000010; op_b=32'h00000020; op_code=2'b10; start=1; #10; start=0; #10;
    $display("Denorm * Denorm: %h | Flags=%b", result, flags);

    // 5. 1.0 / Denorm
    op_a=32'h00003C00; op_b=32'h00000010; op_code=2'b11; start=1; #10; start=0; #10;
    $display("1.0 / Denorm: %h | Flags=%b", result, flags);

    #20 $finish;
  end
endmodule
