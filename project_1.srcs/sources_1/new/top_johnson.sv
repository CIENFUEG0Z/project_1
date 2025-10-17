module top_johnson(
    input logic clk,
    input logic rst,
    output logic [3:0] luz_LED );

logic clk_1_hz; // señal/cable que conecta salida de clock_divider con 
logic [3:0] q_out; // señal/cable que conecta la salida del seq4 con las luces led

clock_divider #(
    .DIV(50_000_000) // mantenemos el valor
) clock_divider_inst (
    .clk(clk),
    .rst(rst),
    .clk_out(clk_1_hz)  );

seq4 seq4_inst (
    .clk(clk_1_hz),
    .rst(rst),
    .en(1'b1),  // Ahi lo dejamos siempre habilitado, nose si esta bien por los rst
    .Q(q_out)   );

assign luz_LED = q_out;

endmodule
