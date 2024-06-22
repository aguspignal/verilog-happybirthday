module music_box (
  input wire clk, // 12Mhz
  output reg speaker_out // Salida del parlante (frecuencia de cada nota)
);

// Divisores de la frecuencia base del reloj para obtener la nota musical
parameter
  FREQ_C = 45977,     // 261 Hz
  FREQ_D = 40955,     // 293 Hz
  FREQ_E = 36474,     // 329 Hz
  FREQ_F = 34383,     // 349 Hz
  FREQ_G = 30612,     // 391 Hz
  FREQ_A = 27272,     // 440 Hz
  FREQ_AHash = 25751, // 466 Hz
  FREQ_PlusC = 22944, // 523 Hz
  NOTE_DURATION = 3000000; // 12Mhz / 3Mhz = 4 --> T = 0.25s = 250ms

// Valores DE PRUEBA para usar en el testbench y que la simulacion sea viable
parameter
  Test_C = 256,    
  Test_D = 128,    
  Test_E = 64,    
  Test_F = 32,    
  Test_G = 16,    
  Test_A = 8,    
  Test_AHash = 4,
  Test_PlusC = 2,
  Test_NOTE_DURATION = 300;

wire C, D, E, F, G, A, AHash, PlusC; // Salidas que se asignan al speaker
wire clk_note_duration;
reg [4:0] note_counter = 0;

// Asignamos a cada salida su frecuencia correspondiente
frequency_divider #(FREQ_C) OUTC ( .clk(clk), .clk_out(C) );
frequency_divider #(FREQ_D) OUTD ( .clk(clk), .clk_out(D) );
frequency_divider #(FREQ_E) OUTE ( .clk(clk), .clk_out(E) );
frequency_divider #(FREQ_F) OUTF ( .clk(clk), .clk_out(F) );
frequency_divider #(FREQ_G) OUTG ( .clk(clk), .clk_out(G) );
frequency_divider #(FREQ_A) OUTA ( .clk(clk), .clk_out(A) );
frequency_divider #(FREQ_AHash) OUTAHash ( .clk(clk), .clk_out(AHash) );
frequency_divider #(FREQ_PlusC) OUTPlusC ( .clk(clk), .clk_out(PlusC) );

frequency_divider #(NOTE_DURATION) NOTE_TIMER ( .clk(clk), .clk_out(clk_note_duration) );

always @(posedge clk_note_duration) begin
  note_counter <= note_counter + 1;
end

// !! DESCOMENTAR ESTO Y COMENTAR ARRIBA PARA TESTEAR !!
// frequency_divider #(Test_C) OUTC ( .clk(clk), .clk_out(C) );
// frequency_divider #(Test_D) OUTD ( .clk(clk), .clk_out(D) );
// frequency_divider #(Test_E) OUTE ( .clk(clk), .clk_out(E) );
// frequency_divider #(Test_F) OUTF ( .clk(clk), .clk_out(F) );
// frequency_divider #(Test_G) OUTG ( .clk(clk), .clk_out(G) );
// frequency_divider #(Test_A) OUTA ( .clk(clk), .clk_out(A) );
// frequency_divider #(Test_AHash) OUTAHash ( .clk(clk), .clk_out(AHash) );
// frequency_divider #(Test_PlusC) OUTPlusC ( .clk(clk), .clk_out(PlusC) );
// frequency_divider #(Test_NOTE_DURATION) NOTE_TIMER ( .clk(clk), .clk_out(clk_note_duration) );

always @(posedge clk) begin
  case (note_counter)
        0: speaker_out <= C;
        1: speaker_out <= C;
        2: speaker_out <= D;
        3: speaker_out <= C;
        4: speaker_out <= F;
        5: speaker_out <= E;

        6: speaker_out <= C;
        7: speaker_out <= C;
        8: speaker_out <= D;
        9: speaker_out <= C;
        10: speaker_out <= G;
        11: speaker_out <= F;

        12: speaker_out <= C;
        13: speaker_out <= C;
        14: speaker_out <= PlusC;
        15: speaker_out <= A;
        16: speaker_out <= F;
        17: speaker_out <= E;
        18: speaker_out <= D;
        
        19: speaker_out <= AHash;
        20: speaker_out <= AHash;
        21: speaker_out <= A;
        22: speaker_out <= F;
        23: speaker_out <= G;
        24: speaker_out <= F;
        default: speaker_out <= 0; // 25 -> 32 silencio
  endcase
end

endmodule