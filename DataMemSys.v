`timescale 1ns / 1ps

module DataMemSys (
    input clk,
    input MemRead,
    input MemWrite,
    input [9:0] addr,
    input [31:0] data_in,
    output [31:0] data_out,
    output stall);
    
    
wire ready;
wire fill;
wire update;
wire MsRead;    
wire [2:0] tag; 
wire [4:0] index;
wire [1:0] offset;
wire MsReady;
wire [127:0]MsData_out;
assign offset = addr[1:0];
assign index = addr[6:2];
assign tag = addr [9:7];    
    
DataCacheController controller(clk, reset, MemRead, MemWrite, index , tag, stall, fill,update,MsRead, MsReady);
 
DataCache data_cache(
     clk,
     update,
     fill,
     offset,
     index,
     data_in,
     data_out,
     MsData_out);  

DataMem datamem (clk, MsRead, MemWrite, addr, data_in, MsData_out, ready);
  
  
endmodule