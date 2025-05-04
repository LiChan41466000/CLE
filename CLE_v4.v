`timescale 1ns/10ps

module CLE ( clk, reset, rom_q, rom_a, sram_q, sram_a, sram_d, sram_wen, finish,test_out1,test_out2,FF1,FF2,FF3,FF4);
input         clk;
input         reset;
input  [7:0]  rom_q;
output reg [6:0]  rom_a;
input  [7:0]  sram_q;
output reg [9:0]  sram_a;
output reg [7:0]  sram_d;
output reg        sram_wen;
output reg      finish;
output [7:0]test_out1;
output [7:0]test_out2;
output [7:0]FF1;
output [7:0]FF2;
output [7:0]FF3;
output [7:0]FF4;
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
reg [7:0]com1_reg,com2_reg;

// =========================================== define wire ===========================================
wire [4:0] Xsub1, Xadd1, Yadd1, Ysub1;
wire ROM_read;	//if = 1 ,count4
wire [9:0] center_addr;
wire top, buttom, left, right;
wire [7:0]  sram_q_temp;
wire [7:0] com1, com2, max_Label;
//wire [7:0]max_Label;
wire [7:0] rom_a_temp;


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
// =========================================== INDEX ==========================================
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
            ns = fshift;
        fshift :   
            ns = f_save3;
        f_save3 :
            if (first_scan)begin//first scan don't need to fill in sram data5 to FF5
                ns = flabel;
            end
            else
                ns = f_save5;//not first scan
        f_save5 :
            ns = flabel;
        flabel :   
            ns = fwr;
        fwr :
            if(&counter_Y)begin
              if(&counter_X) begin //(x,y)=(31,31)
                ns = rinit;
              end
              else //(x,y)=(0~30,31)
                ns = finit;
            end
            else//(x,y) = (0~31,0~30)
              ns = fshift;
        rinit : 
            ns = rshift;
        rshift :
            ns = r_save3;
        r_save3:
            ns = r_save5;
        r_save5:
            ns = rlabel;
        rlabel :  
            ns = rwr;
        rwr :   
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
        done :    
            ns = done;
		default : begin
			ns = idle;
		end
	endcase
end

always @ (posedge clk) begin
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
// kernel done
always@	(posedge clk) begin
    if(reset) FF1 <= 8'd0;
    else  begin
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

always@	(posedge clk) begin
    if(reset) FF2 <= 8'd0;
    else  begin
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

always@	(posedge clk) begin
    if(reset) FF3 <= 8'd0;
    else  begin
        case (cs)
            f_save3:
                FF3 <= sram_q_temp;
            r_save3:
                FF3 <= sram_q_temp;
        endcase
    end
end

always@	(posedge clk) begin
    if(reset) FF4 <= 8'd0;
    else  begin
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

always@	(posedge clk) begin
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
//assign max_Label = ((FF1 > FF2) ? FF1 : FF2) > ((FF3 > FF4) ? FF3 : FF4) ?
//                   ((FF1 > FF2) ? FF1 : FF2) :
//                   ((FF3 > FF4) ? FF3 : FF4);
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
//rom_a done
assign rom_a_temp = {counter_X , counter_Y[4:3]};

always@	(negedge clk) begin
    if(reset)  rom_a<= 7'd0;
    else   rom_a <= rom_a_temp;
end

always@	(posedge clk) begin
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
always @ (negedge clk) begin
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
always @ (negedge clk) begin
	if(reset) begin
		sram_d <= 8'd0;
	end
	else if (cs == fwr || cs == rwr)begin
        sram_d <= FF5;
    end
end

////////////////////////////////////////////////////////////////////////
// sram_wen done
always @ (negedge clk) begin
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
always @ (posedge clk) begin
	if(reset) begin
		counter_X <= 5'd0;
		counter_Y <= 5'd0;	
	end
	else begin
        case (cs)
            fwr:
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

            rwr:
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
            default: begin
                counter_X <= counter_X;
		        counter_Y <= counter_Y;
            end
        endcase
	end
end
//////////////////////////////////////////////////////////////////////////
//first_scan flag done
always @ (posedge clk) begin
    if(reset) first_scan <= 1'b1;
	else if (cs==fwr && &center_addr) first_scan <= 1'b0; //(x,y)=(31,31) flag inverse
end

//nochange done
 always@(negedge clk)begin
    if(reset) begin
		nochange <= 1'd1;
	end
    else if (cs == rlabel && (FF5 != Label) && (FF5 != 8'd0)) begin
        nochange <= 1'd0;
    end
    else if (cs == finit)begin
        nochange <= 1'd1;
    end
 end
////////////////////////////////////////////////////////////////////////

//finish done
always @ (posedge clk) begin
    if (reset) begin
		finish <= 1'd0;
	end
	else if(cs == done)
        finish <= 1'd1;
end
////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////

//testing
always@(posedge clk)begin
    if(reset)begin
        com1_reg<=8'd0;
        com2_reg<=8'd0;
    end
    else begin
        com1_reg<=com1;
        com2_reg<=com2;
    end
end

assign test_out1 = com1_reg;
assign test_out2 = com2_reg;
/////////////////////////////////////////////////////////////////////////
endmodule
