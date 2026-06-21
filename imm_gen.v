`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.05.2026 03:08:02
// Design Name: 
// Module Name: imm_gen
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module imm_gen(
    input [31:0] instruction,
    output reg [31:0] imm_value
);

 wire [6:0] opcode;
 
 assign opcode = instruction [6:0];
 
 always @(*)
 begin 
     case(opcode)
             7'b0010011,
        7'b0000011,
        7'b1100111:
          begin
              imm_value = {{20{instruction[31]}},
                          instruction[31:20]};
          end                
          
           7'b0100011:
        begin
            imm_value = {{20{instruction[31]}},
                          instruction[31:25],
                          instruction[11:7]};
        end

        7'b1100011:
        begin
            imm_value = {{19{instruction[31]}},
                          instruction[31],
                          instruction[7],
                          instruction[30:25],
                          instruction[11:8],
                          1'b0};
        end

        7'b0110111,
        7'b0010111:
        begin
            imm_value = {instruction[31:12],
                         12'b0};
        end

        7'b1101111:
        begin
            imm_value = {{11{instruction[31]}},
                          instruction[31],
                          instruction[19:12],
                          instruction[20],
                          instruction[30:21],
                          1'b0};
        end

        default:
        begin
            imm_value = 32'b0;
        end

    endcase

end
           

endmodule
