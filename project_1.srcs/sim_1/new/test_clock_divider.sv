`timescale 1ns / 1ps

// 1. Módulo del testbench (sin puertos)
module clock_divider_tb;

    // Parámetros para la prueba
    parameter CLK_PERIOD = 10; // Periodo del reloj de entrada (10ns = 100MHz)
    parameter DIV_VALUE = 100; // Usamos un valor PEQUEÑO para simular rápido!

    // 2. Señales para conectar al DUT
    reg clk;      // 'reg' porque la controlamos desde aquí
    reg rst;      // 'reg' porque la controlamos desde aquí
    wire clk_out; // 'wire' porque es una salida del DUT

    // 3. Instanciar el DUT
    clock_divider #(
        .DIV(DIV_VALUE) // Sobreescribimos el parámetro para que la simulación sea rápida
    ) dut (
        .clk(clk),
        .rst(rst),
        .clk_out(clk_out)
    );

    // 4. Generador de reloj para la entrada clk
    always begin
        clk = 0; #(CLK_PERIOD / 2);
        clk = 1; #(CLK_PERIOD / 2);
    end

    // 5. Script de estímulos (el "qué hacer")
    initial begin
        // Fase 1: Probar el Reset
        $display("Iniciando simulación: Probando el reset...");
        rst = 1; // Activar el reset
        # (CLK_PERIOD * 5); // Esperar 5 ciclos de reloj
        
        $display("Quitando el reset...");
        rst = 0; // Desactivar el reset
        
        // Fase 2: Dejar que el contador corra
        // Esperamos el tiempo suficiente para ver varios cambios en clk_out
        // clk_out cambiará cada DIV_VALUE ciclos. Esperemos 3 cambios.
        # (CLK_PERIOD * DIV_VALUE * 3);

        // Fase 3: Volver a probar el reset mientras corre
        $display("Probando el reset de nuevo...");
        rst = 1;
        # (CLK_PERIOD * 5);
        rst = 0;

        # (CLK_PERIOD * DIV_VALUE * 2);
        
        $display("Simulación terminada.");
        $finish; // Terminar la simulación
    end

endmodule