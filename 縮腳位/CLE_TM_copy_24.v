`timescale 1ns/10ps

module CLE_TM ( clk, reset, rom_q_o, rom_a_o, sram_q_o, sram_a_o, sram_d_o, sram_wen_o, finish_o, Dtype_o);
//CLE_TM - TB
input         clk;
input         reset;
input    [7:0]	  rom_q_o;
output reg    rom_a_o;  
input   [6:0] sram_q_o;
output reg    sram_a_o;	
output reg    sram_d_o;	
output reg    sram_wen_o;
output     finish_o;
output  reg   [1:0] Dtype_o;
//--------------------
//CLE_TM - CLE
wire   [7:0]  rom_q_i;
wire    	[6:0]  rom_a_i;  
wire   [7:0]  sram_q_i;
wire       [9:0]  sram_a_i;	
wire       [7:0]  sram_d_i;	
wire         sram_wen_i;
wire         finish_i;
wire 		 [1:0] Dtype_i;	// 0 : nothing / 1 : rom_a / 2 : sram_a / 3 : sram_d
reg  	    TD_i;	// CLE TD input
//====================
//shift registers
reg [6:0]  rom_a_shift;		
reg [9:0]  sram_a_shift;
reg [7:0]  sram_d_shift;

reg  [3:0] count_send;	//count send bits

//CLE connected wires 
wire [6:0] rom_a_temp;	
wire [9:0] sram_a_temp;
wire [7:0] sram_d_temp;
wire       sram_wen_temp;
//====================

    CLE        u_CLE( 
                      .clk       (clk       ),
                      .reset     (reset     ), 
                      .rom_q     (rom_q_i     ), 
                      .rom_a     (rom_a_i     ), 
                      .sram_q    (sram_q_i    ),
                      .sram_a    (sram_a_i  ), 
                      .sram_d    (sram_d_i    ), 
                      .sram_wen  (sram_wen_i  ), 
                      .finish    (finish_i    ),
					  .Dtype	 (Dtype_i),
					  .TD		 (TD_i)
                    );
			
// TB -> CLE
	assign rom_q_i = rom_q_o;
	assign sram_q_i = {1'b0,sram_q_o};
	assign finish_o = finish_i;  

//count_send
	always @ (negedge clk or posedge reset) begin
		if(reset)  count_send<= 4'd0;
		else   		
			case(Dtype_i)
				2'd1 : 
					count_send <= (count_send == 4'd7) ? 4'd0 : count_send + 4'd1;	// count to 7
				2'd2 : 
					count_send <= (count_send == 4'd11) ? 4'd0 : count_send + 4'd1; // count to 11
				2'd3 :
					count_send <= (count_send == 4'd9) ? 4'd0 : count_send + 4'd1;  // count to 9
				default : begin
					count_send <= 4'd0;
				end	
			endcase
	end

//TD_i
	always @ (negedge clk or posedge reset) begin
		if(reset)  TD_i <= 1'd0;
		else   		
			case(Dtype_i)
				2'd1 : 
					TD_i <= (count_send == 4'd7) ? 1'd1 : 1'd0;
				2'd2 : 
					TD_i <= (count_send == 4'd11) ? 1'd1 : 1'd0;
				2'd3 :
					TD_i <= (count_send == 4'd9) ? 1'd1 : 1'd0;
				default : begin
					TD_i <= 1'd0;
				end	
			endcase
	end
//rom_a
	assign rom_a_temp = rom_a_i;
	
	always @ (posedge clk or posedge reset) begin	// ** posedge **
		if(reset)  rom_a_shift <= 7'd0;
		else   		
			if(Dtype_i == 2'd1)
				if(count_send == 4'd1)	
					rom_a_shift <= rom_a_temp;
				else 
					rom_a_shift <= {rom_a_shift[5:0],1'd0};
			else
				rom_a_shift <= rom_a_shift;
	end
	
	always @ (negedge clk or posedge reset) begin	// ** negedge **
		if(reset)  rom_a_o <= 1'd0;
		else   		
			if(Dtype_i == 2'd1 && count_send != 4'd0) begin	
				rom_a_o <= rom_a_shift[6];
			end
			else begin
				rom_a_o <= rom_a_o;
			end
	end
//sram_a
	assign sram_a_temp = sram_a_i;
	
	always @ (posedge clk or posedge reset) begin		// ** posedge **
		if(reset)  sram_a_shift <= 10'd0;
		else   		
			if(Dtype_i == 2'd2)
				if(count_send == 4'd1)	
					sram_a_shift <= sram_a_temp;
				else 
					sram_a_shift <= {sram_a_shift[8:0],1'd0};
			else
				sram_a_shift <= sram_a_shift;
	end
	
	always @ (negedge clk or posedge reset) begin	   // ** negedge **
		if(reset)  sram_a_o <= 10'd0;
		else   		
			if(Dtype_i == 2'd2 && count_send != 4'd0) begin	
				sram_a_o <= sram_a_shift[9];
			end
			else begin
				sram_a_o <= sram_a_o;
			end
	end
//sram_d
	assign sram_d_temp = sram_d_i;
	
	always @ (posedge clk or posedge reset) begin		// ** posedge **
		if(reset)  sram_d_shift <= 8'd0;
		else   		
			if(Dtype_i == 2'd3)
				if(count_send == 4'd1)	
					sram_d_shift <= sram_d_temp;
				else 
					sram_d_shift <= {sram_d_shift[6:0],1'd0};
			else
				sram_d_shift <= sram_d_shift;
	end
	
	always @ (negedge clk or posedge reset) begin		// ** negedge **
		if(reset)  sram_d_o <= 1'd0;
		else   		
			if(Dtype_i == 2'd3 && count_send != 4'd0) begin	
				sram_d_o <= sram_d_shift[7];
			end
			else begin
				sram_d_o <= sram_d_o;
			end
	end
//sram_wen
	assign sram_wen_temp = sram_wen_i;
	
	always@	(negedge clk or posedge reset) begin		// ** negedge **
		if(reset)  sram_wen_o <= 1'd1;
		else begin
			if(Dtype_i == 2'd3 && count_send == 4'd9)
				sram_wen_o <= 1'd0;
			else
				sram_wen_o <= 1'd1;
		end
	end
//Dtype_o
	always@	(negedge clk or posedge reset) begin		// ** negedge **
		if(reset)  Dtype_o <= 2'd0;
		else
			Dtype_o <= Dtype_i;

	end
endmodule

//==========================================================================================================================================================

module CLE ( clk, reset, rom_q, rom_a, sram_q, sram_a, sram_d, sram_wen, finish, TD, Dtype);
input         clk;
input         reset;
input  [7:0]  rom_q;
output reg [6:0]  rom_a;
input  [7:0]  sram_q;
output reg [9:0]  sram_a;
output reg [7:0]  sram_d;
output reg        sram_wen;
output reg      finish;
//--------------
input TD;
output reg [1:0] Dtype;
//--------------
//============================================
parameter idle    = 4'd0;   // idle
parameter finit   = 4'd1;	//send sram address  data2
parameter fshift  = 4'd2;   //send sram address  data3 , if (~|counter_Y) fill in data2=> FF2
parameter f_save3 = 4'd3;	//send sram address  data5 , fill in data3 => FF3
parameter f_save5 = 4'd4;   //fill in data5 => FF5
parameter flabel  = 4'd5;	
parameter fwr     = 4'd6;   
parameter rinit   = 4'd7;	
parameter rshift  = 4'd8;   
parameter r_save3 = 4'd9;	
parameter r_save5 = 4'd10;   
parameter rlabel  = 4'd11;  
parameter rwr     = 4'd12;   
parameter done    = 4'd13;    
parameter romA    = 4'd14;    
parameter romA_2  = 4'd15;
// =========================================== define reg ===========================================
reg first_scan;     // 1-> first_scan
reg init_count;
reg [4:0] counter_X;//address for scan and write in sram,row, (0,0) in left top
reg [4:0] counter_Y;//column
reg nochange;
reg [3:0] cs,ns;
reg [7:0] FF1, FF2, FF3, FF4, FF5;
reg [7:0] FF_rom;
reg [7:0] ini_label;//1~251
reg ZP_sel;
reg rom_detect;
reg [7:0] Label;

// =========================================== define wire ===========================================
wire [4:0] Xsub1, Xadd1, Yadd1, Ysub1;
wire ROM_read;	//if = 1 ,count4
wire [9:0] center_addr;
wire top, buttom, left, right;
wire [7:0]  sram_q_temp;
wire [7:0] com1, com2, max_Label;
wire [6:0] rom_a_temp;


assign Xadd1  = counter_X + 5'd1;
assign Xsub1  = counter_X - 5'd1;
assign Yadd1  = counter_Y + 5'd1;
assign Ysub1  = counter_Y - 5'd1;
assign center_addr  = {counter_X, counter_Y};

// boundary condition//////
assign top = ~(|counter_X);
assign buttom = &counter_X;
assign left = ~(|counter_Y);
assign right = &counter_Y;
// =========================================== INDEX =========================================
	//  - FSM done
	//  - decide padding done
	//  - kernel dnoe
    //  - Label dnoe
	//  - comparator dnoe
	//  - rom_a dnoe
	//  - rom_detect dnoe
	//  - sram_a dnoe
	//  - sram_d dnoe
	//  - sram_wen done
	//  - counter X Y done 
	//  - first_scan flag done
	//  - nochange done
	//  - finish done
// ============================================================================================	
// FSM  done
always @ (*) begin
	case(cs)
		idle :  
			ns = finit;
		finit :
			if(TD)
				ns = fshift;
			else
				ns = finit;
        fshift :  
			if(TD)
				ns = f_save3;
			else
				ns = fshift;
        f_save3 :
			if(TD)
				if (first_scan)begin//first scan don't need to fill in sram data5 to FF5
						ns = romA;
					end
					else begin
						ns = f_save5;//not first scan
					end
			else
				ns = f_save3;
		romA :	
			if(TD)
				ns = romA_2;
			else 
				ns = romA;
		romA_2 :	
			ns = flabel;
        f_save5 :
            ns = flabel;
        flabel :   
            ns = fwr;
        fwr :
			if(TD) begin
				if(&counter_Y)begin
					if(&counter_X) begin //(x,y)=(31,31)
						ns = rinit;
					end
					else //(x,y)=(0~30,31)
						ns = finit;
					end
				else//(x,y) = (0~31,0~30)
					ns = fshift;
			end
			else 
				ns = fwr;
        rinit : 
            if(TD)
				ns = rshift;
			else
				ns = rinit;
        rshift :
            if(TD)
				ns = r_save3;
			else
				ns = rshift;
        r_save3:
            if(TD)
				ns = r_save5;
			else
				ns = r_save3;
        r_save5:
            ns = rlabel;
        rlabel :  
            ns = rwr;
        rwr :  
		if(TD) begin
            if (~(|counter_Y)) begin//y=0
                if(~(|counter_X))begin //(x,y) = (0,0)
                    if(nochange)//reverse scan done and no change 
                    ns = done;
                    else //reverse scan done but change 
                    ns = finit;
                end
                else // //(x,y) = (1~31,0)
                    ns = rinit;
            end
            else 
                ns = rshift;
		end
		else
			ns = rwr;
        done :    
            ns = done;
		default : begin
			ns = idle;
		end
	endcase
end
// Dtype // 0 : nothing / 1 : rom_a / 2 : sram_a / 3 : sram_d
	always @ (*) begin
		case(cs)
			finit :
				Dtype = 2'd2;
			fshift :  
				Dtype = 2'd2;
			f_save3 :
				Dtype = 2'd2;
			f_save5 :
				Dtype = 2'd2;
			romA :	
				Dtype = 2'd1;
			fwr :
				Dtype = 2'd3;
			rinit : 
				Dtype = 2'd2;
			rshift :
				Dtype = 2'd2;
			r_save3:
				Dtype = 2'd2;
			r_save5:
				Dtype = 2'd2;
			rwr :  
				Dtype = 2'd3;
			default : begin
				Dtype = 2'd0;
			end
		endcase
	end


always @ (posedge clk or posedge reset) begin
	if(reset) cs <= idle;
	else cs <= ns;
end
/////////////////////////////////////////////////////////////////////////
// decide padding done
always @(*) begin
	case(cs)
		fshift : 
			    ZP_sel = top;
        f_save3 :
                ZP_sel = (top||right);  //get new FF3 DATA
        rshift :         //INITIALIZE FF2 DATA
			    ZP_sel = buttom;
        r_save3 :
                ZP_sel = (buttom||left);  //get new FF3 DATA      
		default :
			ZP_sel = 1'b0;
	endcase
end

assign sram_q_temp = (ZP_sel) ? 20'd0 : sram_q;

//////////////////////////////////////////////////////////////////////////
// kernel 
/*--------------------------------------------------------------------
	if FF has shift property need TD to block,
	since it should only be triggered at the end of the state
--------------------------------------------------------------------*/
always@	(posedge clk or posedge reset) begin
    if(reset) FF1 <= 8'd0;
    else  begin
		if(TD)
			case (cs)
				finit:
					FF1 <= 8'd0;
				fwr :
					FF1 <= FF2;
				rinit:
					FF1 <= 8'd0;
				rwr:
					FF1 <= FF2;
			endcase
    end
end

always@	(posedge clk or posedge reset) begin
    if(reset) FF2 <= 8'd0;
    else  begin
		if(TD)
			case (cs)
				fshift:
					if(~(|counter_Y))//y=0 means change row
						FF2 <= sram_q_temp;
					else
						FF2 <= FF2;
				fwr :
					FF2 <= FF3;
				rshift:
					if(&counter_Y)//y=31 means change row
						FF2 <= sram_q_temp;
					else
						FF2 <= FF2;
				rwr:
					FF2 <= FF3;
			endcase
	end
end

always@	(posedge clk or posedge reset) begin
    if(reset) FF3 <= 8'd0;
    else  begin
		//if(TD)						
			case (cs)
				f_save3:
					FF3 <= sram_q_temp;
				r_save3:
					FF3 <= sram_q_temp;
			endcase
    end
end

always@	(posedge clk or posedge reset) begin
    if(reset) FF4 <= 8'd0;
    else  begin
		if(TD)
			case (cs)
				finit:
					FF4 <= 8'd0;
				fwr :
					FF4 <= FF5;
				rinit:
					FF4 <= 8'd0;
				rwr:
					FF4 <= FF5;
			endcase
    end
end

always@	(posedge clk or posedge reset) begin
    if(reset) begin 
        FF5 <= 8'd0;
        ini_label <= 8'd1;
    end
    else  begin
			case (cs)
			f_save5:
					FF5 <= sram_q_temp;
			flabel:
					if(first_scan)begin
						if(!rom_detect)begin	//rom data == 0
							FF5 <= 8'd0;
						end
						else if((FF1 || FF2 || FF3 || FF4)) begin//rom data == 1 && others have data
							FF5 <= max_Label;
						end
						else begin//rom data == 1 && others don't have data
							FF5 <= ini_label;
							ini_label <= ini_label + 8'd1;
						end
					end
					else begin
						FF5 <= Label;//if sram data != 8'd0  fill in the most big data
					end
			r_save5:
					FF5 <= sram_q_temp;
			rlabel:
					FF5 <= Label;
			endcase
    end
end

////////////////////////////////////////////////////////////////////////
// Label done
always @(*) begin
    if( !sram_q_temp || !(FF1 || FF2 || FF3 || FF4))//sram data==0 || FF1~FF4==0
        Label = sram_q_temp;
    else
        Label = max_Label;
end
//////////////////////////////////////////////////////////////////////////
// comparator done
assign com1 = (FF1>FF2) ? FF1 : FF2;
assign com2 = (FF3>FF4) ? FF3 : FF4;
assign max_Label = (com1>com2) ? com1 : com2;
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
//rom_a done
assign rom_a_temp = {counter_X , counter_Y[4:3]};

always@	(negedge clk or posedge reset) begin
    if(reset)  rom_a<= 7'd0;
    else   rom_a <= rom_a_temp;
end
/*--------------------------------------------------------------------
	since FF_rom need to be fixed before end of flabel and rlabel
--------------------------------------------------------------------*/
always@	(negedge clk or posedge reset) begin	// ** negedge **
    if(reset) FF_rom <= 8'd0;
    else  FF_rom <= rom_q;
end
//////////////////////////////////////////////////////////////////////////////
// rom_detect done
always @ (*) begin  
	case(counter_Y[2:0])
        3'd0 : 
            rom_detect = FF_rom[7];
        3'd1 :
            rom_detect = FF_rom[6];
        3'd2 :
            rom_detect = FF_rom[5];
        3'd3 :
            rom_detect = FF_rom[4];
        3'd4 :
            rom_detect = FF_rom[3];
        3'd5 :
            rom_detect = FF_rom[2];
        3'd6 :
            rom_detect = FF_rom[1];
        3'd7 :
            rom_detect = FF_rom[0];
        default :
            rom_detect = 1'd0;
    endcase
end
//////////////////////////////////////////////////////////////////////////
// sram_a  done
always @ (negedge clk or posedge reset) begin
    if(reset) begin
		sram_a <= 8'd0;
	end
    else begin
        case (cs)
		    finit :
                sram_a <= {Xsub1,counter_Y};//data2
            fshift :   
                sram_a <= {Xsub1,Yadd1};//data3
            f_save3 :
                sram_a <= center_addr;//data5
            rinit : 
                sram_a <= {Xadd1,counter_Y};//data2
            rshift :
                sram_a <= {Xadd1,Ysub1};//data3
            r_save3:
                sram_a <= center_addr;//data5
		    default : begin
		    	sram_a <= sram_a;
		    end
        endcase
    end
end
   
/////////////////////////////////////////////////////////////////////////
//sram_d done
always @ (negedge clk or posedge reset) begin
	if(reset) begin
		sram_d <= 8'd0;
	end
	else if (cs == fwr || cs == rwr)begin
        sram_d <= FF5;
    end
end

////////////////////////////////////////////////////////////////////////
// sram_wen done
always @ (negedge clk or posedge reset) begin
	if(reset) begin
		sram_wen <= 1'd1;
	end
    else begin
        case (cs)
	    	finit :
                sram_wen <= 1'd1;
            fshift :   
                sram_wen <= 1'd1;
            fwr :
                sram_wen <= 1'd0;
            rinit : 
                sram_wen <= 1'd1;
            rshift :
                sram_wen <= 1'd1;
            rwr :   
                sram_wen <= 1'd0;
	    	default : begin
	    		sram_wen <= 1'd1;
	    	end
        endcase
    end
end

// counter X Y done
always @ (posedge clk or posedge reset) begin
	if(reset) begin
		counter_X <= 5'd0;
		counter_Y <= 5'd0;	
	end
	else begin
        case (cs)
            fwr:
				if(TD) begin
					if(&counter_Y)begin//y=31
						if(&counter_X)begin//(x,y)=(31,31)
						counter_X <= counter_X;
						counter_Y <= counter_Y;	
						end
						else begin//(x,y)=(0~30,31) change row//
							counter_X <= counter_X+5'd1;
							counter_Y <= 5'd0;	
						end
	
					end
					else begin
						counter_X <= counter_X;
						counter_Y <= counter_Y + 5'd1;
					end
				end
            rwr:
				if(TD) begin
					if (~(|counter_Y))begin//y=0
						if(~(|counter_X))begin//(x,y)=(0,0)
						counter_X <= counter_X;
						counter_Y <= counter_Y;	
						end
						else begin//(x,y)=(1~31,31) change row//
							counter_X <= counter_X-5'd1;
							counter_Y <= 5'd31;	
						end
					end
					else begin
						counter_X <= counter_X;
						counter_Y <= counter_Y - 5'd1;
					end
				end
            default: begin
                counter_X <= counter_X;
		        counter_Y <= counter_Y;
            end
        endcase
	end
end
//////////////////////////////////////////////////////////////////////////
//first_scan flag done
always @ (posedge clk or posedge reset) begin
    if(reset) first_scan <= 1'b1;
	else if (cs==fwr && &center_addr) first_scan <= 1'b0; //(x,y)=(31,31) flag inverse
end

//nochange done
 always@(negedge clk or posedge reset)begin
    if(reset) begin
		nochange <= 1'd1;
	end
    else if (cs == rlabel && (FF5 != Label) && (FF5 != 0)) begin
        nochange <= 1'd0;
    end
    else if (cs == finit)begin
        nochange <= 1'd1;
    end
 end
////////////////////////////////////////////////////////////////////////

//finish done
always @ (posedge clk or posedge reset) begin
    if (reset) begin
		finish <= 1'd0;
	end
	else if(cs == done)
        finish <= 1'd1;
end
////////////////////////////////////////////////////////////////////////
endmodule
