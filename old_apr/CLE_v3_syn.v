/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : P-2019.03
// Date      : Mon Aug 26 23:42:29 2024
/////////////////////////////////////////////////////////////


module CLE_DW01_inc_0 ( A, SUM );
  input [7:0] A;
  output [7:0] SUM;

  wire   [7:2] carry;

  ADDHXL U1_1_6 ( .A(A[6]), .B(carry[6]), .CO(carry[7]), .S(SUM[6]) );
  ADDHXL U1_1_5 ( .A(A[5]), .B(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  ADDHXL U1_1_4 ( .A(A[4]), .B(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  ADDHXL U1_1_3 ( .A(A[3]), .B(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  ADDHXL U1_1_2 ( .A(A[2]), .B(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  ADDHXL U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  XOR2X1 U1 ( .A(carry[7]), .B(A[7]), .Y(SUM[7]) );
  CLKINVX1 U2 ( .A(A[0]), .Y(SUM[0]) );
endmodule


module CLE ( clk, reset, rom_q, rom_a, sram_q, sram_a, sram_d, sram_wen, 
        finish );
  input [7:0] rom_q;
  output [6:0] rom_a;
  input [7:0] sram_q;
  output [9:0] sram_a;
  output [7:0] sram_d;
  input clk, reset;
  output sram_wen, finish;
  wire   n713, nochange, N299, N300, N301, N302, N303, N304, N305, N306, n16,
         n17, n18, n19, n20, n22, n23, n25, n26, n30, n33, n34, n36, n37, n38,
         n39, n40, n41, n44, n45, n46, n48, n49, n51, n53, n54, n60, n63, n66,
         n69, n75, n78, n82, n83, n84, n86, n87, n89, n90, n91, n92, n93, n94,
         n97, n98, n100, n101, n102, n103, n106, n107, n109, n110, n111, n112,
         n113, n114, n115, n116, n118, n119, n120, n122, n123, n125, n127,
         n129, n131, n133, n135, n136, n139, n141, n142, n144, n145, n146,
         n148, n149, n150, n151, n152, n154, n156, n158, n160, n161, n169,
         n171, n174, n175, n177, n204, n205, n206, n207, n214, n215, n216,
         n217, n232, n233, n234, n235, n236, n237, n238, n239, n240, n241,
         n242, n243, n244, n245, n246, n247, n248, n249, n250, n251, n252,
         n253, n254, n255, n256, n257, n258, n259, n260, n261, n262, n263,
         n264, n265, n266, n268, n269, n270, n271, n272, n273, n274, n275,
         n276, n277, n278, n279, n280, n281, n282, n283, n284, n285, n286,
         n287, n288, n289, n290, n291, n292, n293, n294, n295, n296, n297,
         n298, n299, n300, n301, n302, n303, n304, n305, n306, n307, n308,
         n309, n310, n311, n312, n313, n314, n315, n316, n317, n318, n319,
         n321, n322, n323, n325, n326, n327, n329, n330, n331, n333, n334,
         n335, n337, n338, n339, n341, n342, n343, n345, n346, n347, n348,
         n349, n350, n351, n352, n353, n354, n355, n357, n358, n360, n362,
         n364, n366, n368, n370, n372, n374, n376, n378, n379, n380, n381,
         n382, n383, n384, n385, n386, n387, n388, n389, n390, n391, n392,
         n393, n394, n395, n396, n397, n398, n399, n400, n401, n402, n403,
         n405, n406, n407, n409, n411, n413, n415, n416, n418, n420, n423,
         n425, n426, n427, n428, n429, n430, n431, n432, n433, n434, n435,
         n436, n437, n438, n439, n440, n441, n442, n443, n445, n447, n449,
         n451, n453, n455, n457, n478, n479, n480, n481, n482, n483, n484,
         n485, n486, n487, n488, n489, n490, n491, n492, n493, n494, n495,
         n496, n497, n498, n499, n500, n501, n502, n503, n504, n505, n506,
         n507, n508, n509, n510, n511, n512, n513, n514, n515, n516, n517,
         n518, n519, n520, n521, n522, n523, n524, n525, n526, n527, n528,
         n529, n530, n531, n532, n533, n534, n535, n536, n537, n538, n539,
         n540, n541, n542, n543, n544, n545, n546, n547, n548, n549, n550,
         n551, n552, n553, n554, n555, n556, n557, n558, n559, n560, n561,
         n562, n563, n564, n565, n566, n567, n568, n569, n570, n571, n572,
         n573, n574, n575, n576, n577, n578, n579, n580, n581, n582, n583,
         n584, n585, n586, n587, n588, n589, n590, n591, n592, n593, n594,
         n595, n596, n597, n598, n599, n600, n601, n602, n603, n604, n605,
         n606, n607, n608, n609, n610, n611, n612, n613, n614, n615, n616,
         n617, n618, n619, n620, n621, n622, n623, n624, n625, n626, n627,
         n628, n629, n630, n631, n632, n633, n634, n635, n636, n637, n638,
         n639, n640, n641, n642, n643, n644, n645, n646, n647, n648, n649,
         n650, n651, n652, n653, n654, n655, n656, n657, n658, n659, n660,
         n661, n662, n663, n664, n665, n666, n667, n668, n669, n670, n671,
         n672, n673, n674, n675, n676, n677, n678, n679, n680, n681, n682,
         n683, n684, n685, n686, n687, n688, n689, n690, n691, n692, n693,
         n694, n695, n696, n697, n698, n699, n700, n701, n702, n703, n704,
         n705, n706, n707, n708, n709, n710, n711, n712;
  wire   [4:0] Xadd1;
  wire   [4:0] Xsub1;
  wire   [4:0] Yadd1;
  wire   [4:0] Ysub1;
  wire   [9:0] center_addr;
  wire   [3:0] ns;
  wire   [7:0] FF2;
  wire   [7:0] FF1;
  wire   [7:0] FF3;
  wire   [7:0] FF4;
  wire   [7:0] ini_label;
  wire   [7:0] FF_rom;
  wire   [4:2] \r419/carry ;
  wire   [4:2] \r417/carry ;

  AOI211X2 U201 ( .A0(n19), .A1(n707), .B0(n26), .C0(n522), .Y(n152) );
  CLE_DW01_inc_0 add_250 ( .A(ini_label), .SUM({N306, N305, N304, N303, N302, 
        N301, N300, N299}) );
  DFFRX1 \ini_label_reg[7]  ( .D(n347), .CK(clk), .RN(n527), .Q(ini_label[7]), 
        .QN(n233) );
  DFFRX1 \ini_label_reg[2]  ( .D(n352), .CK(clk), .RN(n528), .Q(ini_label[2]), 
        .QN(n238) );
  DFFRX1 \ini_label_reg[3]  ( .D(n351), .CK(clk), .RN(n528), .Q(ini_label[3]), 
        .QN(n237) );
  DFFRX1 \ini_label_reg[4]  ( .D(n350), .CK(clk), .RN(n528), .Q(ini_label[4]), 
        .QN(n236) );
  DFFRX1 \ini_label_reg[5]  ( .D(n349), .CK(clk), .RN(n527), .Q(ini_label[5]), 
        .QN(n235) );
  DFFRX1 \ini_label_reg[6]  ( .D(n348), .CK(clk), .RN(n527), .Q(ini_label[6]), 
        .QN(n234) );
  DFFRX1 \ini_label_reg[1]  ( .D(n354), .CK(clk), .RN(n528), .Q(ini_label[1]), 
        .QN(n244) );
  DFFSX1 \ini_label_reg[0]  ( .D(n353), .CK(clk), .SN(n531), .Q(ini_label[0]), 
        .QN(n239) );
  DFFRX1 \FF_rom_reg[7]  ( .D(rom_q[7]), .CK(clk), .RN(n525), .Q(FF_rom[7]) );
  DFFRX1 \FF_rom_reg[6]  ( .D(rom_q[6]), .CK(clk), .RN(n528), .Q(FF_rom[6]) );
  DFFRX1 \FF_rom_reg[1]  ( .D(rom_q[1]), .CK(clk), .RN(n530), .Q(FF_rom[1]) );
  DFFRX1 \FF_rom_reg[0]  ( .D(rom_q[0]), .CK(clk), .RN(n529), .Q(FF_rom[0]) );
  DFFRX1 \FF_rom_reg[5]  ( .D(rom_q[5]), .CK(clk), .RN(n530), .QN(n242) );
  DFFRX1 \FF_rom_reg[4]  ( .D(rom_q[4]), .CK(clk), .RN(n529), .QN(n243) );
  DFFRX1 \FF_rom_reg[3]  ( .D(rom_q[3]), .CK(clk), .RN(n530), .QN(n241) );
  DFFRX1 \FF_rom_reg[2]  ( .D(rom_q[2]), .CK(clk), .RN(n529), .QN(n240) );
  DFFRX1 \counter_X_reg[4]  ( .D(n413), .CK(clk), .RN(n530), .Q(center_addr[9]), .QN(n254) );
  DFFRX1 \counter_Y_reg[4]  ( .D(n405), .CK(clk), .RN(n530), .Q(center_addr[4]), .QN(n250) );
  DFFNSRX1 nochange_reg ( .D(n423), .CKN(clk), .SN(n530), .RN(1'b1), .Q(
        nochange) );
  DFFRX1 \counter_X_reg[3]  ( .D(n409), .CK(clk), .RN(n530), .Q(center_addr[8]), .QN(n253) );
  DFFRX2 \FF5_reg[0]  ( .D(n346), .CK(clk), .RN(n527), .QN(n291) );
  DFFRX2 \FF5_reg[4]  ( .D(n326), .CK(clk), .RN(n527), .QN(n295) );
  DFFRX1 \counter_X_reg[2]  ( .D(n411), .CK(clk), .RN(n530), .Q(center_addr[7]), .QN(n252) );
  DFFRX1 \counter_X_reg[1]  ( .D(n415), .CK(clk), .RN(n529), .Q(center_addr[6]), .QN(n251) );
  DFFRX1 \counter_Y_reg[3]  ( .D(n418), .CK(clk), .RN(n528), .Q(center_addr[3]), .QN(n249) );
  DFFRX2 \cs_reg[0]  ( .D(ns[0]), .CK(clk), .RN(n528), .Q(n428), .QN(n296) );
  DFFRX1 \FF3_reg[7]  ( .D(n388), .CK(clk), .RN(n525), .Q(FF3[7]), .QN(n268)
         );
  DFFRX1 \FF2_reg[7]  ( .D(n387), .CK(clk), .RN(n526), .Q(FF2[7]), .QN(n260)
         );
  DFFRX1 \FF1_reg[7]  ( .D(n380), .CK(clk), .RN(n526), .Q(FF1[7]), .QN(n264)
         );
  DFFRX1 \FF4_reg[7]  ( .D(n335), .CK(clk), .RN(n525), .Q(FF4[7]), .QN(n259)
         );
  DFFRX1 \FF4_reg[0]  ( .D(n343), .CK(clk), .RN(n527), .Q(FF4[0]), .QN(n274)
         );
  DFFRX1 \FF3_reg[0]  ( .D(n402), .CK(clk), .RN(n525), .Q(FF3[0]), .QN(n287)
         );
  DFFRX1 \FF3_reg[3]  ( .D(n396), .CK(clk), .RN(n525), .Q(FF3[3]), .QN(n284)
         );
  DFFRX1 \FF3_reg[5]  ( .D(n392), .CK(clk), .RN(n525), .Q(FF3[5]), .QN(n270)
         );
  DFFRX1 \FF2_reg[6]  ( .D(n389), .CK(clk), .RN(n526), .Q(FF2[6]), .QN(n261)
         );
  DFFRX1 \FF1_reg[3]  ( .D(n384), .CK(clk), .RN(n526), .Q(FF1[3]), .QN(n280)
         );
  DFFRX1 \FF3_reg[6]  ( .D(n390), .CK(clk), .RN(n526), .Q(FF3[6]), .QN(n269)
         );
  DFFRX1 \FF4_reg[4]  ( .D(n323), .CK(clk), .RN(n527), .Q(FF4[4]), .QN(n256)
         );
  DFFRX1 \FF4_reg[3]  ( .D(n319), .CK(clk), .RN(n525), .Q(FF4[3]), .QN(n272)
         );
  DFFRX1 \FF4_reg[6]  ( .D(n331), .CK(clk), .RN(n526), .Q(FF4[6]), .QN(n258)
         );
  DFFSX1 first_scan_reg ( .D(n407), .CK(clk), .SN(n530), .Q(n435), .QN(n245)
         );
  DFFRX1 \counter_Y_reg[2]  ( .D(n403), .CK(clk), .RN(n529), .Q(center_addr[2]), .QN(n248) );
  DFFRX1 \cs_reg[3]  ( .D(ns[3]), .CK(clk), .RN(n529), .QN(n298) );
  DFFRX1 \counter_Y_reg[1]  ( .D(n406), .CK(clk), .RN(n529), .Q(center_addr[1]), .QN(n247) );
  DFFRX1 \counter_Y_reg[0]  ( .D(n416), .CK(clk), .RN(n530), .Q(center_addr[0]), .QN(n246) );
  DFFRX1 \FF3_reg[4]  ( .D(n394), .CK(clk), .RN(n529), .Q(FF3[4]), .QN(n271)
         );
  DFFRX4 \FF2_reg[5]  ( .D(n391), .CK(clk), .RN(n528), .Q(FF2[5]), .QN(n262)
         );
  DFFRX4 \FF2_reg[4]  ( .D(n393), .CK(clk), .RN(n528), .Q(FF2[4]), .QN(n263)
         );
  DFFRX2 \cs_reg[1]  ( .D(ns[1]), .CK(clk), .RN(n530), .Q(n430), .QN(n299) );
  DFFRX1 \FF1_reg[0]  ( .D(n379), .CK(clk), .RN(n529), .Q(FF1[0]), .QN(n279)
         );
  DFFRX1 \FF1_reg[6]  ( .D(n381), .CK(clk), .RN(n526), .Q(FF1[6]), .QN(n265)
         );
  DFFRX1 \FF4_reg[5]  ( .D(n327), .CK(clk), .RN(n525), .Q(FF4[5]), .QN(n257)
         );
  DFFRX4 \FF1_reg[5]  ( .D(n382), .CK(clk), .RN(n528), .QN(n266) );
  DFFRX1 finish_reg ( .D(n318), .CK(clk), .RN(n527), .Q(n713), .QN(n232) );
  DFFNSRX1 \rom_a_reg[1]  ( .D(center_addr[4]), .CKN(clk), .SN(1'b1), .RN(n531), .QN(n457) );
  DFFNSRX1 \rom_a_reg[5]  ( .D(center_addr[8]), .CKN(clk), .SN(1'b1), .RN(n531), .QN(n455) );
  DFFNSRX1 \rom_a_reg[4]  ( .D(center_addr[7]), .CKN(clk), .SN(1'b1), .RN(n526), .QN(n453) );
  DFFNSRX1 \rom_a_reg[6]  ( .D(center_addr[9]), .CKN(clk), .SN(1'b1), .RN(n527), .QN(n451) );
  DFFNSRX1 \rom_a_reg[3]  ( .D(center_addr[6]), .CKN(clk), .SN(1'b1), .RN(n525), .QN(n449) );
  DFFNSRX1 \rom_a_reg[0]  ( .D(center_addr[3]), .CKN(clk), .SN(1'b1), .RN(n528), .QN(n447) );
  DFFNSRX1 \rom_a_reg[2]  ( .D(center_addr[5]), .CKN(clk), .SN(1'b1), .RN(n530), .QN(n445) );
  DFFNSRX1 sram_wen_reg ( .D(n522), .CKN(clk), .SN(n530), .RN(1'b1), .QN(n443)
         );
  DFFRX2 \FF4_reg[1]  ( .D(n355), .CK(clk), .RN(n525), .Q(FF4[1]), .QN(n283)
         );
  DFFRX2 \FF2_reg[3]  ( .D(n395), .CK(clk), .RN(n526), .Q(FF2[3]), .QN(n275)
         );
  DFFRX1 \FF5_reg[3]  ( .D(n322), .CK(clk), .RN(n527), .Q(n441), .QN(n288) );
  DFFRX1 \FF5_reg[1]  ( .D(n358), .CK(clk), .RN(n528), .Q(n440), .QN(n290) );
  DFFRX1 \FF5_reg[5]  ( .D(n330), .CK(clk), .RN(n527), .Q(n439), .QN(n294) );
  DFFRX1 \FF5_reg[6]  ( .D(n334), .CK(clk), .RN(n527), .Q(n438), .QN(n293) );
  DFFRX1 \FF5_reg[2]  ( .D(n342), .CK(clk), .RN(n526), .Q(n437), .QN(n289) );
  DFFRX1 \FF5_reg[7]  ( .D(n338), .CK(clk), .RN(n527), .Q(n436), .QN(n292) );
  DFFRX2 \FF2_reg[2]  ( .D(n397), .CK(clk), .RN(n526), .Q(FF2[2]), .QN(n276)
         );
  DFFRX2 \FF3_reg[1]  ( .D(n400), .CK(clk), .RN(n525), .Q(n433), .QN(n286) );
  DFFRX2 \cs_reg[2]  ( .D(ns[2]), .CK(clk), .RN(n526), .Q(n432), .QN(n297) );
  DFFRX2 \FF1_reg[1]  ( .D(n386), .CK(clk), .RN(n528), .Q(FF1[1]), .QN(n282)
         );
  DFFRX1 \FF3_reg[2]  ( .D(n398), .CK(clk), .RN(n525), .Q(FF3[2]), .QN(n285)
         );
  DFFRX1 \counter_X_reg[0]  ( .D(n420), .CK(clk), .RN(n530), .Q(center_addr[5]), .QN(n255) );
  DFFRX1 \FF4_reg[2]  ( .D(n339), .CK(clk), .RN(n525), .Q(FF4[2]), .QN(n273)
         );
  DFFRX1 \FF2_reg[0]  ( .D(n401), .CK(clk), .RN(n529), .Q(FF2[0]), .QN(n278)
         );
  DFFRX2 \FF2_reg[1]  ( .D(n399), .CK(clk), .RN(n529), .Q(FF2[1]), .QN(n277)
         );
  DFFRHQX2 \FF1_reg[4]  ( .D(n383), .CK(clk), .RN(n529), .Q(n484) );
  DFFNSRX1 \sram_a_reg[1]  ( .D(n362), .CKN(clk), .SN(1'b1), .RN(n531), .QN(
        n308) );
  DFFNSRX1 \sram_a_reg[2]  ( .D(n364), .CKN(clk), .SN(1'b1), .RN(n531), .QN(
        n307) );
  DFFNSRX1 \sram_a_reg[3]  ( .D(n366), .CKN(clk), .SN(1'b1), .RN(n526), .QN(
        n306) );
  DFFNSRX1 \sram_a_reg[4]  ( .D(n368), .CKN(clk), .SN(1'b1), .RN(n531), .QN(
        n305) );
  DFFNSRX1 \sram_a_reg[5]  ( .D(n370), .CKN(clk), .SN(1'b1), .RN(n531), .QN(
        n304) );
  DFFNSRX1 \sram_a_reg[0]  ( .D(n360), .CKN(clk), .SN(1'b1), .RN(n531), .QN(
        n309) );
  DFFNSRX1 \sram_a_reg[6]  ( .D(n372), .CKN(clk), .SN(1'b1), .RN(n531), .QN(
        n303) );
  DFFNSRX1 \sram_a_reg[7]  ( .D(n374), .CKN(clk), .SN(1'b1), .RN(n531), .QN(
        n302) );
  DFFNSRX1 \sram_d_reg[3]  ( .D(n321), .CKN(clk), .SN(1'b1), .RN(n527), .QN(
        n317) );
  DFFNSRX1 \sram_d_reg[4]  ( .D(n325), .CKN(clk), .SN(1'b1), .RN(n531), .QN(
        n316) );
  DFFNSRX1 \sram_d_reg[5]  ( .D(n329), .CKN(clk), .SN(1'b1), .RN(n525), .QN(
        n315) );
  DFFNSRX1 \sram_d_reg[6]  ( .D(n333), .CKN(clk), .SN(1'b1), .RN(n531), .QN(
        n314) );
  DFFNSRX1 \sram_d_reg[7]  ( .D(n337), .CKN(clk), .SN(1'b1), .RN(n531), .QN(
        n313) );
  DFFNSRX1 \sram_d_reg[2]  ( .D(n341), .CKN(clk), .SN(1'b1), .RN(n531), .QN(
        n312) );
  DFFNSRX1 \sram_d_reg[0]  ( .D(n345), .CKN(clk), .SN(1'b1), .RN(n531), .QN(
        n311) );
  DFFNSRX1 \sram_d_reg[1]  ( .D(n357), .CKN(clk), .SN(1'b1), .RN(n658), .QN(
        n310) );
  DFFNSRX1 \sram_a_reg[8]  ( .D(n376), .CKN(clk), .SN(1'b1), .RN(n531), .QN(
        n301) );
  DFFNSRX1 \sram_a_reg[9]  ( .D(n378), .CKN(clk), .SN(1'b1), .RN(n531), .QN(
        n300) );
  DFFRX2 \FF1_reg[2]  ( .D(n385), .CK(clk), .RN(n526), .Q(FF1[2]), .QN(n281)
         );
  AOI2BB1X1 U355 ( .A0N(n653), .A1N(n575), .B0(n514), .Y(n576) );
  NAND2X2 U356 ( .A(n568), .B(n611), .Y(n570) );
  CLKMX2X8 U357 ( .A(n558), .B(FF2[2]), .S0(n427), .Y(n611) );
  BUFX4 U358 ( .A(n642), .Y(n442) );
  AO22XL U359 ( .A0(n521), .A1(n558), .B0(n637), .B1(FF2[2]), .Y(n385) );
  AO21X2 U360 ( .A0(n544), .A1(n258), .B0(FF3[6]), .Y(n545) );
  INVX12 U361 ( .A(n616), .Y(n568) );
  CLKMX2X8 U362 ( .A(n557), .B(FF4[2]), .S0(n504), .Y(n616) );
  INVX3 U363 ( .A(n640), .Y(n565) );
  CLKMX2X8 U364 ( .A(n433), .B(n562), .S0(n504), .Y(n640) );
  AND2X6 U365 ( .A(n565), .B(n641), .Y(n566) );
  OAI32X2 U366 ( .A0(n514), .A1(n497), .A2(n647), .B0(n646), .B1(n493), .Y(
        n556) );
  AND2X8 U367 ( .A(n493), .B(n646), .Y(n514) );
  CLKINVX1 U368 ( .A(FF2[6]), .Y(n655) );
  CLKINVX1 U369 ( .A(n654), .Y(n571) );
  OR2X1 U370 ( .A(FF4[7]), .B(n268), .Y(n492) );
  AOI21X2 U371 ( .A0(FF2[1]), .A1(n282), .B0(FF2[0]), .Y(n678) );
  NOR2BX1 U372 ( .AN(FF2[4]), .B(n484), .Y(n682) );
  INVX3 U373 ( .A(n490), .Y(n675) );
  AND2X2 U374 ( .A(n263), .B(n484), .Y(n490) );
  CLKINVX1 U375 ( .A(FF3[5]), .Y(n543) );
  INVX3 U376 ( .A(FF3[3]), .Y(n539) );
  NAND2X1 U377 ( .A(FF3[2]), .B(n273), .Y(n540) );
  AND2X4 U378 ( .A(FF4[5]), .B(n543), .Y(n517) );
  NOR2X1 U379 ( .A(FF1[6]), .B(n676), .Y(n508) );
  CLKMX2X2 U380 ( .A(n266), .B(n262), .S0(n427), .Y(n493) );
  NAND2X2 U381 ( .A(n282), .B(n494), .Y(n481) );
  CLKMX2X2 U382 ( .A(n280), .B(n275), .S0(n427), .Y(n486) );
  CLKBUFX3 U383 ( .A(n645), .Y(n478) );
  CLKINVX1 U384 ( .A(n493), .Y(n652) );
  CLKMX2X2 U385 ( .A(n554), .B(n553), .S0(n504), .Y(n646) );
  INVX3 U386 ( .A(n486), .Y(n649) );
  CLKMX2X2 U387 ( .A(FF1[0]), .B(FF2[0]), .S0(n427), .Y(n643) );
  CLKMX2X2 U388 ( .A(n606), .B(n605), .S0(n651), .Y(n629) );
  NOR4BBX2 U389 ( .AN(n39), .BN(n174), .C(n19), .D(n522), .Y(n161) );
  OR2X6 U390 ( .A(n685), .B(n684), .Y(n503) );
  CLKINVX12 U391 ( .A(n429), .Y(n426) );
  INVX20 U392 ( .A(n426), .Y(n427) );
  INVX3 U393 ( .A(n427), .Y(n494) );
  NAND2X1 U394 ( .A(n277), .B(n427), .Y(n482) );
  NAND2X1 U395 ( .A(n487), .B(n427), .Y(n496) );
  AOI21X4 U396 ( .A0(FF1[7]), .A1(n260), .B0(n537), .Y(n429) );
  AOI21X1 U397 ( .A0(n540), .A1(n539), .B0(FF4[3]), .Y(n431) );
  INVX3 U398 ( .A(n497), .Y(n653) );
  NAND2X1 U399 ( .A(n495), .B(n496), .Y(n497) );
  INVX3 U400 ( .A(n483), .Y(n641) );
  NAND2X2 U401 ( .A(n481), .B(n482), .Y(n483) );
  AND4X1 U402 ( .A(n536), .B(n535), .C(n534), .D(n533), .Y(n434) );
  NAND2X4 U403 ( .A(n500), .B(n501), .Y(n544) );
  INVX3 U404 ( .A(n643), .Y(n564) );
  AO22X2 U405 ( .A0(FF4[2]), .A1(n285), .B0(FF4[3]), .B1(n539), .Y(n541) );
  INVX12 U406 ( .A(n443), .Y(sram_wen) );
  INVX12 U407 ( .A(n445), .Y(rom_a[2]) );
  INVX12 U408 ( .A(n447), .Y(rom_a[0]) );
  INVX12 U409 ( .A(n449), .Y(rom_a[3]) );
  INVX12 U410 ( .A(n451), .Y(rom_a[6]) );
  INVX12 U411 ( .A(n453), .Y(rom_a[4]) );
  INVX12 U412 ( .A(n455), .Y(rom_a[5]) );
  INVX12 U413 ( .A(n457), .Y(rom_a[1]) );
  INVX12 U414 ( .A(n300), .Y(sram_a[9]) );
  INVX12 U415 ( .A(n301), .Y(sram_a[8]) );
  INVX12 U416 ( .A(n310), .Y(sram_d[1]) );
  INVX12 U417 ( .A(n311), .Y(sram_d[0]) );
  INVX12 U418 ( .A(n312), .Y(sram_d[2]) );
  INVX12 U419 ( .A(n313), .Y(sram_d[7]) );
  INVX12 U420 ( .A(n314), .Y(sram_d[6]) );
  INVX12 U421 ( .A(n315), .Y(sram_d[5]) );
  INVX12 U422 ( .A(n316), .Y(sram_d[4]) );
  INVX12 U423 ( .A(n317), .Y(sram_d[3]) );
  INVX12 U424 ( .A(n302), .Y(sram_a[7]) );
  INVX12 U425 ( .A(n303), .Y(sram_a[6]) );
  INVX12 U426 ( .A(n309), .Y(sram_a[0]) );
  INVX12 U427 ( .A(n304), .Y(sram_a[5]) );
  INVX12 U428 ( .A(n305), .Y(sram_a[4]) );
  INVX12 U429 ( .A(n306), .Y(sram_a[3]) );
  INVX12 U430 ( .A(n307), .Y(sram_a[2]) );
  INVX12 U431 ( .A(n308), .Y(sram_a[1]) );
  BUFX12 U432 ( .A(n713), .Y(finish) );
  NOR2X1 U433 ( .A(n540), .B(n539), .Y(n499) );
  OAI2BB1X4 U434 ( .A0N(FF4[1]), .A1N(n286), .B0(FF3[0]), .Y(n538) );
  MX2XL U435 ( .A(FF3[6]), .B(FF4[6]), .S0(n504), .Y(n645) );
  NOR2X4 U436 ( .A(n681), .B(n680), .Y(n479) );
  NOR2X2 U437 ( .A(n679), .B(n688), .Y(n480) );
  OR2X8 U438 ( .A(n479), .B(n480), .Y(n684) );
  NAND2BX2 U439 ( .AN(FF2[2]), .B(FF1[2]), .Y(n679) );
  XOR2XL U440 ( .A(n641), .B(n290), .Y(n614) );
  INVX1 U441 ( .A(n484), .Y(n485) );
  INVX1 U442 ( .A(FF2[4]), .Y(n487) );
  OR2XL U443 ( .A(n682), .B(n266), .Y(n488) );
  OR2XL U444 ( .A(FF2[5]), .B(n682), .Y(n489) );
  NAND2X1 U445 ( .A(n488), .B(n489), .Y(n683) );
  OR3X2 U446 ( .A(n511), .B(n512), .C(n513), .Y(n676) );
  OR2X6 U447 ( .A(n551), .B(n550), .Y(n491) );
  AND2X8 U448 ( .A(n491), .B(n492), .Y(n504) );
  MX2X1 U449 ( .A(FF3[7]), .B(FF4[7]), .S0(n504), .Y(n644) );
  OR3X6 U450 ( .A(n498), .B(n499), .C(n431), .Y(n548) );
  NAND2X2 U451 ( .A(n560), .B(n649), .Y(n574) );
  INVX1 U452 ( .A(n570), .Y(n560) );
  OAI22X1 U453 ( .A0(FF2[3]), .A1(n688), .B0(FF2[3]), .B1(n679), .Y(n685) );
  NAND2X4 U454 ( .A(n485), .B(n494), .Y(n495) );
  XNOR2XL U455 ( .A(n295), .B(n653), .Y(n214) );
  OAI222X2 U456 ( .A0(n569), .A1(n649), .B0(n611), .B1(n568), .C0(n567), .C1(
        n566), .Y(n573) );
  NOR2X2 U457 ( .A(n541), .B(n542), .Y(n498) );
  OR2X6 U458 ( .A(n689), .B(n517), .Y(n501) );
  AOI22X4 U459 ( .A0(n678), .A1(FF1[0]), .B0(n277), .B1(FF1[1]), .Y(n680) );
  AOI211X2 U460 ( .A0(n640), .A1(n483), .B0(n442), .C0(n564), .Y(n567) );
  OR2XL U461 ( .A(FF1[6]), .B(n655), .Y(n502) );
  OA22X1 U462 ( .A0(FF4[0]), .A1(n538), .B0(FF4[1]), .B1(n286), .Y(n542) );
  NAND3X4 U463 ( .A(n502), .B(n503), .C(n683), .Y(n686) );
  CLKMX2X2 U464 ( .A(n505), .B(n603), .S0(n621), .Y(n605) );
  OR2X2 U465 ( .A(FF4[5]), .B(n543), .Y(n500) );
  NAND2BX2 U466 ( .AN(FF4[4]), .B(FF3[4]), .Y(n689) );
  NOR2X1 U467 ( .A(n655), .B(n676), .Y(n509) );
  NAND4XL U468 ( .A(n260), .B(n261), .C(n262), .D(n487), .Y(n92) );
  AOI22X2 U469 ( .A0(n687), .A1(n686), .B0(n264), .B1(FF2[7]), .Y(n537) );
  XNOR2X1 U470 ( .A(n292), .B(n656), .Y(n217) );
  AOI32X2 U471 ( .A0(n549), .A1(n548), .A2(n547), .B0(n546), .B1(n545), .Y(
        n551) );
  NOR2X1 U472 ( .A(FF1[6]), .B(n655), .Y(n510) );
  NOR2X1 U473 ( .A(FF2[5]), .B(n266), .Y(n511) );
  NOR2X2 U474 ( .A(n266), .B(n675), .Y(n513) );
  MX2X1 U475 ( .A(n563), .B(FF4[0]), .S0(n504), .Y(n642) );
  OR4X1 U476 ( .A(n214), .B(n215), .C(n216), .D(n217), .Y(n505) );
  NOR2BX4 U477 ( .AN(FF2[2]), .B(FF1[2]), .Y(n677) );
  CLKINVX1 U478 ( .A(n656), .Y(n552) );
  NAND2XL U479 ( .A(n518), .B(n299), .Y(n33) );
  OR2X1 U480 ( .A(n631), .B(n630), .Y(n506) );
  OR2X6 U481 ( .A(n629), .B(n628), .Y(n507) );
  NAND3X4 U482 ( .A(n506), .B(n507), .C(n627), .Y(n634) );
  XOR2X1 U483 ( .A(n644), .B(n292), .Y(n599) );
  NAND2X1 U484 ( .A(n296), .B(n523), .Y(n111) );
  XNOR2XL U485 ( .A(n294), .B(n652), .Y(n215) );
  NOR2BX1 U486 ( .AN(n262), .B(n675), .Y(n512) );
  INVX6 U487 ( .A(n595), .Y(n621) );
  AOI32X2 U488 ( .A0(n574), .A1(n572), .A2(n573), .B0(n478), .B1(n571), .Y(
        n577) );
  INVX1 U489 ( .A(n644), .Y(n580) );
  NAND2BX2 U490 ( .AN(n556), .B(n478), .Y(n579) );
  INVX3 U491 ( .A(n478), .Y(n555) );
  INVX1 U492 ( .A(n523), .Y(n691) );
  NAND2XL U493 ( .A(n133), .B(n520), .Y(n425) );
  OAI22XL U494 ( .A0(n594), .A1(n593), .B0(n592), .B1(n591), .Y(n604) );
  AND2X2 U495 ( .A(n626), .B(n428), .Y(n627) );
  NAND2XL U496 ( .A(n518), .B(n650), .Y(n632) );
  NAND2XL U497 ( .A(n650), .B(n432), .Y(n22) );
  AOI22XL U498 ( .A0(n666), .A1(n30), .B0(n650), .B1(n428), .Y(n34) );
  CLKMX2X2 U499 ( .A(n625), .B(n624), .S0(n651), .Y(n628) );
  CLKINVX3 U500 ( .A(FF1[3]), .Y(n688) );
  MXI2X2 U501 ( .A(n271), .B(n256), .S0(n504), .Y(n647) );
  AOI2BB1XL U502 ( .A0N(FF3[6]), .A1N(n258), .B0(n517), .Y(n547) );
  NOR2XL U503 ( .A(n298), .B(n299), .Y(n519) );
  XOR2XL U504 ( .A(n478), .B(n293), .Y(n600) );
  XOR2XL U505 ( .A(n648), .B(n288), .Y(n617) );
  XOR2XL U506 ( .A(n649), .B(n288), .Y(n612) );
  XNOR2XL U507 ( .A(n293), .B(n654), .Y(n216) );
  XOR2XL U508 ( .A(n647), .B(n295), .Y(n602) );
  XOR2XL U509 ( .A(n646), .B(n294), .Y(n601) );
  XOR2XL U510 ( .A(n442), .B(n291), .Y(n620) );
  XOR2XL U511 ( .A(n616), .B(n289), .Y(n618) );
  XOR2XL U512 ( .A(n640), .B(n290), .Y(n619) );
  NOR2BX1 U513 ( .AN(n131), .B(n296), .Y(n120) );
  NAND4XL U514 ( .A(n258), .B(n257), .C(n256), .D(n272), .Y(n584) );
  ADDHXL U515 ( .A(center_addr[1]), .B(center_addr[0]), .CO(\r419/carry [2]), 
        .S(Yadd1[1]) );
  ADDHXL U516 ( .A(center_addr[2]), .B(\r419/carry [2]), .CO(\r419/carry [3]), 
        .S(Yadd1[2]) );
  ADDHXL U517 ( .A(center_addr[3]), .B(\r419/carry [3]), .CO(\r419/carry [4]), 
        .S(Yadd1[3]) );
  OAI21X1 U518 ( .A0(n430), .A1(n428), .B0(n297), .Y(n122) );
  NAND4BBX1 U519 ( .AN(n249), .BN(n250), .C(n101), .D(n710), .Y(n45) );
  NOR2X2 U520 ( .A(n430), .B(n298), .Y(n17) );
  OAI211XL U521 ( .A0(n45), .A1(n38), .B0(n46), .C0(n432), .Y(n44) );
  NAND4XL U522 ( .A(n256), .B(n257), .C(n258), .D(n259), .Y(n93) );
  CLKINVX1 U523 ( .A(reset), .Y(n658) );
  AO21X4 U524 ( .A0(nochange), .A1(n634), .B0(n633), .Y(n423) );
  OR3X2 U525 ( .A(n508), .B(n509), .C(n510), .Y(n687) );
  CLKINVX1 U526 ( .A(n139), .Y(n532) );
  AO21X1 U527 ( .A0(n570), .A1(n486), .B0(n648), .Y(n572) );
  NAND2X1 U528 ( .A(n552), .B(n644), .Y(n582) );
  INVX3 U529 ( .A(n522), .Y(n692) );
  CLKINVX1 U530 ( .A(n604), .Y(n651) );
  NAND2X1 U531 ( .A(n161), .B(n695), .Y(n160) );
  NAND2BX1 U532 ( .AN(n148), .B(n707), .Y(n149) );
  INVX3 U533 ( .A(n49), .Y(n637) );
  CLKINVX1 U534 ( .A(n639), .Y(n657) );
  NAND2X1 U535 ( .A(n657), .B(n693), .Y(n139) );
  CLKINVX1 U536 ( .A(n36), .Y(n666) );
  CLKBUFX3 U537 ( .A(n658), .Y(n530) );
  CLKBUFX3 U538 ( .A(n658), .Y(n531) );
  CLKBUFX3 U539 ( .A(n658), .Y(n527) );
  CLKBUFX3 U540 ( .A(n658), .Y(n526) );
  CLKBUFX3 U541 ( .A(n531), .Y(n529) );
  CLKBUFX3 U542 ( .A(n658), .Y(n528) );
  CLKBUFX3 U543 ( .A(n658), .Y(n525) );
  CLKINVX1 U544 ( .A(n648), .Y(n569) );
  CLKMX2X2 U545 ( .A(FF1[7]), .B(FF2[7]), .S0(n427), .Y(n656) );
  CLKMX2X2 U546 ( .A(FF1[6]), .B(n636), .S0(n427), .Y(n654) );
  CLKMX2X2 U547 ( .A(n561), .B(FF4[3]), .S0(n504), .Y(n648) );
  CLKINVX1 U548 ( .A(n647), .Y(n575) );
  OR4X1 U549 ( .A(n586), .B(n585), .C(n584), .D(n583), .Y(n592) );
  OR4X1 U550 ( .A(n590), .B(n589), .C(n588), .D(n587), .Y(n591) );
  NAND4X1 U551 ( .A(n659), .B(n665), .C(n598), .D(n664), .Y(n594) );
  NAND2X1 U552 ( .A(n523), .B(n428), .Y(n109) );
  NOR2X1 U553 ( .A(n650), .B(n519), .Y(n133) );
  NAND4X1 U554 ( .A(n663), .B(n662), .C(n661), .D(n660), .Y(n593) );
  CLKINVX1 U555 ( .A(n46), .Y(n650) );
  CLKBUFX3 U556 ( .A(n425), .Y(n522) );
  OAI21X1 U557 ( .A0(n299), .A1(n428), .B0(n46), .Y(n119) );
  CLKINVX1 U558 ( .A(n40), .Y(n626) );
  AND2X2 U559 ( .A(n595), .B(n596), .Y(n515) );
  AND2X2 U560 ( .A(n621), .B(n596), .Y(n516) );
  NAND2X1 U561 ( .A(n17), .B(n18), .Y(n174) );
  NAND2X1 U562 ( .A(n152), .B(n17), .Y(n148) );
  NAND2X1 U563 ( .A(n161), .B(n17), .Y(n158) );
  NOR3X1 U564 ( .A(n38), .B(n45), .C(n145), .Y(n26) );
  NOR2X1 U565 ( .A(n694), .B(n30), .Y(n19) );
  CLKINVX1 U566 ( .A(n18), .Y(n707) );
  NAND2BX1 U567 ( .AN(n22), .B(n428), .Y(n82) );
  NOR2X1 U568 ( .A(center_addr[1]), .B(center_addr[2]), .Y(n102) );
  CLKINVX1 U569 ( .A(n17), .Y(n694) );
  NAND2X1 U570 ( .A(n694), .B(n38), .Y(n20) );
  AND3X2 U571 ( .A(n695), .B(n45), .C(n152), .Y(n151) );
  CLKBUFX3 U572 ( .A(n434), .Y(n524) );
  AO22X1 U573 ( .A0(n521), .A1(FF1[7]), .B0(n637), .B1(FF2[7]), .Y(n380) );
  AO22X1 U574 ( .A0(n521), .A1(FF1[6]), .B0(n637), .B1(n636), .Y(n381) );
  AO22X1 U575 ( .A0(n521), .A1(n559), .B0(n637), .B1(FF2[3]), .Y(n384) );
  CLKBUFX3 U576 ( .A(n638), .Y(n521) );
  CLKINVX1 U577 ( .A(n48), .Y(n638) );
  NAND2X2 U578 ( .A(n667), .B(n432), .Y(n136) );
  NAND2X2 U579 ( .A(n22), .B(n40), .Y(n53) );
  OAI211X1 U580 ( .A0(n690), .A1(n428), .B0(n33), .C0(n34), .Y(ns[1]) );
  CLKINVX1 U581 ( .A(n37), .Y(n690) );
  OAI211X1 U582 ( .A0(n38), .A1(n432), .B0(n39), .C0(n40), .Y(n37) );
  OAI21XL U583 ( .A0(n697), .A1(n45), .B0(n695), .Y(n39) );
  CLKINVX1 U584 ( .A(n145), .Y(n697) );
  NAND3X1 U585 ( .A(n520), .B(n17), .C(n707), .Y(n36) );
  CLKINVX1 U586 ( .A(n38), .Y(n695) );
  NAND2X2 U587 ( .A(n107), .B(n53), .Y(n51) );
  OAI21XL U588 ( .A0(n651), .A1(n84), .B0(n428), .Y(n107) );
  CLKINVX1 U589 ( .A(n144), .Y(n693) );
  OAI221XL U590 ( .A0(n30), .A1(n38), .B0(n694), .B1(n145), .C0(n146), .Y(n144) );
  AOI2BB2X1 U591 ( .B0(n707), .B1(n17), .A0N(n45), .A1N(n38), .Y(n146) );
  NAND3X1 U592 ( .A(n432), .B(n428), .C(n17), .Y(n23) );
  AND2X2 U593 ( .A(FF4[7]), .B(n268), .Y(n550) );
  NAND4X1 U594 ( .A(n615), .B(n614), .C(n613), .D(n612), .Y(n623) );
  XOR2X1 U595 ( .A(n643), .B(n291), .Y(n615) );
  XOR2X1 U596 ( .A(n611), .B(n289), .Y(n613) );
  NAND2BX1 U597 ( .AN(n544), .B(FF4[6]), .Y(n546) );
  NAND4X1 U598 ( .A(n610), .B(n609), .C(n608), .D(n607), .Y(n625) );
  CLKMX2X2 U599 ( .A(n623), .B(n622), .S0(n621), .Y(n624) );
  XOR2X1 U600 ( .A(sram_q[1]), .B(n290), .Y(n610) );
  OR4X1 U601 ( .A(n205), .B(n204), .C(n207), .D(n206), .Y(n606) );
  XOR2X1 U602 ( .A(n661), .B(n294), .Y(n205) );
  CLKINVX1 U603 ( .A(n632), .Y(n633) );
  NAND4X1 U604 ( .A(n293), .B(n294), .C(n295), .D(n288), .Y(n631) );
  OAI222XL U605 ( .A0(n248), .A1(n109), .B0(n114), .B1(n111), .C0(n523), .C1(
        n307), .Y(n364) );
  AOI22X1 U606 ( .A0(n430), .A1(Yadd1[2]), .B0(Ysub1[2]), .B1(n299), .Y(n114)
         );
  NAND4X1 U607 ( .A(n602), .B(n601), .C(n600), .D(n599), .Y(n603) );
  NAND4X1 U608 ( .A(n620), .B(n619), .C(n618), .D(n617), .Y(n622) );
  OR2X1 U609 ( .A(n256), .B(FF3[4]), .Y(n549) );
  CLKINVX1 U610 ( .A(n270), .Y(n554) );
  CLKINVX1 U611 ( .A(n287), .Y(n563) );
  CLKINVX1 U612 ( .A(n285), .Y(n557) );
  CLKINVX1 U613 ( .A(n257), .Y(n553) );
  CLKINVX1 U614 ( .A(n280), .Y(n559) );
  CLKINVX1 U615 ( .A(n281), .Y(n558) );
  CLKINVX1 U616 ( .A(n283), .Y(n562) );
  OAI222XL U617 ( .A0(n246), .A1(n109), .B0(n110), .B1(n111), .C0(n523), .C1(
        n309), .Y(n360) );
  AOI22X1 U618 ( .A0(n430), .A1(Yadd1[0]), .B0(n246), .B1(n299), .Y(n110) );
  OAI222XL U619 ( .A0(n247), .A1(n109), .B0(n113), .B1(n111), .C0(n523), .C1(
        n308), .Y(n362) );
  AOI22X1 U620 ( .A0(n430), .A1(Yadd1[1]), .B0(Ysub1[1]), .B1(n299), .Y(n113)
         );
  OAI222XL U621 ( .A0(n249), .A1(n109), .B0(n115), .B1(n111), .C0(n523), .C1(
        n306), .Y(n366) );
  AOI22X1 U622 ( .A0(n430), .A1(Yadd1[3]), .B0(Ysub1[3]), .B1(n299), .Y(n115)
         );
  OAI222XL U623 ( .A0(n250), .A1(n109), .B0(n116), .B1(n111), .C0(n523), .C1(
        n305), .Y(n368) );
  AOI22X1 U624 ( .A0(n430), .A1(Yadd1[4]), .B0(Ysub1[4]), .B1(n299), .Y(n116)
         );
  NAND2X1 U625 ( .A(n299), .B(n298), .Y(n46) );
  XOR2X1 U626 ( .A(sram_q[2]), .B(n289), .Y(n607) );
  XOR2X1 U627 ( .A(sram_q[3]), .B(n288), .Y(n608) );
  XOR2X1 U628 ( .A(sram_q[0]), .B(n291), .Y(n609) );
  NAND2X2 U629 ( .A(n298), .B(n430), .Y(n38) );
  CLKINVX1 U630 ( .A(sram_q[4]), .Y(n662) );
  XOR2X1 U631 ( .A(n662), .B(n295), .Y(n204) );
  XOR2X1 U632 ( .A(n659), .B(n292), .Y(n207) );
  XOR2X1 U633 ( .A(n660), .B(n293), .Y(n206) );
  OAI22XL U634 ( .A0(n523), .A1(n302), .B0(n691), .B1(n125), .Y(n374) );
  AOI222XL U635 ( .A0(Xsub1[2]), .A1(n119), .B0(n120), .B1(center_addr[7]), 
        .C0(Xadd1[2]), .C1(n122), .Y(n125) );
  OAI22XL U636 ( .A0(n523), .A1(n300), .B0(n691), .B1(n129), .Y(n378) );
  AOI222XL U637 ( .A0(Xsub1[4]), .A1(n119), .B0(n120), .B1(center_addr[9]), 
        .C0(Xadd1[4]), .C1(n122), .Y(n129) );
  OAI22XL U638 ( .A0(n523), .A1(n301), .B0(n691), .B1(n127), .Y(n376) );
  AOI222XL U639 ( .A0(Xsub1[3]), .A1(n119), .B0(n120), .B1(center_addr[8]), 
        .C0(Xadd1[3]), .C1(n122), .Y(n127) );
  OAI22XL U640 ( .A0(n692), .A1(n316), .B0(n295), .B1(n522), .Y(n325) );
  OAI22XL U641 ( .A0(n692), .A1(n313), .B0(n292), .B1(n522), .Y(n337) );
  OAI22XL U642 ( .A0(n692), .A1(n315), .B0(n294), .B1(n522), .Y(n329) );
  OAI22XL U643 ( .A0(n692), .A1(n314), .B0(n293), .B1(n522), .Y(n333) );
  OAI22XL U644 ( .A0(n692), .A1(n311), .B0(n291), .B1(n522), .Y(n345) );
  OAI22XL U645 ( .A0(n692), .A1(n317), .B0(n288), .B1(n522), .Y(n321) );
  OAI22XL U646 ( .A0(n692), .A1(n312), .B0(n289), .B1(n522), .Y(n341) );
  OAI22XL U647 ( .A0(n523), .A1(n304), .B0(n691), .B1(n118), .Y(n370) );
  AOI222XL U648 ( .A0(n255), .A1(n119), .B0(n120), .B1(n698), .C0(n255), .C1(
        n122), .Y(n118) );
  OAI22XL U649 ( .A0(n523), .A1(n303), .B0(n691), .B1(n123), .Y(n372) );
  AOI222XL U650 ( .A0(Xsub1[1]), .A1(n119), .B0(n120), .B1(center_addr[6]), 
        .C0(Xadd1[1]), .C1(n122), .Y(n123) );
  OAI22XL U651 ( .A0(n692), .A1(n310), .B0(n290), .B1(n522), .Y(n357) );
  CLKINVX1 U652 ( .A(sram_q[6]), .Y(n660) );
  CLKINVX1 U653 ( .A(sram_q[5]), .Y(n661) );
  CLKINVX1 U654 ( .A(sram_q[7]), .Y(n659) );
  NAND4X1 U655 ( .A(n283), .B(n274), .C(n259), .D(n273), .Y(n583) );
  NAND4X1 U656 ( .A(n271), .B(n487), .C(n262), .D(n270), .Y(n587) );
  NAND4X1 U657 ( .A(n261), .B(n269), .C(n260), .D(n268), .Y(n588) );
  NAND4X1 U658 ( .A(n282), .B(n281), .C(n485), .D(n280), .Y(n585) );
  NAND4X1 U659 ( .A(n287), .B(n278), .C(n286), .D(n277), .Y(n589) );
  NAND4X1 U660 ( .A(n285), .B(n276), .C(n284), .D(n275), .Y(n590) );
  NAND4X1 U661 ( .A(n266), .B(n265), .C(n264), .D(n279), .Y(n586) );
  AND2X2 U662 ( .A(n297), .B(n428), .Y(n518) );
  CLKINVX1 U663 ( .A(sram_q[2]), .Y(n598) );
  CLKINVX1 U664 ( .A(sram_q[1]), .Y(n664) );
  CLKINVX1 U665 ( .A(sram_q[3]), .Y(n663) );
  CLKINVX1 U666 ( .A(sram_q[0]), .Y(n665) );
  CLKBUFX3 U667 ( .A(n112), .Y(n523) );
  OAI221XL U668 ( .A0(n432), .A1(n696), .B0(n296), .B1(n38), .C0(n33), .Y(n112) );
  CLKINVX1 U669 ( .A(n133), .Y(n696) );
  CLKINVX1 U670 ( .A(n261), .Y(n636) );
  CLKINVX1 U671 ( .A(n284), .Y(n561) );
  ADDHXL U672 ( .A(center_addr[6]), .B(center_addr[5]), .CO(\r417/carry [2]), 
        .S(Xadd1[1]) );
  ADDHXL U673 ( .A(center_addr[7]), .B(\r417/carry [2]), .CO(\r417/carry [3]), 
        .S(Xadd1[2]) );
  CLKINVX1 U674 ( .A(center_addr[2]), .Y(n674) );
  ADDHXL U675 ( .A(center_addr[8]), .B(\r417/carry [3]), .CO(\r417/carry [4]), 
        .S(Xadd1[3]) );
  NAND2X1 U676 ( .A(n519), .B(n297), .Y(n40) );
  OAI21XL U677 ( .A0(n299), .A1(n432), .B0(n298), .Y(n131) );
  AND2X2 U678 ( .A(n296), .B(n432), .Y(n520) );
  OAI22XL U679 ( .A0(n298), .A1(n432), .B0(n297), .B1(n16), .Y(ns[3]) );
  AOI222XL U680 ( .A0(n17), .A1(n18), .B0(n19), .B1(nochange), .C0(n20), .C1(
        n428), .Y(n16) );
  NAND4X1 U681 ( .A(n291), .B(n290), .C(n289), .D(n292), .Y(n630) );
  NAND4BX1 U682 ( .AN(n635), .B(n22), .C(n23), .D(n25), .Y(ns[2]) );
  AOI22X1 U683 ( .A0(n26), .A1(n520), .B0(n430), .B1(n518), .Y(n25) );
  AOI2BB1X1 U684 ( .A0N(n30), .A1N(nochange), .B0(n36), .Y(n635) );
  CLKINVX1 U685 ( .A(n255), .Y(n698) );
  OAI221XL U686 ( .A0(n289), .A1(n53), .B0(n51), .B1(n598), .C0(n597), .Y(n342) );
  AOI222XL U687 ( .A0(ini_label[2]), .A1(n524), .B0(n515), .B1(n611), .C0(n516), .C1(n616), .Y(n597) );
  OAI221XL U688 ( .A0(n51), .A1(n662), .B0(n295), .B1(n53), .C0(n60), .Y(n326)
         );
  AOI222XL U689 ( .A0(n516), .A1(n647), .B0(ini_label[4]), .B1(n524), .C0(n515), .C1(n653), .Y(n60) );
  OAI221XL U690 ( .A0(n51), .A1(n665), .B0(n291), .B1(n53), .C0(n75), .Y(n346)
         );
  AOI222XL U691 ( .A0(n515), .A1(n643), .B0(ini_label[0]), .B1(n434), .C0(n516), .C1(n442), .Y(n75) );
  OAI221XL U692 ( .A0(n51), .A1(n663), .B0(n288), .B1(n53), .C0(n54), .Y(n322)
         );
  AOI222XL U693 ( .A0(n515), .A1(n649), .B0(ini_label[3]), .B1(n524), .C0(n516), .C1(n648), .Y(n54) );
  OAI221XL U694 ( .A0(n51), .A1(n661), .B0(n294), .B1(n53), .C0(n63), .Y(n330)
         );
  AOI222XL U695 ( .A0(n516), .A1(n646), .B0(ini_label[5]), .B1(n524), .C0(n515), .C1(n652), .Y(n63) );
  OAI221XL U696 ( .A0(n51), .A1(n660), .B0(n293), .B1(n53), .C0(n66), .Y(n334)
         );
  AOI222XL U697 ( .A0(n516), .A1(n478), .B0(ini_label[6]), .B1(n524), .C0(n515), .C1(n654), .Y(n66) );
  OAI221XL U698 ( .A0(n51), .A1(n659), .B0(n292), .B1(n53), .C0(n69), .Y(n338)
         );
  AOI222XL U699 ( .A0(n516), .A1(n644), .B0(ini_label[7]), .B1(n524), .C0(n515), .C1(n656), .Y(n69) );
  OAI221XL U700 ( .A0(n51), .A1(n664), .B0(n290), .B1(n53), .C0(n78), .Y(n358)
         );
  OAI32X1 U701 ( .A0(n245), .A1(n83), .A2(n82), .B0(n84), .B1(n604), .Y(n596)
         );
  OAI33X1 U702 ( .A0(center_addr[2]), .A1(n243), .A2(n247), .B0(center_addr[1]), .B1(n240), .B2(n248), .Y(n103) );
  OAI222XL U703 ( .A0(n705), .A1(n158), .B0(n700), .B1(n160), .C0(n253), .C1(
        n161), .Y(n409) );
  CLKINVX1 U704 ( .A(Xadd1[3]), .Y(n700) );
  CLKINVX1 U705 ( .A(Xsub1[3]), .Y(n705) );
  OAI222XL U706 ( .A0(n704), .A1(n158), .B0(n701), .B1(n160), .C0(n252), .C1(
        n161), .Y(n411) );
  CLKINVX1 U707 ( .A(Xadd1[2]), .Y(n701) );
  CLKINVX1 U708 ( .A(Xsub1[2]), .Y(n704) );
  OAI222XL U709 ( .A0(n706), .A1(n158), .B0(n699), .B1(n160), .C0(n254), .C1(
        n161), .Y(n413) );
  CLKINVX1 U710 ( .A(Xadd1[4]), .Y(n699) );
  CLKINVX1 U711 ( .A(Xsub1[4]), .Y(n706) );
  OAI222XL U712 ( .A0(n703), .A1(n158), .B0(n702), .B1(n160), .C0(n251), .C1(
        n161), .Y(n415) );
  CLKINVX1 U713 ( .A(Xadd1[1]), .Y(n702) );
  CLKINVX1 U714 ( .A(Xsub1[1]), .Y(n703) );
  OAI222XL U715 ( .A0(center_addr[5]), .A1(n158), .B0(center_addr[5]), .B1(
        n160), .C0(n255), .C1(n161), .Y(n420) );
  OAI22XL U716 ( .A0(n256), .A1(n48), .B0(n295), .B1(n49), .Y(n323) );
  OAI22XL U717 ( .A0(n274), .A1(n48), .B0(n291), .B1(n49), .Y(n343) );
  OAI22XL U718 ( .A0(n279), .A1(n48), .B0(n278), .B1(n49), .Y(n379) );
  OAI22XL U719 ( .A0(n266), .A1(n48), .B0(n262), .B1(n49), .Y(n382) );
  OAI22XL U720 ( .A0(n485), .A1(n48), .B0(n487), .B1(n49), .Y(n383) );
  OAI22XL U721 ( .A0(n282), .A1(n48), .B0(n277), .B1(n49), .Y(n386) );
  OAI211X1 U722 ( .A0(n712), .A1(n148), .B0(n149), .C0(n150), .Y(n403) );
  INVXL U723 ( .A(Ysub1[2]), .Y(n712) );
  AOI2BB2X1 U724 ( .B0(Yadd1[2]), .B1(n151), .A0N(n152), .A1N(n248), .Y(n150)
         );
  OAI211X1 U725 ( .A0(n708), .A1(n148), .B0(n149), .C0(n154), .Y(n405) );
  CLKINVX1 U726 ( .A(Ysub1[4]), .Y(n708) );
  AOI2BB2X1 U727 ( .B0(Yadd1[4]), .B1(n151), .A0N(n152), .A1N(n250), .Y(n154)
         );
  OAI211X1 U728 ( .A0(n711), .A1(n148), .B0(n149), .C0(n156), .Y(n406) );
  CLKINVX1 U729 ( .A(Ysub1[1]), .Y(n711) );
  AOI2BB2X1 U730 ( .B0(Yadd1[1]), .B1(n151), .A0N(n152), .A1N(n247), .Y(n156)
         );
  OAI211X1 U731 ( .A0(center_addr[0]), .A1(n148), .B0(n149), .C0(n169), .Y(
        n416) );
  AOI2BB2X1 U732 ( .B0(Yadd1[0]), .B1(n151), .A0N(n152), .A1N(n246), .Y(n169)
         );
  OAI211X1 U733 ( .A0(n709), .A1(n148), .B0(n149), .C0(n171), .Y(n418) );
  CLKINVX1 U734 ( .A(Ysub1[3]), .Y(n709) );
  AOI2BB2X1 U735 ( .B0(Yadd1[3]), .B1(n151), .A0N(n152), .A1N(n249), .Y(n171)
         );
  NAND4X1 U736 ( .A(n246), .B(n249), .C(n250), .D(n102), .Y(n18) );
  NOR2X1 U737 ( .A(n248), .B(n247), .Y(n101) );
  OA22X1 U738 ( .A0(n98), .A1(n710), .B0(n246), .B1(n100), .Y(n83) );
  AOI221XL U739 ( .A0(n101), .A1(FF_rom[1]), .B0(n102), .B1(FF_rom[7]), .C0(
        n106), .Y(n98) );
  AOI221XL U740 ( .A0(n101), .A1(FF_rom[0]), .B0(n102), .B1(FF_rom[6]), .C0(
        n103), .Y(n100) );
  OAI33X1 U741 ( .A0(center_addr[2]), .A1(n242), .A2(n247), .B0(center_addr[1]), .B1(n241), .B2(n248), .Y(n106) );
  AND3X2 U742 ( .A(n275), .B(n281), .C(n280), .Y(n535) );
  AND3X2 U743 ( .A(n279), .B(n274), .C(n273), .Y(n534) );
  OA22X1 U744 ( .A0(n296), .A1(n40), .B0(n82), .B1(n435), .Y(n84) );
  CLKINVX1 U745 ( .A(n246), .Y(n710) );
  AND3X2 U746 ( .A(n87), .B(n89), .C(n86), .Y(n533) );
  AND4X1 U747 ( .A(n285), .B(n284), .C(n283), .D(n282), .Y(n86) );
  NOR4X1 U748 ( .A(n90), .B(n91), .C(n92), .D(n93), .Y(n89) );
  NOR4X1 U749 ( .A(n97), .B(n82), .C(n245), .D(n83), .Y(n87) );
  AO22X1 U750 ( .A0(n521), .A1(FF4[3]), .B0(n637), .B1(n441), .Y(n319) );
  AO22X1 U751 ( .A0(n521), .A1(n553), .B0(n637), .B1(n439), .Y(n327) );
  AO22X1 U752 ( .A0(n521), .A1(FF4[6]), .B0(n637), .B1(n438), .Y(n331) );
  AO22X1 U753 ( .A0(n521), .A1(FF4[7]), .B0(n637), .B1(n436), .Y(n335) );
  AO22X1 U754 ( .A0(n521), .A1(FF4[2]), .B0(n637), .B1(n437), .Y(n339) );
  AO22X1 U755 ( .A0(n521), .A1(n562), .B0(n637), .B1(n440), .Y(n355) );
  OAI222XL U756 ( .A0(n661), .A1(n135), .B0(n270), .B1(n136), .C0(n262), .C1(
        n667), .Y(n391) );
  OAI222XL U757 ( .A0(n662), .A1(n135), .B0(n271), .B1(n136), .C0(n487), .C1(
        n667), .Y(n393) );
  OAI222XL U758 ( .A0(n664), .A1(n135), .B0(n286), .B1(n136), .C0(n277), .C1(
        n667), .Y(n399) );
  OAI222XL U759 ( .A0(n665), .A1(n135), .B0(n287), .B1(n136), .C0(n278), .C1(
        n667), .Y(n401) );
  OAI222XL U760 ( .A0(n135), .A1(n659), .B0(n260), .B1(n667), .C0(n136), .C1(
        n268), .Y(n387) );
  OAI222XL U761 ( .A0(n135), .A1(n660), .B0(n261), .B1(n667), .C0(n136), .C1(
        n269), .Y(n389) );
  OAI222XL U762 ( .A0(n135), .A1(n663), .B0(n275), .B1(n667), .C0(n136), .C1(
        n284), .Y(n395) );
  OAI222XL U763 ( .A0(n135), .A1(n598), .B0(n276), .B1(n667), .C0(n136), .C1(
        n285), .Y(n397) );
  NAND3X2 U764 ( .A(n667), .B(n297), .C(n693), .Y(n135) );
  NAND4X1 U765 ( .A(n251), .B(n252), .C(n175), .D(n253), .Y(n30) );
  NOR2X1 U766 ( .A(n698), .B(center_addr[9]), .Y(n175) );
  NAND4X1 U767 ( .A(n698), .B(center_addr[9]), .C(n177), .D(center_addr[8]), 
        .Y(n145) );
  NOR2X1 U768 ( .A(n251), .B(n252), .Y(n177) );
  INVX3 U769 ( .A(n141), .Y(n667) );
  OAI211X1 U770 ( .A0(n142), .A1(n432), .B0(n20), .C0(n296), .Y(n141) );
  AOI2BB2X1 U771 ( .B0(n17), .B1(n45), .A0N(n707), .A1N(n38), .Y(n142) );
  OAI22XL U772 ( .A0(n271), .A1(n657), .B0(n662), .B1(n139), .Y(n394) );
  NAND4X1 U773 ( .A(n264), .B(n265), .C(n266), .D(n485), .Y(n91) );
  NAND4X1 U774 ( .A(n268), .B(n269), .C(n94), .D(n270), .Y(n90) );
  AND2X2 U775 ( .A(n272), .B(n271), .Y(n94) );
  OAI2BB2XL U776 ( .B0(n524), .B1(n239), .A0N(N299), .A1N(n524), .Y(n353) );
  OAI2BB2XL U777 ( .B0(n524), .B1(n233), .A0N(N306), .A1N(n434), .Y(n347) );
  OAI2BB2XL U778 ( .B0(n524), .B1(n234), .A0N(N305), .A1N(n434), .Y(n348) );
  OAI2BB2XL U779 ( .B0(n524), .B1(n235), .A0N(N304), .A1N(n434), .Y(n349) );
  OAI2BB2XL U780 ( .B0(n524), .B1(n236), .A0N(N303), .A1N(n434), .Y(n350) );
  OAI2BB2XL U781 ( .B0(n524), .B1(n237), .A0N(N302), .A1N(n434), .Y(n351) );
  OAI2BB2XL U782 ( .B0(n524), .B1(n238), .A0N(N301), .A1N(n524), .Y(n352) );
  OAI2BB2XL U783 ( .B0(n524), .B1(n244), .A0N(N300), .A1N(n524), .Y(n354) );
  NAND2X1 U784 ( .A(n286), .B(n287), .Y(n97) );
  AO22X1 U785 ( .A0(n639), .A1(FF3[7]), .B0(sram_q[7]), .B1(n532), .Y(n388) );
  AO22X1 U786 ( .A0(n639), .A1(FF3[6]), .B0(sram_q[6]), .B1(n532), .Y(n390) );
  AO22X1 U787 ( .A0(n639), .A1(n554), .B0(sram_q[5]), .B1(n532), .Y(n392) );
  AO22X1 U788 ( .A0(n639), .A1(n561), .B0(sram_q[3]), .B1(n532), .Y(n396) );
  AO22X1 U789 ( .A0(n639), .A1(n557), .B0(sram_q[2]), .B1(n532), .Y(n398) );
  AO22X1 U790 ( .A0(n639), .A1(n433), .B0(sram_q[1]), .B1(n532), .Y(n400) );
  AO22X1 U791 ( .A0(n639), .A1(n563), .B0(sram_q[0]), .B1(n532), .Y(n402) );
  AND3X2 U792 ( .A(n277), .B(n278), .C(n276), .Y(n536) );
  AOI21X1 U793 ( .A0(n26), .A1(n520), .B0(n245), .Y(n407) );
  NAND3X1 U794 ( .A(n36), .B(n23), .C(n41), .Y(ns[0]) );
  AOI32X1 U795 ( .A0(n297), .A1(n435), .A2(n695), .B0(n296), .B1(n44), .Y(n41)
         );
  NAND2X1 U796 ( .A(n232), .B(n23), .Y(n318) );
  AOI222XL U797 ( .A0(n515), .A1(n641), .B0(ini_label[1]), .B1(n524), .C0(n516), .C1(n640), .Y(n78) );
  OA22X4 U798 ( .A0(n677), .A1(FF2[3]), .B0(n677), .B1(n688), .Y(n681) );
  AO21X2 U799 ( .A0(n556), .A1(n555), .B0(n654), .Y(n578) );
  NAND2X2 U800 ( .A(n520), .B(n20), .Y(n49) );
  OAI211X2 U801 ( .A0(n38), .A1(n297), .B0(n632), .C0(n49), .Y(n48) );
  NAND2X2 U802 ( .A(n133), .B(n518), .Y(n639) );
  AO22X4 U803 ( .A0(n579), .A1(n578), .B0(n577), .B1(n576), .Y(n581) );
  AO22X4 U804 ( .A0(n582), .A1(n581), .B0(n656), .B1(n580), .Y(n595) );
  XOR2X1 U805 ( .A(\r417/carry [4]), .B(center_addr[9]), .Y(Xadd1[4]) );
  NOR2X1 U806 ( .A(center_addr[6]), .B(center_addr[5]), .Y(n668) );
  AO21X1 U807 ( .A0(center_addr[5]), .A1(center_addr[6]), .B0(n668), .Y(
        Xsub1[1]) );
  NAND2X1 U808 ( .A(n668), .B(n252), .Y(n669) );
  OAI21XL U809 ( .A0(n668), .A1(n252), .B0(n669), .Y(Xsub1[2]) );
  XNOR2X1 U810 ( .A(center_addr[8]), .B(n669), .Y(Xsub1[3]) );
  NOR2X1 U811 ( .A(center_addr[8]), .B(n669), .Y(n670) );
  XOR2X1 U812 ( .A(center_addr[9]), .B(n670), .Y(Xsub1[4]) );
  CLKINVX1 U813 ( .A(center_addr[0]), .Y(Yadd1[0]) );
  XOR2X1 U814 ( .A(\r419/carry [4]), .B(center_addr[4]), .Y(Yadd1[4]) );
  NOR2X1 U815 ( .A(center_addr[1]), .B(center_addr[0]), .Y(n671) );
  AO21X1 U816 ( .A0(center_addr[0]), .A1(center_addr[1]), .B0(n671), .Y(
        Ysub1[1]) );
  NAND2X1 U817 ( .A(n671), .B(n674), .Y(n672) );
  OAI21XL U818 ( .A0(n671), .A1(n674), .B0(n672), .Y(Ysub1[2]) );
  XNOR2X1 U819 ( .A(center_addr[3]), .B(n672), .Y(Ysub1[3]) );
  NOR2X1 U820 ( .A(center_addr[3]), .B(n672), .Y(n673) );
  XOR2X1 U821 ( .A(center_addr[4]), .B(n673), .Y(Ysub1[4]) );
endmodule

