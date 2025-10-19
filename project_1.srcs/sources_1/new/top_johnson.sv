module top_johnson(
    input logic clk,
    input logic btnL,
    input logic [1:0]sw,
    output logic [0:3] led );

    logic clk_1_hz; // señal/cable que conecta salida de clock_divider con 
    logic [3:0] q_out; // señal/cable que conecta la salida del seq4 con las luces led
    assign led = q_out;//asignacion combinacional (continuo, no depende de flanco)
    assign rst_invertido = sw[1]; 
    assign enable = sw[0];
    
    clock_divider #(
        .DIV(50_000_000) // mantenemos el valor
    ) clock_divider_inst (
        .clk(clk),
        .rst(rst_invertido),
        .clk_out(clk_1_hz)  );
    
    seq4 seq4_inst (
        .clk(clk_1_hz),
        .rst(rst_invertido),
        .en(enable),  // Ahi queda conectado al switch 0,
        .Q(q_out)   );

endmodule
