`include "constants.vh"

module music_box (
  input wire clk, // 12Mhz
  output reg speaker_out // Salida del parlante (frecuencia de cada nota)
);

// Se definen como parametros para modificarlas desde el testbench,
// ya que los valores reales tardan mucho en reproducirse
parameter
  note_C = `FREQ_C,
  note_D = `FREQ_D,
  note_E = `FREQ_E,
  note_F = `FREQ_F,
  note_G = `FREQ_G,
  note_A = `FREQ_A,
  note_AHash = `FREQ_AHash,
  note_PlusC = `FREQ_PlusC,
  note_duration = `T_250ms;

// Las salidas del speaker
wire C, D, E, F, G, A, AHash, PlusC;

frequency_divider #(note_C) OUTC ( .clk(clk), .clk_out(C) );
frequency_divider #(note_D) OUTD ( .clk(clk), .clk_out(D) );
frequency_divider #(note_E) OUTE ( .clk(clk), .clk_out(E) );
frequency_divider #(note_F) OUTF ( .clk(clk), .clk_out(F) );
frequency_divider #(note_G) OUTG ( .clk(clk), .clk_out(G) );
frequency_divider #(note_A) OUTA ( .clk(clk), .clk_out(A) );
frequency_divider #(note_AHash) OUTAHash ( .clk(clk), .clk_out(AHash) );
frequency_divider #(note_PlusC) OUTPlusC ( .clk(clk), .clk_out(PlusC) );

// note_counter cuenta desde 00000 a 11000 (24), 24 notas y el resto silencio,
// para eso se necesitan 5 bits (2^5 = 32 > 25)
reg [4:0] note_counter = 0;

// Las notas deben tener cierta duracion, por lo que deben cambiar cuando esta
// duracion termine y no en cada flanco del reloj principal
wire clk_note_duration;
frequency_divider #(note_duration) NOTE_TIMER ( .clk(clk), .clk_out(clk_note_duration) );

always @(posedge clk_note_duration) begin
  note_counter <= note_counter + 1;
end

// Mux de seleccion de la nota que se asignara a la salida
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