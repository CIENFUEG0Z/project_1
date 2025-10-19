`timescale 1ns / 1ps

module seq4_tb;

    // Parámetros
    parameter CLK_PERIOD = 10;

    // Señales para conectar al DUT
    reg clk;
    reg rst;
    reg en;
    wire [3:0] Q;

    // Instanciar el DUT
    seq4 dut (
        .clk(clk),
        .rst(rst),
        .en(en),
        .Q(Q)
    );

    // Generador de reloj
    always begin
        clk = 0; #(CLK_PERIOD / 2);
        clk = 1; #(CLK_PERIOD / 2);
    end
    
    // Script de estímulos
    initial begin
        $display("Tiempo | rst | en | Salida Q");
        $monitor("%5t  |  %b  | %b  | %b", $time, rst, en, Q); // Imprime valores cuando cambian

        // 1. Probar el Reset
        rst = 1;
        en = 0;
        # (CLK_PERIOD * 2); // Esperar dos ciclos para asegurar el reseteo

        // 2. Probar la secuencia con enable activado
        rst = 0;
        en = 1;
        // Esperamos 10 ciclos para ver la secuencia completa (son 8 estados)
        # (CLK_PERIOD * 10);

        // 3. Probar que se detiene con enable = 0
        en = 0;
        # (CLK_PERIOD * 3); // La salida Q no debería cambiar aquí

        // 4. Continuar la secuencia
        en = 1;
        # (CLK_PERIOD * 5);

        $display("Simulación terminada.");
        $finish;
    end

endmodule