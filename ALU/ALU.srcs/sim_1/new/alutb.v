`timescale 1ns/1ps
module tb_alu;
    reg [4:0] a;
    reg [4:0] b;
    reg [2:0] bshift;
    reg [2:0] ALUControl;
    wire [4:0] Result;
    wire [3:0] ALUFlags;

    top topi(
        .a(a),
        .b(b),
        .ALUControl(ALUControl),
        .bshift(bshift),
        .Result(Result),
        .ALUFlags(ALUFlags)
    );

    initial begin
        a = 5; b = 7; bshift = 3'b000 ;ALUControl = 3'b011; #10;

        a = 3; b = 5; bshift = 3'b001 ;ALUControl = 3'b000; #10;

        a = 5; b = 5; bshift = 3'b010 ;ALUControl = 3'b001; #10;

        a = 8; b = 1; bshift = 3'b011 ;ALUControl = 3'b010; #10;

        a = 5; b = 7; bshift = 3'b100 ;ALUControl = 3'b011; #10;
        
        a = 5; b = 7; bshift = 3'b101 ;ALUControl = 3'b011; #10;

        a = 5; b = 7; bshift = 3'b110 ;ALUControl = 3'b011; #10;

        a = 5; b = 7; bshift = 3'b111 ;ALUControl = 3'b011; #10;

        $stop; 
    end
endmodule
