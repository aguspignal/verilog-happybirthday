/* Secuencia de notas
C C D C F E
C C D C G F
C C +C A F E D
A# A# A F G F
*/

module song_rom(
	input clk,
	input [4:0] address,
	output reg [15:0] note
);

always @(posedge clk)
case(address)
	0: note = 16'd45866;  // C
	1: note = 16'd45866;  // C
	2: note = 16'd40863;  // D
	3: note = 16'd45866;  // C 
	4: note = 16'd34361;  // F
	5: note = 16'd36404;  // E
	6: note = 16'd45866;  // C
	7: note = 16'd45866;  // C
	8: note = 16'd40863;  // D
	9: note = 16'd45866;  // C
	10: note = 16'd45866; // C
	11: note = 16'd30612; // G
	12: note = 16'd34361; // F
	13: note = 16'd45866; // C
	14: note = 16'd45866; // C
	15: note = 16'd22933; // +C
	16: note = 16'd27272; // A
	17: note = 16'd34361; // F
	18: note = 16'd36404; // E
	19: note = 16'd40863; // D
	20: note = 16'd25742; // A#
	21: note = 16'd25742; // A#
	22: note = 16'd27272; // A
	23: note = 16'd34361; // F
	24: note = 16'd30612; // G
	25: note = 16'd34361; // F
	default: note = 16'd0; 
endcase
endmodule