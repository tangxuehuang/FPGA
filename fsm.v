module fsm(
	input		wire		clk,
	input		wire		rst_n,
	input		wire        key1,
	input		wire        key2,
	output		reg [1:0]	po_money					
	);


parameter	ZERO =5'b00001;
parameter	ONE  =5'b00010;
parameter	TWO  =5'b00100;
parameter	THREE=5'b01000;
parameter	FOUR =5'b10000;
reg [4:0]state;
reg 	po_thing;
always @(posedge clk or negedge rst_n) begin
	if (rst_n== 1'b0) begin
		state <= ZERO;
	end
	else  case(state)
		ZERO:
		if(key1 == 1'b1 )begin
			state <= ONE;
		end 
		else  if(key2 == 1'b1)begin
			state <= TWO;
		end
		else begin
			state <= ZERO;
		end

		ONE  :if(key1 == 1'b1)begin
			state<=TWO;
		end 
		else  if(key2 == 1'b1)begin
			state<=THREE;
		end
		else begin
			state<=ONE;
		end 

		TWO  :if(key1 == 1'b1)begin
			state<=THREE;
		end 
		else  if(key2 == 1'b1)begin
			state<=FOUR;
		end
		else begin
			state<=TWO;
		end  

		THREE:if(key1 == 1'b1)begin
			state<=FOUR;
		end 
		else  if(key2 == 1'b1)begin
			state<=ZERO;
		end
		else begin
			state<=THREE;
		end  

		FOUR :if(key1 == 1'b1)begin
			state<=ZERO;
		end 
		else  if(key2 == 1'b1)begin
			state<=ZERO;
		end
		else begin
			state<=FOUR;
		end  
		default state<=ZERO;
	endcase

	end

always @(posedge clk or negedge rst_n) begin
	if (rst_n== 1'b0) begin
		po_money<=2'b00;
	end
	else if(state==THREE&&key2 == 1'b1)begin
		  po_money<=2'b01;
	end
	else if (state==FOUR&&key1 == 1'b1) begin
		  po_money<=2'b01;
	end
	else if(state==FOUR&&key2 == 1'b1)begin
		  po_money<=2'b10;
	end
	else po_money<=2'b00;
end
always @(posedge clk or negedge rst_n) begin
	if (rst_n== 1'b0) begin
		po_thing<='d0;
	end
	else if(state==THREE&&key2 == 1'b1)begin
		  po_thing<=1'd1;
	end
	else if (state==FOUR&&key1 == 1'b1) begin
		  po_thing<=1'd1;
	end
	else if(state==FOUR&&key2 == 1'b1)begin
		  po_thing<=1'd1;
	end
	else begin
		  po_thing<=1'd0;
	end
end
endmodule