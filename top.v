module top(
input		wire		clk,
input		wire		rst_n,
input		wire		key1,
input		wire		key2,	
output		wire [3:0]	led	

	);

wire   [1:0]po_money;
wire   po_key_flag1;
wire   po_key_flag2;

key  inst_key (
			.clk         (clk),
			.rst_n       (rst_n),
			.key         (key1),
			.po_key_flag (po_key_flag1)
		);

key inst_key1 (
			.clk         (clk),
			.rst_n       (rst_n),
			.key         (key2),
			.po_key_flag (po_key_flag2)
		);


fsm inst_fsm (
			.clk      (clk),
			.rst_n    (rst_n),
			.key1     (po_key_flag1),
			.key2     (po_key_flag2),
			.po_money (po_money)
		);


led  inst_led (
			.clk     (clk),
			.rst_n   (rst_n),
			.flag_sd (po_money),
			.led     (led)
		);


endmodule
