/*
module alu(input [4:0] a, b,
    input [1:0] ALUControl,
    output reg [4:0] Result,
    output wire [3:0] ALUFlags);
    
    wire neg, zero, carry, overflow;
    wire [3:0] condinvb;
    wire [5:0] sum;
    
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
    assign carry    = (ALUControl[1]==1'b0) & sum[5]; 
    assign overflow = (ALUControl[1]==1'b0) &
                  ~(a[4] ^ b[4] ^ ALUControl[0]) &
                  (a[4] ^ sum[4]);

    assign ALUFlags = {neg, zero, carry, overflow};

endmodule
*/



module shift(input [2:0] bshift,
             input [4:0] a,
             output reg [4:0] Result);
    always @(*)
    begin
    case (bshift[2:0])
    3'b000: Result = a >> 0;
    3'b001: Result = a >> 1;
    3'b010: Result = a >> 2;
    3'b011: Result = a >> 3;
    3'b100: Result = a >> 4;
    3'b101: Result = a >> 5;
    3'b110: Result = a >> 6;
    3'b111: Result = a >> 7;
    endcase
    end
endmodule


module alu(input [4:0] a, b,
           input [2:0] ALUControl,
    output reg [4:0] Result,
    output wire [3:0] ALUFlags);
    
    wire neg, zero, carry, overflow;
  wire [4:0] condinvb;
  wire [5:0] sum;
    
    assign condinvb = ALUControl[0] ? ~b : b;
    assign sum = a + condinvb + ALUControl[0];
    always @(*)
    begin
    casex (ALUControl[2:0])
    3'b00?: Result = sum;
    3'b010: Result = a & b;
    3'b011: Result = a | b;
    3'b100: Result = a ^ b;
    endcase
    end
    assign neg      = Result[4];             
    assign zero     = (Result == 5'b0);        
    assign carry    = (ALUControl[1]==1'b0) & sum[5]; 
    assign overflow = (ALUControl[1]==1'b0) &
                  ~(a[4] ^ b[4] ^ ALUControl[0]) &
      (a[4] ^ sum[5]);

    assign ALUFlags = {neg, zero, carry, overflow};

endmodule


module top(
    input [4:0] a, b,
    input [2:0] ALUControl,
    input [2:0] bshift,
    output [4:0] Result,
    output wire [3:0] ALUFlags);
    
    wire [4:0] w1;
    shift mudi(bshift, a, w1);
    alu mudo(w1,b,ALUControl,Result,ALUFlags); 
endmodule
