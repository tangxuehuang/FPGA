module led(
input		wire		    clk,
input		wire		    rst_n,
input		wire[1:0]		flag_sd,	
output		reg [3:0]		led	
	);
parameter	cnt_max=119;//11904760
parameter	cnt_max_1=124;//12499999;
reg flag_s;
reg flag_d;
reg [25:0]cnt_25;
reg [5:0]cnt_40;
reg flag_state;


always @(posedge clk or negedge rst_n) begin
	if (rst_n==1'b0) begin
		flag_d<='d0;	
	end
	else if (cnt_40==41 && cnt_25==cnt_max) begin
		flag_d <= 'd0;
	end
	else if (flag_sd == 2'b10) begin
		flag_d <= 1'b1;
	end
	else begin
		flag_d <= flag_d;
	end
end

always @(posedge clk or negedge rst_n) begin
	if (rst_n==1'b0) begin
		flag_s<='d0;	
	end
	else if (cnt_40==39 && cnt_25==cnt_max_1) begin
		flag_s <= 'd0;
		end
	else if (flag_sd ==2'b01) begin
		flag_s <= 1'b1;
	end
	else begin
		flag_s <= flag_s;
	end
end

always @(posedge clk or negedge rst_n) begin
	if (rst_n==1'b0) begin
		cnt_40 <='d0;
	end
	else if(flag_s==1'b1)
	begin 
	if (cnt_40==39 && cnt_25==cnt_max_1) begin
		        cnt_40 <='d0;
		end
	else if(cnt_25==cnt_max_1)begin
		        cnt_40 <=cnt_40 +1'b1;
		end
	end
	else if(flag_d==1'b1)
	begin if (cnt_40==41 && cnt_25==cnt_max) begin
		     cnt_40 <='d0;
		end
	else if(cnt_25==cnt_max)begin
		     cnt_40 <=cnt_40 +1'b1;
		end
	end
end

always @(posedge clk or negedge rst_n) begin
	if (rst_n==1'b0) begin
		cnt_25<='d0;
	end
	else if (flag_s==1'b1) begin
		if(cnt_25==cnt_max_1)
			cnt_25<='d0;
		else 
			cnt_25<=cnt_25+1'b1;
	end
	else if (flag_d==1'b1) begin
		if(cnt_25==cnt_max)
			cnt_25<='d0;
		else 
			cnt_25<=cnt_25+1'b1;
	end
end

always @(posedge clk or negedge rst_n) begin
	if (rst_n==1'b0) begin
		led<=4'b0001;
	end
	else if (flag_s==1'b1 && cnt_25==cnt_max_1) begin
		led<={led[2:0],led[3]};
	end
	else if(flag_d==1'b1&& cnt_25==cnt_max )begin
		 if(flag_state =='d1)begin
			led	<= {led[0],led[3:1]};
		end
		else if(flag_state =='d0)
			led	<= {led[2:0],led[3]};
	end
	else begin
	 	led<=led;
	end
end

always @(posedge clk or negedge rst_n) begin
	if (rst_n==1'b0) begin
		flag_state<='d0;
	end
	else if (led==4'b1000) begin
		flag_state<='d1;
	end
	else if (led==4'b0001) begin
		flag_state<='d0;
	end
	else begin
		flag_state <= flag_state;
	end
end

endmodule