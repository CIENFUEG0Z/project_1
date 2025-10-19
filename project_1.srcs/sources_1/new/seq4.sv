`timescale 1ns / 1ps

module seq4(input logic clk,
            input logic rst,
            input logic en,
            output logic[3:0]Q  );

    logic [3:0]D ;
// en primera instancia, se hizo con mapas de karnaugh, pero nos dimos cuenta
// que tenía más logica hacerlo así, en su tabla de transicion queda claro
//    assign D[3] = ~Q[0] & ((~Q[2] & ~Q[1]) | (Q[3] & Q[2]) | (Q[3] & ~Q[1]));
//    assign D[2] = Q[3] & ((~Q[1] & ~Q[0]) | (Q[2] & Q[1]) | (Q[2] & ~Q[0]));
//    assign D[1] = Q[2] & ((Q[3] & Q[1]) | (Q[3] & ~Q[0]) | (Q[1] & Q[0]));
//    assign D[0] = Q[1] & ((Q[3] & Q[2]) | (Q[2] & Q[0]) | (~Q[3] & Q[0]));
    assign D[3] = Q[2];
    assign D[2] = Q[1] ;
    assign D[1] = Q[0] ;
    assign D[0] = ~Q[3] ;

    always_ff@(posedge clk or posedge rst)//rst asíncrono, toma tambien el rst como condicion
        if (rst) Q <= 4'b0; //con rst = 1 -> registra 0000
        else
            if (en) Q <= D; //con en = 1  -> avanza al siguiente estado

endmodule
