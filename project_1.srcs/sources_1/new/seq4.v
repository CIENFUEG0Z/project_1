`timescale 1ns / 1ps

module seq4(input logic clk,
            input logic rst,
            input logic en,
            output logic[3:0]Q  );

    logic [3:0]D ;
    
    always_comb begin
        case (Q)
            4'b0000: D = 4'b1000;
            4'b1000: D = 4'b1100;
            4'b1100: D = 4'b1110;
            4'b1110: D = 4'b1111;
            4'b1111: D = 4'b0111;
            4'b0111: D = 4'b0011;
            4'b0011: D = 4'b0001;
            4'b0001: D = 4'b0000;
            default: D = 4'b0000; // atrapa errores, dejamos cómo default el inicial
        endcase
    end
    
    always_ff@(posedge clk)//rst y en síncrono
        if (rst) Q <= 4'b0; //con rst = 1 -> registra 0000
        else
            if (en) Q <= D; //con en = 1  -> avanza al siguiente estado

endmodule
