`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.10.2025 16:01:50
// Design Name: 
// Module Name: Register_File
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

module Register_file ( 
input logic clock,
// Source side
input logic [4:0] rs1_addr_i, 
input logic [4:0] rs2_addr_i,
// Destination side.
input logic [4:0] rd_addr_i, 
input logic wr_en_i,
input logic [31:0] wr_data_i,
// output data
output logic [31:0] rs1_data_o,
output logic [31:0] rs2_data_o
);

logic [31:0] [31:0] regfile; // 32x32 array

for (genver i = 0; i<32; i++) begin : generating_reg_file
logic reg_wr_en;
assign reg_wr_en = wr_en_i & (i[4:0] == rd_addr_i); // if rd_addr and write enable is high we write always_ff @(posedge clock)
if (reg_wr_en) begin 
if(i==0) begin
regfile[i] <= 32'h0;
end
else begin
regfile[i] <= wr_data_i;
end
end
end
assign rs1_data_o = regfile[rs1_addr_i];
assign rs2_addr_o = regfile[rs2_addr_i];
endmodule
