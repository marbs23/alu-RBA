`timescale 1ns/1ps
module tb_alu;
    reg [4:0] a;
    reg [4:0] b;
    reg [2:0] ALUControl;
    wire [4:0] Result;
    wire [3:0] ALUFlags;

    alu uut (
        .a(a),
        .b(b),
        .ALUControl(ALUControl),
        .Result(Result),
        .ALUFlags(ALUFlags)
    );

    initial begin
        a = 3; b = 5; ALUControl = 3'b000; #10;

        a = 5; b = 5; ALUControl = 3'b001; #10;

        a = 8; b = 1; ALUControl = 3'b010; #10;

        a = 5; b = 7; ALUControl = 3'b011; #10;
        
        a = 5; b = 7; ALUControl = 3'b100; #10;

        $stop; 
    end
endmodule