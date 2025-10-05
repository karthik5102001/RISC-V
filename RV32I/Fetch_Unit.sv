module Fetch_unit(
input logic clock,
input logic reset_n,
input logic [31:0] instr_from_mem_pc_i,
input logic [31:0] mem_read_data_i,
output logic instr_from_mem_request_o,
output logic [31:0] instr_from_mem_address_o,
output logic [31:0] instr_from_mem_instr_o
    );
    
logic instr_memory_request_o;

always_ff @(posedge clock or negedge reset_n)
    if(!reset_n)
            instr_memory_request_o <= 1'b0;
    else 
            instr_memory_request_o <= 1'b1;   
       
assign   instr_from_mem_address_o =  instr_from_mem_pc_i;
assign   instr_from_mem_instr_o =  mem_read_data_i;
assign   instr_memory_request_o = instr_from_mem_request_o;
    
endmodule