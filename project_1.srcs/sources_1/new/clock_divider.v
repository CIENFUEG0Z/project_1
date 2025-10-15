`timescale 1ns / 1ps

module clock_divider(
    input logic [16:0]clk,
    input logic rst,
    output logic [16:0]clk_out
    );

assign DIV = 16'b0; 

always_ff@(posedge clk) //rst síncrono, consideramos clock de 16 bits, que es poco mas de 60 segundos
    if (rst) clk_out <= 16'b0;
    else clk_out <= clk_out + 1;
endmodule
