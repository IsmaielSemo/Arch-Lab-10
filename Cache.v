`timescale 1ns / 1ps



module DataCache (
    input clk,
    input update,
    input fill,
    input [1:0] offset,
    input [4:0] index,
    input [31:0] data_in,
    output [31:0] data_out,
    input [127:0] MsData_out);

reg [31:0] cache [0:31][0:3];

always @(posedge clk) begin
    if(fill) begin
        cache[index][0] = MsData_out[127:96]; 
        cache[index][1] = MsData_out[95:64]; 
        cache[index][2] = MsData_out[63:32]; 
        cache[index][3] = MsData_out[31:0]; 
    end
    else begin
        if(update)
            cache[index][offset] = data_in;
     end
    
end

assign data_out = cache[index][offset];

endmodule
