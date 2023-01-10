module key(

	input		wire			clk,
	input		wire			rst_n,
	input		wire 			key,
	output		reg				po_key_flag			
	);

parameter	CNT_5ms = 249999;
reg 		key_reg;
reg 		cnt_flag;
reg [31:0]  key_cnt;

always @(posedge clk or negedge rst_n) begin
	if (rst_n==1'b0) begin
		key_reg<='d0;
	end
	else begin 
		key_reg<=key;
	end
end


always @(posedge clk or negedge rst_n) begin
	if (rst_n==1'b0) begin
		key_cnt<='d0;
	end
	else if (key == 1'b1 && key_reg == 1'b0) begin
		key_cnt <= 'd0;
	end
	else if (key == 1'b0 && key_reg == 1'b1) begin
		key_cnt <= 'd0;
	end
	else if(cnt_flag == 'd1)begin
		key_cnt<= key_cnt;
	end
	else if(key==0)begin
		key_cnt<= key_cnt+1'b1;
	end
end

always @(posedge clk or negedge rst_n) begin
	if (rst_n==1'b0) begin
		cnt_flag <= 'd0;
	end
	else if (key == 1'b1 && key_reg == 1'b0) begin
		cnt_flag <= 'd0;
	end
	else if (key_cnt >= CNT_5ms) begin
		cnt_flag <= 'd1;
	end
end

always @(posedge clk or negedge rst_n) begin
	if (rst_n==1'b0) begin
		po_key_flag<='d0;
	end
	else if (key_cnt == CNT_5ms && cnt_flag == 'd0) begin
		po_key_flag<='d1;
	end
	else begin
		po_key_flag<='d0;
	end
end
endmodule