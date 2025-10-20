`timescale 1ns/1ns

module tb_FP16_normal_cases;

    reg  [31:0] op_a, op_b;
    reg  [1:0]  op_code;
    reg         clk, rst, start, mode_fp;
    wire [31:0] result;
    wire [4:0]  flags;
    wire        valid_out;

    FP_ALU_if uut (
        .op_a(op_a),
        .op_b(op_b),
        .op_code(op_code),
        .clk(clk),
        .rst(rst),
        .start(start),
        .mode_fp(mode_fp),
        .result(result),
        .flags(flags),
        .valid_out(valid_out)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        start = 0;
        mode_fp = 1;   // Modo FP16
        op_a = 0;
        op_b = 0;
        op_code = 0;
        #20 rst = 0;


        // ==== SUMA ====
        op_code = 2'b00;
        op_a = 32'h00003C00; op_b = 32'h00004000; start = 1; #10; start = 0; #20; // 1.0 + 2.0 = 3.0
        op_a = 32'h0000BC00; op_b = 32'h00003C00; start = 1; #10; start = 0; #20; // -1.0 + 1.0 = 0.0
        op_a = 32'h00005000; op_b = 32'h00004800; start = 1; #10; start = 0; #20; // 4.0 + 3.0 = 7.0
        op_a = 32'h00007BFF; op_b = 32'h00004000; start = 1; #10; start = 0; #20; // Max + 2.0 (overflow)

        // ==== RESTA ====
        op_code = 2'b01;
        op_a = 32'h00004000; op_b = 32'h00003C00; start = 1; #10; start = 0; #20; // 2.0 - 1.0 = 1.0
        op_a = 32'h0000BC00; op_b = 32'h00003C00; start = 1; #10; start = 0; #20; // -1.0 - 1.0 = -2.0
        op_a = 32'h00007C00; op_b = 32'h00007C00; start = 1; #10; start = 0; #20; // Inf - Inf = NaN

        // ==== MULTIPLICACIÓN ====
        op_code = 2'b10;
        op_a = 32'h00003C00; op_b = 32'h00003C00; start = 1; #10; start = 0; #20; // 1.0 * 1.0 = 1.0
        op_a = 32'h00004000; op_b = 32'h00003C00; start = 1; #10; start = 0; #20; // 2.0 * 1.0 = 2.0
        op_a = 32'h00005000; op_b = 32'h00004800; start = 1; #10; start = 0; #20; // 4.0 * 3.0 = 12.0
        op_a = 32'h0000BC00; op_b = 32'h00003C00; start = 1; #10; start = 0; #20; // -1.0 * 1.0 = -1.0
        op_a = 32'h00007C00; op_b = 32'h00000000; start = 1; #10; start = 0; #20; // Inf * 0.0 = NaN
        op_a = 32'h00007C00; op_b = 32'h00007C00; start = 1; #10; start = 0; #20; // Inf * Inf = Inf

        // ==== DIVISIÓN ====
        op_code = 2'b11;
        op_a = 32'h00004000; op_b = 32'h00003C00; start = 1; #10; start = 0; #20; // 2.0 / 1.0 = 2.0
        op_a = 32'h00003C00; op_b = 32'h00004000; start = 1; #10; start = 0; #20; // 1.0 / 2.0 = 0.5
        op_a = 32'h00004800; op_b = 32'h00004000; start = 1; #10; start = 0; #20; // 3.0 / 2.0 = 1.5
        op_a = 32'h00000000; op_b = 32'h00003C00; start = 1; #10; start = 0; #20; // 0.0 / 1.0 = 0.0
        op_a = 32'h00003C00; op_b = 32'h00000000; start = 1; #10; start = 0; #20; // 1.0 / 0.0 = Inf
        op_a = 32'h00007C00; op_b = 32'h00007C00; start = 1; #10; start = 0; #20; // Inf / Inf = NaN
        op_a = 32'h00000000; op_b = 32'h00000000; start = 1; #10; start = 0; #20; // 0.0 / 0.0 = NaN

        #50;
        $finish;
    end

    initial begin
        $dumpfile("fp16_normal_cases.vcd");
        $dumpvars(0, tb_FP16_normal_cases);
    end

endmodule
