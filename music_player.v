module music_player (
    input clk, // 12 MHz clock input
    input rst,
    output reg speaker // deberia ser wire?
);

// constantes con las frecuencias de cada nota y del reloj
parameter freq_clk = 25'd12000000,
        freq_note_c = 25'd261,
        freq_note_d = 25'd293,
        freq_note_e = 25'd329,
        freq_note_f = 25'd349,
        freq_note_g = 25'd392,
        freq_note_a = 25'd440,
        freq_note_a_hash = 25'd466,
        freq_note_plus_c = 25'd523;

//ignorar esto
parameter div_c = freq_clk / freq_note_c,
        div_d = freq_clk / freq_note_d,
        div_e = freq_clk / freq_note_e,
        div_f = freq_clk / freq_note_f,
        div_g = freq_clk / freq_note_g,
        div_a = freq_clk / freq_note_a,
        div_a_hash = freq_clk / freq_note_a_hash,
        div_plus_c = freq_clk / freq_note_plus_c;

// la idea de note_counter es contar de 0 a 25 y a cada valor
// asociar una nota de la secuencia
reg [4:0] note_counter;
always @(posedge clk or negedge rst) begin
	if (rst == 0) begin
		note_counter <= 0;
        speaker <= ~speaker;
    end else begin
		note_counter <= note_counter + 1;
    end
end

// clk_divider es por lo que hay que dividir los 12MHz para
// tener la frecuencia de cierta nota (la que indique note_counter)
wire [15:0] clk_divider;
song_rom get_note_to_play(.clk(clk), .address(note_counter), .note(clk_divider));

endmodule