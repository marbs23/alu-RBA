module alu(input [4:0] a, b,
    input [1:0] ALUControl,
    output reg [4:0] Result,
    output wire [3:0] ALUFlags);
    
    wire neg, zero, carry, overflow;
    wire [4:0] condinvb;  // Corregido a 5 bits
    wire [4:0] sum;       // Corregido a 5 bits
    
    assign condinvb = ALUControl[0] ? ~b : b;
    assign sum = a + condinvb + ALUControl[0];
    
    always @(*)
    begin
        casex (ALUControl[1:0])
            2'b0?: Result = sum;
            2'b10: Result = a & b;
            2'b11: Result = a | b;
        endcase
    end
    
    assign neg      = Result[4];             
    assign zero     = (Result == 5'b0);        
    assign carry    = (ALUControl[1]==1'b0) & (a + condinvb + ALUControl[0] > 5'b11111); 
    assign overflow = (ALUControl[1]==1'b0) &
                  ~(a[4] ^ b[4] ^ ALUControl[0]) &
                  (a[4] ^ sum[4]);

    assign ALUFlags = {neg, zero, carry, overflow};

endmodule

`timescale 1ns/1ps

module tb_alu;
    reg [4:0] a;
    reg [4:0] b;
    reg [1:0] ALUControl;  // Corregido a 2 bits
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
        a = 3; b = 5; ALUControl = 2'b00; #10;
        a = 5; b = 5; ALUControl = 2'b01; #10;
        a = 8; b = 1; ALUControl = 2'b10; #10;
        a = 5; b = 7; ALUControl = 2'b11; #10;
        
        $stop; 
    end
endmodule
