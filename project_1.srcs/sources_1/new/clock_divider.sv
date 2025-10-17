`timescale 1ns / 1ps

module clock_divider #(
    parameter int DIV = 50_000_000 // de 100 a 1hz
)(  input logic clk,
    input logic rst,
    output logic clk_out
 );

    logic [31:0] counter;
    
    always_ff@(posedge clk) begin//rst síncrono, consideramos clock de 16 bits, que es poco mas de 60 segundos
        if (rst) begin
            counter <= 0;
            clk_out <= 0;
        end else if (counter == (DIV - 1)) begin // de 0 a div-1 son DIV puntos
            counter <= 0;
            clk_out <= ~clk_out;
        end else begin
            counter <= counter + 1;
        end
    end
    

endmodule
