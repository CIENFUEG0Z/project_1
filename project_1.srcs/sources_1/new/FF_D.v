`timescale 1ns / 1ps
module FF_D_sin_rst_sincrono(input logic clk,
                        input logic[3:0]D,
                        output logic[3:0]Q);

always_ff@(posedge clk)
    Q <= D;

endmodule 