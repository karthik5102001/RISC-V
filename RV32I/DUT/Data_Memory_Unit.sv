

module Data_memory import Riscv_pkg ::*; ( // Data Request from current Instruction 
input logic data_req_i,
input logic [31:0] data_addr_i,
 input logic [1:0] data_byte_en_i, 
 input logic data_wr_i,
input logic [31:0] data_wr_data_i, 
input logic data_zero_extend_i,
// Read/Write request to memory output logic data_mem_req_o,
output logic [31:0] data_mem_addr_o, 
output logic [1:0] data_mem_byte_en_o, 
output logic data_mem_wr_o,
output logic [31:0] data_mem_wr_data_o,
// Read data from memory
input logic [31:0] mem_rd_data_i,
// Data Output
output logic [31:0] data_mem_rd_data_o
);

// For the read request this output will form the request for the data memory [outside the processor] 
// for write request it is expected to complete in some cycle
assign data_mem_req_o     = data_req_i;
assign data_mem_addr_o    = data_addr_i;
assign data_mem_byte_en_o = data_byte_en_i;
assign data_mem_wr_o      = data_wr_i;
assign data_mem_wr_data_o = data_wr_data_i;
// what we do when the read comes back to extend the sign
logic [31:0] rd_data_sign_extended;
logic [31:0] rd_data_zero_extended;
logic [31:0] data_mem_read_data;
assign data_mem_rd_data_o    = data_mem_read_data;
assign data_mem_read_data    = data_zero_extend_i ? rd_data_zero_extended : rd_data_sign_extended;
assign rd_data_sign_extended = (data_byte_en_i == HALF_WORD)? {{16 {mem_rd_data_i[15]}}, mem_rd_data_i[15:0]} : 
                               (data_byte_en_i == BYTE)? {{24{mem_rd_data_i[7]}}, mem_rd_data_i[7:0]}:
                                                             mem_rd_data_i;
assign rd_data_zero_extended = (data_byte_en_i == HALF_WORD)? {{16{1'b0}}, mem_rd_data_i[15:0]} : 
                               (data_byte_en_i == BYTE)? {{24{1'b0}}, mem_rd_data_i[7:0]} : 
                                                              mem_rd_data_i;
                                                              
endmodule

