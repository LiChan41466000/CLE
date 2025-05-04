/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : P-2019.03
// Date      : Tue Aug 27 00:21:36 2024
/////////////////////////////////////////////////////////////


module CLE_DW01_inc_1 ( A, SUM );
  input [7:0] A;
  output [7:0] SUM;

  wire   [7:2] carry;

  ADDHXL U1_1_6 ( .A(A[6]), .B(carry[6]), .CO(carry[7]), .S(SUM[6]) );
  ADDHXL U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  ADDHXL U1_1_5 ( .A(A[5]), .B(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  ADDHXL U1_1_4 ( .A(A[4]), .B(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  ADDHXL U1_1_3 ( .A(A[3]), .B(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  ADDHXL U1_1_2 ( .A(A[2]), .B(carry[2]), .CO(carry[3]), .S(SUM[2]) );
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
  wire   nochange, N299, N300, N301, N302, N303, N304, N305, N306, n16, n17,
         n18, n19, n20, n22, n23, n25, n26, n30, n33, n34, n36, n37, n38, n39,
         n40, n41, n44, n45, n46, n51, n53, n82, n83, n84, n98, n100, n101,
         n102, n103, n106, n107, n109, n110, n111, n112, n113, n114, n115,
         n116, n118, n119, n120, n122, n123, n125, n127, n129, n131, n133,
         n142, n144, n145, n146, n148, n149, n150, n151, n152, n154, n156,
         n158, n160, n161, n169, n171, n174, n175, n177, n232, n233, n234,
         n235, n236, n237, n238, n239, n240, n241, n242, n243, n244, n245,
         n246, n247, n248, n249, n250, n251, n252, n253, n254, n255, n256,
         n257, n258, n259, n260, n261, n262, n264, n265, n266, n268, n269,
         n270, n271, n274, n275, n276, n277, n278, n279, n281, n282, n284,
         n285, n286, n287, n288, n289, n290, n291, n292, n293, n294, n295,
         n296, n297, n298, n299, n300, n301, n302, n303, n304, n305, n306,
         n307, n308, n309, n310, n311, n312, n313, n314, n315, n316, n317,
         n318, n319, n321, n322, n323, n325, n326, n327, n329, n330, n331,
         n333, n334, n335, n337, n338, n339, n341, n342, n343, n345, n346,
         n347, n348, n349, n350, n351, n352, n353, n354, n355, n357, n358,
         n360, n362, n364, n366, n368, n370, n372, n374, n376, n378, n379,
         n380, n381, n382, n383, n384, n385, n386, n387, n388, n389, n390,
         n391, n392, n393, n394, n395, n396, n397, n398, n399, n400, n401,
         n402, n403, n405, n406, n407, n409, n411, n413, n415, n416, n418,
         n420, n423, n425, n426, n427, n428, n429, n430, n431, n432, n433,
         n434, n435, n436, n437, n438, n439, n440, n441, n442, n443, n444,
         n445, n446, n447, n448, n449, n450, n451, n453, n454, n455, n456,
         n457, n458, n459, n460, n461, n462, n463, n464, n465, n466, n467,
         n468, n469, n489, n491, n493, n495, n497, n499, n501, n503, n504,
         n505, n506, n507, n508, n509, n510, n511, n512, n513, n514, n515,
         n516, n517, n518, n519, n520, n521, n522, n523, n524, n525, n526,
         n527, n528, n529, n530, n531, n532, n533, n534, n535, n536, n537,
         n538, n539, n540, n541, n542, n543, n544, n545, n546, n547, n548,
         n549, n550, n551, n552, n553, n554, n555, n556, n557, n558, n559,
         n560, n561, n562, n563, n564, n565, n566, n567, n568, n569, n570,
         n571, n572, n573, n574, n575, n576, n577, n578, n579, n580, n581,
         n582, n583, n584, n585, n586, n587, n588, n589, n590, n591, n592,
         n593, n594, n595, n596, n597, n598, n599, n600, n601, n602, n603,
         n604, n605, n606, n607, n608, n609, n610, n611, n612, n613, n614,
         n615, n616, n617, n618, n619, n620, n621, n622, n623, n624, n625,
         n626, n627, n628, n629, n630, n631, n632, n633, n634, n635, n636,
         n637, n638, n639, n640, n641, n642, n643, n644, n645, n646, n647,
         n648, n649, n650, n651, n652, n653, n654, n655, n656, n657, n658,
         n659, n660, n661, n662, n663, n664, n665, n666, n667, n668, n669,
         n670, n671, n672, n673, n674, n675, n676, n677, n678, n679, n680,
         n681, n682, n683, n684, n685, n686, n687, n688, n689, n690, n691,
         n692, n693, n694, n695, n696, n697, n698, n699, n700, n701, n702,
         n703, n704, n705, n706, n707, n708, n709, n710, n711, n712, n713,
         n714, n715, n716, n717, n718, n719, n720, n721, n722, n723, n724,
         n725, n726, n727, n728, n729, n730, n731, n732, n733, n734, n735,
         n736, n737, n738, n739, n740, n741, n742;
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

  DFFRX4 \FF1_reg[2]  ( .D(n385), .CK(clk), .RN(n512), .Q(FF1[2]), .QN(n265)
         );
  DFFRX4 \FF1_reg[3]  ( .D(n384), .CK(clk), .RN(n513), .QN(n264) );
  DFFRX4 \FF1_reg[4]  ( .D(n383), .CK(clk), .RN(n512), .Q(FF1[4]) );
  CLE_DW01_inc_1 add_250 ( .A(ini_label), .SUM({N306, N305, N304, N303, N302, 
        N301, N300, N299}) );
  DFFNSRX1 \rom_a_reg[6]  ( .D(center_addr[9]), .CKN(clk), .SN(1'b1), .RN(n514), .QN(n501) );
  DFFNSRX1 \rom_a_reg[5]  ( .D(center_addr[8]), .CKN(clk), .SN(1'b1), .RN(n514), .QN(n499) );
  DFFNSRX1 \rom_a_reg[4]  ( .D(center_addr[7]), .CKN(clk), .SN(1'b1), .RN(n514), .QN(n497) );
  DFFNSRX1 \rom_a_reg[3]  ( .D(center_addr[6]), .CKN(clk), .SN(1'b1), .RN(n514), .QN(n495) );
  DFFNSRX1 \rom_a_reg[2]  ( .D(center_addr[5]), .CKN(clk), .SN(1'b1), .RN(n514), .QN(n493) );
  DFFNSRX1 \rom_a_reg[1]  ( .D(center_addr[4]), .CKN(clk), .SN(1'b1), .RN(n514), .QN(n491) );
  DFFNSRX1 \rom_a_reg[0]  ( .D(center_addr[3]), .CKN(clk), .SN(1'b1), .RN(n514), .QN(n489) );
  DFFNSRX1 \sram_a_reg[9]  ( .D(n378), .CKN(clk), .SN(1'b1), .RN(n514), .QN(
        n300) );
  DFFNSRX1 \sram_a_reg[8]  ( .D(n376), .CKN(clk), .SN(1'b1), .RN(n514), .QN(
        n301) );
  DFFNSRX1 \sram_a_reg[7]  ( .D(n374), .CKN(clk), .SN(1'b1), .RN(n514), .QN(
        n302) );
  DFFNSRX1 \sram_a_reg[6]  ( .D(n372), .CKN(clk), .SN(1'b1), .RN(n514), .QN(
        n303) );
  DFFNSRX1 \sram_a_reg[5]  ( .D(n370), .CKN(clk), .SN(1'b1), .RN(n514), .QN(
        n304) );
  DFFNSRX1 \sram_a_reg[4]  ( .D(n368), .CKN(clk), .SN(1'b1), .RN(n514), .QN(
        n305) );
  DFFNSRX1 \sram_a_reg[3]  ( .D(n366), .CKN(clk), .SN(1'b1), .RN(n514), .QN(
        n306) );
  DFFNSRX1 \sram_a_reg[2]  ( .D(n364), .CKN(clk), .SN(1'b1), .RN(n514), .QN(
        n307) );
  DFFNSRX1 \sram_a_reg[1]  ( .D(n362), .CKN(clk), .SN(1'b1), .RN(n514), .QN(
        n308) );
  DFFNSRX1 \sram_a_reg[0]  ( .D(n360), .CKN(clk), .SN(1'b1), .RN(n514), .QN(
        n309) );
  DFFNSRX1 \sram_d_reg[7]  ( .D(n337), .CKN(clk), .SN(1'b1), .RN(n514), .QN(
        n313) );
  DFFNSRX1 \sram_d_reg[6]  ( .D(n333), .CKN(clk), .SN(1'b1), .RN(n514), .QN(
        n314) );
  DFFNSRX1 \sram_d_reg[5]  ( .D(n329), .CKN(clk), .SN(1'b1), .RN(n514), .QN(
        n315) );
  DFFNSRX1 \sram_d_reg[4]  ( .D(n325), .CKN(clk), .SN(1'b1), .RN(n514), .QN(
        n316) );
  DFFNSRX1 \sram_d_reg[3]  ( .D(n321), .CKN(clk), .SN(1'b1), .RN(n514), .QN(
        n317) );
  DFFNSRX1 \sram_d_reg[2]  ( .D(n341), .CKN(clk), .SN(1'b1), .RN(n514), .QN(
        n312) );
  DFFNSRX1 \sram_d_reg[1]  ( .D(n357), .CKN(clk), .SN(1'b1), .RN(n514), .QN(
        n310) );
  DFFNSRX1 \sram_d_reg[0]  ( .D(n345), .CKN(clk), .SN(1'b1), .RN(n514), .QN(
        n311) );
  DFFNSRX1 sram_wen_reg ( .D(n425), .CKN(clk), .SN(n513), .RN(1'b1), .QN(n469)
         );
  DFFRX1 \ini_label_reg[7]  ( .D(n347), .CK(clk), .RN(n510), .Q(ini_label[7]), 
        .QN(n233) );
  DFFSX1 \ini_label_reg[0]  ( .D(n353), .CK(clk), .SN(n514), .Q(ini_label[0]), 
        .QN(n239) );
  DFFRX1 \ini_label_reg[1]  ( .D(n354), .CK(clk), .RN(n509), .Q(ini_label[1]), 
        .QN(n244) );
  DFFRX1 \ini_label_reg[2]  ( .D(n352), .CK(clk), .RN(n509), .Q(ini_label[2]), 
        .QN(n238) );
  DFFRX1 \ini_label_reg[3]  ( .D(n351), .CK(clk), .RN(n509), .Q(ini_label[3]), 
        .QN(n237) );
  DFFRX1 \ini_label_reg[4]  ( .D(n350), .CK(clk), .RN(n509), .Q(ini_label[4]), 
        .QN(n236) );
  DFFRX1 \ini_label_reg[5]  ( .D(n349), .CK(clk), .RN(n510), .Q(ini_label[5]), 
        .QN(n235) );
  DFFRX1 \ini_label_reg[6]  ( .D(n348), .CK(clk), .RN(n510), .Q(ini_label[6]), 
        .QN(n234) );
  DFFRX1 \FF_rom_reg[7]  ( .D(rom_q[7]), .CK(clk), .RN(n510), .Q(FF_rom[7]) );
  DFFRX1 \FF_rom_reg[6]  ( .D(rom_q[6]), .CK(clk), .RN(n508), .Q(FF_rom[6]) );
  DFFRX1 \FF_rom_reg[1]  ( .D(rom_q[1]), .CK(clk), .RN(n508), .Q(FF_rom[1]) );
  DFFRX1 \FF_rom_reg[0]  ( .D(rom_q[0]), .CK(clk), .RN(n508), .Q(FF_rom[0]) );
  DFFRX1 \FF_rom_reg[3]  ( .D(rom_q[3]), .CK(clk), .RN(n508), .QN(n241) );
  DFFRX1 \FF_rom_reg[2]  ( .D(rom_q[2]), .CK(clk), .RN(n508), .QN(n240) );
  DFFRX1 \FF_rom_reg[5]  ( .D(rom_q[5]), .CK(clk), .RN(n508), .QN(n242) );
  DFFRX1 \FF_rom_reg[4]  ( .D(rom_q[4]), .CK(clk), .RN(n508), .QN(n243) );
  DFFSX1 first_scan_reg ( .D(n407), .CK(clk), .SN(n513), .Q(n443), .QN(n245)
         );
  DFFRX1 \counter_X_reg[4]  ( .D(n413), .CK(clk), .RN(n509), .Q(center_addr[9]), .QN(n254) );
  DFFRX1 \counter_Y_reg[4]  ( .D(n405), .CK(clk), .RN(n509), .Q(center_addr[4]), .QN(n250) );
  DFFRX1 \counter_Y_reg[3]  ( .D(n418), .CK(clk), .RN(n508), .Q(center_addr[3]), .QN(n249) );
  DFFRX1 \counter_X_reg[3]  ( .D(n409), .CK(clk), .RN(n509), .Q(center_addr[8]), .QN(n253) );
  DFFRX1 \cs_reg[2]  ( .D(ns[2]), .CK(clk), .RN(n510), .Q(n433), .QN(n297) );
  DFFNSRX1 nochange_reg ( .D(n423), .CKN(clk), .SN(n513), .RN(1'b1), .Q(
        nochange), .QN(n442) );
  DFFRX1 \FF5_reg[3]  ( .D(n322), .CK(clk), .RN(n511), .Q(n448), .QN(n288) );
  DFFRX1 \FF5_reg[0]  ( .D(n346), .CK(clk), .RN(n510), .Q(n445), .QN(n291) );
  DFFRX1 \FF5_reg[5]  ( .D(n330), .CK(clk), .RN(n511), .Q(n450), .QN(n294) );
  DFFRX1 \FF5_reg[2]  ( .D(n342), .CK(clk), .RN(n511), .Q(n447), .QN(n289) );
  DFFRX1 \FF5_reg[7]  ( .D(n338), .CK(clk), .RN(n511), .Q(n451), .QN(n292) );
  DFFRX1 \FF5_reg[4]  ( .D(n326), .CK(clk), .RN(n511), .Q(n449), .QN(n295) );
  DFFRX1 \FF5_reg[1]  ( .D(n358), .CK(clk), .RN(n510), .Q(n446), .QN(n290) );
  DFFRX1 \FF5_reg[6]  ( .D(n334), .CK(clk), .RN(n510), .Q(n444), .QN(n293) );
  DFFRX1 \FF1_reg[0]  ( .D(n379), .CK(clk), .RN(n511), .Q(FF1[0]) );
  DFFRX1 \FF2_reg[6]  ( .D(n389), .CK(clk), .RN(n513), .Q(FF2[6]), .QN(n277)
         );
  DFFRX1 \FF1_reg[7]  ( .D(n380), .CK(clk), .RN(n513), .Q(FF1[7]) );
  DFFRX1 \FF2_reg[0]  ( .D(n401), .CK(clk), .RN(n512), .Q(FF2[0]), .QN(n262)
         );
  DFFRX1 \FF2_reg[7]  ( .D(n387), .CK(clk), .RN(n513), .Q(FF2[7]), .QN(n276)
         );
  DFFRX1 \FF1_reg[6]  ( .D(n381), .CK(clk), .RN(n513), .Q(n427), .QN(n281) );
  DFFRX1 \FF4_reg[7]  ( .D(n335), .CK(clk), .RN(n510), .Q(n432), .QN(n275) );
  DFFRX1 \cs_reg[1]  ( .D(ns[1]), .CK(clk), .RN(n508), .Q(n438), .QN(n299) );
  DFFRX1 \FF3_reg[7]  ( .D(n388), .CK(clk), .RN(n513), .Q(FF3[7]), .QN(n284)
         );
  DFFRX1 \FF3_reg[0]  ( .D(n402), .CK(clk), .RN(n511), .Q(FF3[0]), .QN(n271)
         );
  DFFRX1 \FF4_reg[0]  ( .D(n343), .CK(clk), .RN(n512), .Q(n436), .QN(n258) );
  DFFRX1 \counter_Y_reg[0]  ( .D(n416), .CK(clk), .RN(n508), .Q(center_addr[0]), .QN(n246) );
  DFFRX1 \counter_Y_reg[1]  ( .D(n406), .CK(clk), .RN(n509), .Q(center_addr[1]), .QN(n247) );
  DFFRX1 \counter_X_reg[0]  ( .D(n420), .CK(clk), .RN(n508), .Q(center_addr[5]), .QN(n255) );
  DFFRX1 \counter_X_reg[1]  ( .D(n415), .CK(clk), .RN(n509), .Q(center_addr[6]), .QN(n251) );
  DFFRX1 \FF3_reg[6]  ( .D(n390), .CK(clk), .RN(n512), .Q(FF3[6]), .QN(n285)
         );
  DFFRX1 \FF4_reg[1]  ( .D(n355), .CK(clk), .RN(n510), .Q(FF4[1]) );
  DFFRX1 \FF3_reg[1]  ( .D(n400), .CK(clk), .RN(n512), .Q(FF3[1]), .QN(n270)
         );
  DFFRX1 \FF3_reg[4]  ( .D(n394), .CK(clk), .RN(n512), .Q(n435), .QN(n287) );
  DFFRX1 \FF4_reg[4]  ( .D(n323), .CK(clk), .RN(n511), .Q(FF4[4]) );
  DFFRX1 \FF4_reg[6]  ( .D(n331), .CK(clk), .RN(n510), .Q(n428), .QN(n274) );
  DFFRX1 \counter_Y_reg[2]  ( .D(n403), .CK(clk), .RN(n509), .Q(center_addr[2]), .QN(n248) );
  DFFRX1 \counter_X_reg[2]  ( .D(n411), .CK(clk), .RN(n509), .Q(center_addr[7]), .QN(n252) );
  DFFRX1 \cs_reg[0]  ( .D(ns[0]), .CK(clk), .RN(n508), .Q(n441), .QN(n296) );
  DFFRX1 \FF2_reg[4]  ( .D(n393), .CK(clk), .RN(n513), .Q(n426), .QN(n279) );
  DFFRX1 \cs_reg[3]  ( .D(ns[3]), .CK(clk), .RN(n509), .QN(n298) );
  DFFRX1 \FF4_reg[2]  ( .D(n339), .CK(clk), .RN(n511), .QN(n257) );
  DFFRX1 \FF2_reg[2]  ( .D(n397), .CK(clk), .RN(n512), .Q(n453), .QN(n260) );
  DFFRX1 \FF3_reg[5]  ( .D(n392), .CK(clk), .RN(n513), .Q(n430), .QN(n286) );
  DFFRX1 \FF1_reg[1]  ( .D(n386), .CK(clk), .RN(n511), .Q(n437), .QN(n266) );
  DFFRX1 \FF2_reg[1]  ( .D(n399), .CK(clk), .RN(n512), .Q(FF2[1]), .QN(n261)
         );
  DFFRX1 finish_reg ( .D(n318), .CK(clk), .RN(n510), .QN(n232) );
  DFFRX1 \FF3_reg[2]  ( .D(n398), .CK(clk), .RN(n512), .Q(FF3[2]), .QN(n269)
         );
  DFFRX1 \FF1_reg[5]  ( .D(n382), .CK(clk), .RN(n513), .Q(n431), .QN(n282) );
  DFFRX1 \FF4_reg[3]  ( .D(n319), .CK(clk), .RN(n511), .Q(n429), .QN(n256) );
  DFFRX2 \FF2_reg[3]  ( .D(n395), .CK(clk), .RN(n512), .Q(n439), .QN(n259) );
  DFFRX1 \FF4_reg[5]  ( .D(n327), .CK(clk), .RN(n511), .Q(FF4[5]) );
  DFFRX2 \FF3_reg[3]  ( .D(n396), .CK(clk), .RN(n512), .Q(FF3[3]), .QN(n268)
         );
  DFFRX2 \FF2_reg[5]  ( .D(n391), .CK(clk), .RN(n513), .Q(FF2[5]), .QN(n278)
         );
  OR2XL U355 ( .A(n570), .B(FF1[4]), .Y(n596) );
  AO22X1 U356 ( .A0(FF1[4]), .A1(n279), .B0(n570), .B1(n259), .Y(n536) );
  INVX1 U357 ( .A(n632), .Y(n568) );
  NAND2X2 U358 ( .A(n455), .B(n549), .Y(n550) );
  INVX1 U359 ( .A(n668), .Y(n591) );
  AOI31X1 U360 ( .A0(FF1[0]), .A1(n538), .A2(n537), .B0(n536), .Y(n539) );
  MX2X1 U361 ( .A(n427), .B(FF2[6]), .S0(n454), .Y(n659) );
  CLKBUFX3 U362 ( .A(n467), .Y(n454) );
  INVX1 U363 ( .A(n654), .Y(n571) );
  NAND3X2 U364 ( .A(n579), .B(n581), .C(n440), .Y(n587) );
  XNOR2XL U365 ( .A(n632), .B(n290), .Y(n635) );
  NAND2BX1 U366 ( .AN(n632), .B(n642), .Y(n576) );
  AND3X6 U367 ( .A(n567), .B(n566), .C(n565), .Y(n628) );
  NAND4BX2 U368 ( .AN(n563), .B(n562), .C(n561), .D(n560), .Y(n567) );
  MX2X1 U369 ( .A(FF1[4]), .B(n426), .S0(n467), .Y(n655) );
  NOR2X6 U370 ( .A(n545), .B(n462), .Y(n467) );
  NOR2X1 U371 ( .A(FF4[1]), .B(n550), .Y(n552) );
  OR2X1 U372 ( .A(n570), .B(n259), .Y(n534) );
  OAI21X2 U373 ( .A0(n260), .A1(FF1[2]), .B0(n534), .Y(n535) );
  OR2X4 U374 ( .A(FF3[3]), .B(n256), .Y(n549) );
  AND2X2 U375 ( .A(FF2[6]), .B(n281), .Y(n543) );
  CLKMX2X2 U376 ( .A(n604), .B(n429), .S0(n628), .Y(n646) );
  INVX1 U377 ( .A(n264), .Y(n570) );
  AOI21X1 U378 ( .A0(n573), .A1(n647), .B0(n463), .Y(n434) );
  INVX1 U379 ( .A(n257), .Y(n619) );
  AND2X2 U380 ( .A(n580), .B(n578), .Y(n440) );
  INVX12 U381 ( .A(n232), .Y(finish) );
  CLKMX2X2 U382 ( .A(n435), .B(FF4[4]), .S0(n628), .Y(n665) );
  NAND3X1 U383 ( .A(n576), .B(n434), .C(n633), .Y(n579) );
  AOI21X1 U384 ( .A0(n572), .A1(n434), .B0(n461), .Y(n581) );
  XNOR2XL U385 ( .A(n654), .B(n294), .Y(n657) );
  NAND2X1 U386 ( .A(n619), .B(n269), .Y(n455) );
  MX2XL U387 ( .A(n431), .B(FF2[5]), .S0(n467), .Y(n654) );
  MX2XL U388 ( .A(n437), .B(n607), .S0(n467), .Y(n632) );
  AOI22XL U389 ( .A0(n577), .A1(n636), .B0(n655), .B1(n582), .Y(n578) );
  NAND4BX2 U390 ( .AN(n588), .B(n587), .C(n586), .D(n585), .Y(n594) );
  INVXL U391 ( .A(n647), .Y(n574) );
  NOR2X1 U392 ( .A(n664), .B(n571), .Y(n461) );
  MX2XL U393 ( .A(FF3[2]), .B(n619), .S0(n628), .Y(n647) );
  INVX1 U394 ( .A(n458), .Y(n675) );
  NAND2X1 U395 ( .A(n651), .B(n650), .Y(n652) );
  INVX1 U396 ( .A(n616), .Y(n505) );
  NAND2X1 U397 ( .A(n653), .B(n616), .Y(n456) );
  NAND2XL U398 ( .A(n652), .B(n505), .Y(n457) );
  NAND2X1 U399 ( .A(n456), .B(n457), .Y(n458) );
  CLKMX2X2 U400 ( .A(n570), .B(n439), .S0(n467), .Y(n636) );
  AND2X2 U401 ( .A(n673), .B(n672), .Y(n459) );
  AND2X2 U402 ( .A(n663), .B(n662), .Y(n460) );
  NAND3X1 U403 ( .A(n675), .B(n676), .C(n674), .Y(n703) );
  INVX1 U404 ( .A(n646), .Y(n577) );
  OR2X1 U405 ( .A(n658), .B(n591), .Y(n589) );
  MX2XL U406 ( .A(FF3[7]), .B(n432), .S0(n628), .Y(n668) );
  AND2XL U407 ( .A(FF1[7]), .B(n276), .Y(n462) );
  NAND4X2 U408 ( .A(n548), .B(n258), .C(n547), .D(FF3[0]), .Y(n555) );
  OR2X4 U409 ( .A(FF4[5]), .B(n286), .Y(n557) );
  AOI21X2 U410 ( .A0(n552), .A1(FF3[1]), .B0(n551), .Y(n553) );
  MX2X1 U411 ( .A(n459), .B(n460), .S0(n616), .Y(n674) );
  NAND3X2 U412 ( .A(n594), .B(n593), .C(n592), .Y(n616) );
  NOR2X1 U413 ( .A(n636), .B(n577), .Y(n463) );
  INVX1 U414 ( .A(n550), .Y(n547) );
  MX2XL U415 ( .A(n430), .B(FF4[5]), .S0(n628), .Y(n664) );
  AOI21X1 U416 ( .A0(n266), .A1(n607), .B0(FF2[0]), .Y(n537) );
  XNOR2XL U417 ( .A(n668), .B(n292), .Y(n671) );
  NAND4BX2 U418 ( .AN(n556), .B(n555), .C(n553), .D(n554), .Y(n562) );
  MX2XL U419 ( .A(FF3[6]), .B(n428), .S0(n628), .Y(n669) );
  MX2XL U420 ( .A(FF3[0]), .B(n436), .S0(n628), .Y(n643) );
  INVXL U421 ( .A(n535), .Y(n538) );
  NOR2BXL U422 ( .AN(n616), .B(n617), .Y(n466) );
  NOR2XL U423 ( .A(n617), .B(n616), .Y(n465) );
  CLKMX2X2 U424 ( .A(n569), .B(n453), .S0(n467), .Y(n637) );
  NAND2X1 U425 ( .A(n298), .B(n438), .Y(n38) );
  INVX1 U426 ( .A(n542), .Y(n504) );
  NAND2X1 U427 ( .A(n557), .B(n559), .Y(n561) );
  OAI2BB1XL U428 ( .A0N(n287), .A1N(FF4[4]), .B0(n558), .Y(n559) );
  OR2XL U429 ( .A(n274), .B(FF3[6]), .Y(n560) );
  XNOR2XL U430 ( .A(n665), .B(n295), .Y(n666) );
  XNOR2XL U431 ( .A(n664), .B(n294), .Y(n667) );
  XNOR2XL U432 ( .A(n642), .B(n290), .Y(n645) );
  XNOR2XL U433 ( .A(n647), .B(n289), .Y(n648) );
  XNOR2XL U434 ( .A(n658), .B(n292), .Y(n661) );
  NAND2XL U435 ( .A(FF3[7]), .B(n275), .Y(n565) );
  NAND2XL U436 ( .A(FF4[5]), .B(n286), .Y(n558) );
  NAND4BBXL U437 ( .AN(n249), .BN(n250), .C(n101), .D(center_addr[0]), .Y(n45)
         );
  NOR2X1 U438 ( .A(n438), .B(n298), .Y(n17) );
  CLKINVX1 U439 ( .A(reset), .Y(n716) );
  OAI33X2 U440 ( .A0(n544), .A1(n468), .A2(n543), .B0(FF2[6]), .B1(n468), .B2(
        n281), .Y(n545) );
  MX2XL U441 ( .A(FF1[0]), .B(FF2[0]), .S0(n454), .Y(n633) );
  NOR2X1 U442 ( .A(n573), .B(n463), .Y(n575) );
  CLKINVX1 U443 ( .A(n589), .Y(n588) );
  CLKINVX1 U444 ( .A(n425), .Y(n726) );
  NAND2X1 U445 ( .A(n575), .B(n574), .Y(n580) );
  NOR2X1 U446 ( .A(n642), .B(n568), .Y(n572) );
  NAND2X1 U447 ( .A(n591), .B(n658), .Y(n592) );
  NAND3X1 U448 ( .A(n590), .B(n589), .C(n659), .Y(n593) );
  NAND2BX1 U449 ( .AN(n461), .B(n584), .Y(n586) );
  OAI22XL U450 ( .A0(n654), .A1(n583), .B0(n655), .B1(n582), .Y(n584) );
  CLKINVX1 U451 ( .A(n664), .Y(n583) );
  CLKINVX1 U452 ( .A(n637), .Y(n573) );
  NAND2BX1 U453 ( .AN(n659), .B(n669), .Y(n585) );
  CLKINVX1 U454 ( .A(n669), .Y(n590) );
  CLKINVX1 U455 ( .A(n665), .Y(n582) );
  NAND2X1 U456 ( .A(n133), .B(n711), .Y(n425) );
  AOI211X1 U457 ( .A0(n19), .A1(n738), .B0(n26), .C0(n425), .Y(n152) );
  NAND2X1 U458 ( .A(n161), .B(n728), .Y(n160) );
  CLKINVX1 U459 ( .A(n710), .Y(n713) );
  NAND2BX1 U460 ( .AN(n148), .B(n738), .Y(n149) );
  CLKINVX1 U461 ( .A(n519), .Y(n626) );
  NOR2X1 U462 ( .A(n144), .B(n520), .Y(n464) );
  CLKINVX1 U463 ( .A(n53), .Y(n629) );
  CLKMX2X2 U464 ( .A(n608), .B(FF4[1]), .S0(n628), .Y(n642) );
  CLKINVX1 U465 ( .A(n515), .Y(n133) );
  OR4X1 U466 ( .A(n608), .B(n607), .C(n606), .D(n605), .Y(n609) );
  OR4X1 U467 ( .A(FF3[2]), .B(n453), .C(n604), .D(n439), .Y(n605) );
  OR4X1 U468 ( .A(n435), .B(n426), .C(n430), .D(FF2[5]), .Y(n601) );
  NAND2X1 U469 ( .A(n641), .B(n640), .Y(n653) );
  OR3X2 U470 ( .A(n597), .B(n596), .C(n595), .Y(n598) );
  OR4X1 U471 ( .A(n431), .B(n427), .C(FF1[7]), .D(FF1[0]), .Y(n595) );
  OR2X1 U472 ( .A(n569), .B(n437), .Y(n597) );
  NAND2X1 U473 ( .A(n506), .B(n441), .Y(n109) );
  CLKINVX1 U474 ( .A(n687), .Y(n712) );
  CLKINVX1 U475 ( .A(n564), .Y(n563) );
  OAI21XL U476 ( .A0(n507), .A1(n441), .B0(n46), .Y(n119) );
  OR2X1 U477 ( .A(n46), .B(n709), .Y(n631) );
  CLKINVX1 U478 ( .A(n708), .Y(n711) );
  OR2X1 U479 ( .A(FF3[0]), .B(FF2[0]), .Y(n606) );
  CLKINVX1 U480 ( .A(n506), .Y(n725) );
  OR4X1 U481 ( .A(FF4[1]), .B(n436), .C(n619), .D(n432), .Y(n599) );
  OR4X1 U482 ( .A(n428), .B(FF4[5]), .C(FF4[4]), .D(n429), .Y(n600) );
  OR2X1 U483 ( .A(FF3[6]), .B(FF2[6]), .Y(n603) );
  CLKINVX1 U484 ( .A(n709), .Y(n715) );
  OR2X1 U485 ( .A(FF3[7]), .B(FF2[7]), .Y(n602) );
  NAND2X1 U486 ( .A(n715), .B(n507), .Y(n33) );
  OAI211X1 U487 ( .A0(n36), .A1(n707), .B0(n22), .C0(n706), .Y(ns[2]) );
  AND2X2 U488 ( .A(n23), .B(n25), .Y(n706) );
  AND2X2 U489 ( .A(n442), .B(n705), .Y(n707) );
  AOI22X1 U490 ( .A0(n26), .A1(n711), .B0(n438), .B1(n715), .Y(n25) );
  NOR4BBX1 U491 ( .AN(n39), .BN(n174), .C(n19), .D(n425), .Y(n161) );
  NAND2X1 U492 ( .A(n17), .B(n18), .Y(n174) );
  OR4X1 U493 ( .A(n532), .B(n531), .C(n530), .D(n529), .Y(n710) );
  OR4X1 U494 ( .A(n606), .B(n608), .C(FF3[2]), .D(n607), .Y(n531) );
  OR4X1 U495 ( .A(n604), .B(n453), .C(n439), .D(n435), .Y(n532) );
  OR3X2 U496 ( .A(n597), .B(n602), .C(n524), .Y(n530) );
  AND3X2 U497 ( .A(n728), .B(n45), .C(n152), .Y(n151) );
  NOR2X1 U498 ( .A(center_addr[1]), .B(center_addr[2]), .Y(n102) );
  NAND2X1 U499 ( .A(n161), .B(n17), .Y(n158) );
  CLKINVX1 U500 ( .A(n17), .Y(n727) );
  NOR2X1 U501 ( .A(n727), .B(n30), .Y(n19) );
  OR3X2 U502 ( .A(n433), .B(n516), .C(n144), .Y(n523) );
  NAND2X1 U503 ( .A(n727), .B(n38), .Y(n20) );
  NAND2X1 U504 ( .A(n152), .B(n17), .Y(n148) );
  OR4X1 U505 ( .A(n528), .B(n527), .C(n526), .D(n525), .Y(n529) );
  OR4X1 U506 ( .A(FF1[0]), .B(FF4[1]), .C(n436), .D(n619), .Y(n528) );
  OR4X1 U507 ( .A(n428), .B(n432), .C(FF4[5]), .D(FF4[4]), .Y(n525) );
  OR4X1 U508 ( .A(n596), .B(n431), .C(n427), .D(FF1[7]), .Y(n527) );
  NAND2X1 U509 ( .A(n714), .B(n433), .Y(n22) );
  CLKINVX1 U510 ( .A(n18), .Y(n738) );
  OR4X1 U511 ( .A(n430), .B(n426), .C(FF2[5]), .D(n603), .Y(n524) );
  CLKINVX1 U512 ( .A(n46), .Y(n714) );
  NAND2X1 U513 ( .A(n107), .B(n53), .Y(n51) );
  OAI21XL U514 ( .A0(n712), .A1(n84), .B0(n441), .Y(n107) );
  OAI221XL U515 ( .A0(n30), .A1(n38), .B0(n727), .B1(n145), .C0(n146), .Y(n144) );
  AOI2BB2X1 U516 ( .B0(n738), .B1(n17), .A0N(n45), .A1N(n38), .Y(n146) );
  NOR3X1 U517 ( .A(n38), .B(n45), .C(n145), .Y(n26) );
  NAND3X1 U518 ( .A(n433), .B(n441), .C(n17), .Y(n23) );
  NAND3X1 U519 ( .A(n711), .B(n17), .C(n738), .Y(n36) );
  NAND2X1 U520 ( .A(n40), .B(n22), .Y(n53) );
  OAI21XL U521 ( .A0(n729), .A1(n45), .B0(n728), .Y(n39) );
  CLKINVX1 U522 ( .A(n145), .Y(n729) );
  OR2X1 U523 ( .A(n517), .B(n708), .Y(n519) );
  CLKINVX1 U524 ( .A(n20), .Y(n517) );
  OAI211X1 U525 ( .A0(n38), .A1(n433), .B0(n39), .C0(n40), .Y(n37) );
  OR2X1 U526 ( .A(n515), .B(n709), .Y(n520) );
  CLKINVX1 U527 ( .A(n38), .Y(n728) );
  AO22X1 U528 ( .A0(n627), .A1(n570), .B0(n626), .B1(n439), .Y(n384) );
  AO22X1 U529 ( .A0(n627), .A1(n431), .B0(n626), .B1(FF2[5]), .Y(n382) );
  AO22X1 U530 ( .A0(n627), .A1(FF4[4]), .B0(n626), .B1(n449), .Y(n323) );
  AO22X1 U531 ( .A0(n627), .A1(FF4[5]), .B0(n626), .B1(n450), .Y(n327) );
  AO22X1 U532 ( .A0(n627), .A1(n428), .B0(n626), .B1(n444), .Y(n331) );
  AO22X1 U533 ( .A0(n627), .A1(n432), .B0(n626), .B1(n451), .Y(n335) );
  AO22X1 U534 ( .A0(n627), .A1(n619), .B0(n626), .B1(n447), .Y(n339) );
  AO22X1 U535 ( .A0(n627), .A1(n436), .B0(n626), .B1(n445), .Y(n343) );
  AO22X1 U536 ( .A0(n627), .A1(FF4[1]), .B0(n626), .B1(n446), .Y(n355) );
  AO22X1 U537 ( .A0(n627), .A1(n569), .B0(n626), .B1(n453), .Y(n385) );
  AO22X1 U538 ( .A0(n627), .A1(n429), .B0(n626), .B1(n448), .Y(n319) );
  AO22X1 U539 ( .A0(n627), .A1(FF1[4]), .B0(n626), .B1(n426), .Y(n383) );
  AO22X1 U540 ( .A0(n627), .A1(n437), .B0(n626), .B1(n607), .Y(n386) );
  AO22X1 U541 ( .A0(n627), .A1(FF1[0]), .B0(n626), .B1(FF2[0]), .Y(n379) );
  AO22X1 U542 ( .A0(n627), .A1(FF1[7]), .B0(n626), .B1(FF2[7]), .Y(n380) );
  AO22X1 U543 ( .A0(n627), .A1(n427), .B0(n626), .B1(FF2[6]), .Y(n381) );
  CLKINVX1 U544 ( .A(n30), .Y(n705) );
  CLKINVX1 U545 ( .A(n516), .Y(n521) );
  OAI211X1 U546 ( .A0(n724), .A1(n441), .B0(n33), .C0(n34), .Y(ns[1]) );
  AOI22X1 U547 ( .A0(n717), .A1(n30), .B0(n714), .B1(n441), .Y(n34) );
  CLKINVX1 U548 ( .A(n37), .Y(n724) );
  CLKINVX1 U549 ( .A(n36), .Y(n717) );
  CLKBUFX3 U550 ( .A(n716), .Y(n512) );
  CLKBUFX3 U551 ( .A(n716), .Y(n511) );
  CLKBUFX3 U552 ( .A(n716), .Y(n509) );
  CLKBUFX3 U553 ( .A(n716), .Y(n508) );
  CLKBUFX3 U554 ( .A(n716), .Y(n510) );
  CLKBUFX3 U555 ( .A(n716), .Y(n513) );
  CLKBUFX3 U556 ( .A(n716), .Y(n514) );
  NOR2X1 U557 ( .A(n639), .B(n638), .Y(n640) );
  XNOR2X1 U558 ( .A(n637), .B(n289), .Y(n638) );
  OAI2BB2XL U559 ( .B0(n279), .B1(FF1[4]), .A0N(FF2[5]), .A1N(n282), .Y(n542)
         );
  OAI31X1 U560 ( .A0(FF2[1]), .A1(n535), .A2(n266), .B0(n541), .Y(n533) );
  OAI22XL U561 ( .A0(n506), .A1(n300), .B0(n725), .B1(n129), .Y(n378) );
  AOI222XL U562 ( .A0(Xsub1[4]), .A1(n119), .B0(n120), .B1(center_addr[9]), 
        .C0(Xadd1[4]), .C1(n122), .Y(n129) );
  OAI21XL U563 ( .A0(FF4[4]), .A1(n287), .B0(n546), .Y(n556) );
  OAI33X1 U564 ( .A0(n614), .A1(n613), .A2(n612), .B0(n611), .B1(n610), .B2(
        n609), .Y(n687) );
  OR3X2 U565 ( .A(n603), .B(n602), .C(n601), .Y(n610) );
  OR2X1 U566 ( .A(sram_q[2]), .B(sram_q[3]), .Y(n613) );
  OR3X2 U567 ( .A(n600), .B(n599), .C(n598), .Y(n611) );
  CLKINVX1 U568 ( .A(n557), .Y(n551) );
  OR2X1 U569 ( .A(FF3[7]), .B(n275), .Y(n564) );
  XOR2X1 U570 ( .A(n438), .B(n298), .Y(n515) );
  NOR2X1 U571 ( .A(n649), .B(n648), .Y(n650) );
  NOR2BX1 U572 ( .AN(n695), .B(n694), .Y(n700) );
  XNOR2X1 U573 ( .A(n686), .B(n289), .Y(n695) );
  NAND4BX1 U574 ( .AN(n712), .B(n693), .C(n692), .D(n691), .Y(n694) );
  XNOR2X1 U575 ( .A(n688), .B(n291), .Y(n693) );
  NOR2X1 U576 ( .A(n661), .B(n660), .Y(n662) );
  XNOR2X1 U577 ( .A(n659), .B(n293), .Y(n660) );
  NAND3BX1 U578 ( .AN(n704), .B(n703), .C(n702), .Y(n423) );
  CLKINVX1 U579 ( .A(n631), .Y(n704) );
  AOI22X1 U580 ( .A0(n701), .A1(n700), .B0(nochange), .B1(n699), .Y(n702) );
  NOR2X1 U581 ( .A(n635), .B(n634), .Y(n641) );
  XNOR2X1 U582 ( .A(n633), .B(n291), .Y(n634) );
  NOR2X1 U583 ( .A(n645), .B(n644), .Y(n651) );
  XNOR2X1 U584 ( .A(n643), .B(n291), .Y(n644) );
  NOR2X1 U585 ( .A(n657), .B(n656), .Y(n663) );
  XNOR2X1 U586 ( .A(n655), .B(n295), .Y(n656) );
  NOR2X1 U587 ( .A(n667), .B(n666), .Y(n673) );
  CLKBUFX3 U588 ( .A(n299), .Y(n507) );
  NOR2X1 U589 ( .A(n671), .B(n670), .Y(n672) );
  XNOR2X1 U590 ( .A(n669), .B(n293), .Y(n670) );
  CLKBUFX3 U591 ( .A(n112), .Y(n506) );
  OAI221XL U592 ( .A0(n433), .A1(n515), .B0(n296), .B1(n38), .C0(n33), .Y(n112) );
  NAND3X1 U593 ( .A(n564), .B(n274), .C(FF3[6]), .Y(n566) );
  NAND2X1 U594 ( .A(n296), .B(n506), .Y(n111) );
  NOR2BX1 U595 ( .AN(nochange), .B(n687), .Y(n676) );
  NAND2BX1 U596 ( .AN(FF3[1]), .B(FF4[1]), .Y(n548) );
  ADDHXL U597 ( .A(center_addr[7]), .B(\r417/carry [2]), .CO(\r417/carry [3]), 
        .S(Xadd1[2]) );
  ADDHXL U598 ( .A(center_addr[6]), .B(center_addr[5]), .CO(\r417/carry [2]), 
        .S(Xadd1[1]) );
  OR4X1 U599 ( .A(sram_q[4]), .B(sram_q[5]), .C(sram_q[7]), .D(sram_q[6]), .Y(
        n614) );
  CLKINVX1 U600 ( .A(n268), .Y(n604) );
  OAI222XL U601 ( .A0(n249), .A1(n109), .B0(n115), .B1(n111), .C0(n506), .C1(
        n306), .Y(n366) );
  AOI22X1 U602 ( .A0(n438), .A1(Yadd1[3]), .B0(Ysub1[3]), .B1(n507), .Y(n115)
         );
  OAI222XL U603 ( .A0(n250), .A1(n109), .B0(n116), .B1(n111), .C0(n506), .C1(
        n305), .Y(n368) );
  AOI22X1 U604 ( .A0(n438), .A1(Yadd1[4]), .B0(Ysub1[4]), .B1(n507), .Y(n116)
         );
  OAI222XL U605 ( .A0(n246), .A1(n109), .B0(n110), .B1(n111), .C0(n506), .C1(
        n309), .Y(n360) );
  AOI22X1 U606 ( .A0(n438), .A1(n246), .B0(n246), .B1(n507), .Y(n110) );
  OAI222XL U607 ( .A0(n247), .A1(n109), .B0(n113), .B1(n111), .C0(n506), .C1(
        n308), .Y(n362) );
  AOI22X1 U608 ( .A0(n438), .A1(Yadd1[1]), .B0(Ysub1[1]), .B1(n507), .Y(n113)
         );
  OAI222XL U609 ( .A0(n248), .A1(n109), .B0(n114), .B1(n111), .C0(n506), .C1(
        n307), .Y(n364) );
  AOI22X1 U610 ( .A0(n438), .A1(Yadd1[2]), .B0(Ysub1[2]), .B1(n507), .Y(n114)
         );
  OR2X1 U611 ( .A(sram_q[0]), .B(sram_q[1]), .Y(n612) );
  ADDHXL U612 ( .A(center_addr[8]), .B(\r417/carry [3]), .CO(\r417/carry [4]), 
        .S(Xadd1[3]) );
  NOR2X1 U613 ( .A(FF1[7]), .B(n276), .Y(n468) );
  XNOR2X1 U614 ( .A(n680), .B(n292), .Y(n681) );
  XNOR2X1 U615 ( .A(n689), .B(n290), .Y(n692) );
  XNOR2X1 U616 ( .A(n679), .B(n295), .Y(n682) );
  XNOR2X1 U617 ( .A(n690), .B(n288), .Y(n691) );
  OAI22XL U618 ( .A0(n298), .A1(n433), .B0(n297), .B1(n16), .Y(ns[3]) );
  AOI222XL U619 ( .A0(n17), .A1(n18), .B0(n19), .B1(nochange), .C0(n20), .C1(
        n441), .Y(n16) );
  OAI22XL U620 ( .A0(n726), .A1(n310), .B0(n290), .B1(n425), .Y(n357) );
  OAI22XL U621 ( .A0(n726), .A1(n316), .B0(n295), .B1(n425), .Y(n325) );
  OAI22XL U622 ( .A0(n726), .A1(n314), .B0(n293), .B1(n425), .Y(n333) );
  OAI22XL U623 ( .A0(n726), .A1(n313), .B0(n292), .B1(n425), .Y(n337) );
  OAI22XL U624 ( .A0(n726), .A1(n312), .B0(n289), .B1(n425), .Y(n341) );
  OAI22XL U625 ( .A0(n726), .A1(n311), .B0(n291), .B1(n425), .Y(n345) );
  OAI22XL U626 ( .A0(n726), .A1(n315), .B0(n294), .B1(n425), .Y(n329) );
  OAI22XL U627 ( .A0(n726), .A1(n317), .B0(n288), .B1(n425), .Y(n321) );
  OAI22XL U628 ( .A0(n506), .A1(n304), .B0(n725), .B1(n118), .Y(n370) );
  AOI222XL U629 ( .A0(n255), .A1(n119), .B0(n120), .B1(center_addr[5]), .C0(
        n255), .C1(n122), .Y(n118) );
  OAI22XL U630 ( .A0(n506), .A1(n303), .B0(n725), .B1(n123), .Y(n372) );
  AOI222XL U631 ( .A0(Xsub1[1]), .A1(n119), .B0(n120), .B1(center_addr[6]), 
        .C0(Xadd1[1]), .C1(n122), .Y(n123) );
  OAI22XL U632 ( .A0(n506), .A1(n302), .B0(n725), .B1(n125), .Y(n374) );
  AOI222XL U633 ( .A0(Xsub1[2]), .A1(n119), .B0(n120), .B1(center_addr[7]), 
        .C0(Xadd1[2]), .C1(n122), .Y(n125) );
  OAI22XL U634 ( .A0(n506), .A1(n301), .B0(n725), .B1(n127), .Y(n376) );
  AOI222XL U635 ( .A0(Xsub1[3]), .A1(n119), .B0(n120), .B1(center_addr[8]), 
        .C0(Xadd1[3]), .C1(n122), .Y(n127) );
  OR3X2 U636 ( .A(n298), .B(n433), .C(n507), .Y(n40) );
  OAI21XL U637 ( .A0(n698), .A1(n697), .B0(n696), .Y(n699) );
  NAND4X1 U638 ( .A(n293), .B(n294), .C(n288), .D(n295), .Y(n698) );
  NAND4X1 U639 ( .A(n290), .B(n291), .C(n289), .D(n292), .Y(n697) );
  NOR2X1 U640 ( .A(n296), .B(n40), .Y(n696) );
  NAND2BX1 U641 ( .AN(n438), .B(n298), .Y(n46) );
  OAI21XL U642 ( .A0(n438), .A1(n441), .B0(n297), .Y(n122) );
  OR2X1 U643 ( .A(n296), .B(n433), .Y(n709) );
  NOR2BX1 U644 ( .AN(n131), .B(n296), .Y(n120) );
  OAI21XL U645 ( .A0(n507), .A1(n433), .B0(n298), .Y(n131) );
  NOR2BX1 U646 ( .AN(n685), .B(n684), .Y(n701) );
  XNOR2X1 U647 ( .A(n677), .B(n293), .Y(n685) );
  NAND4BX1 U648 ( .AN(n442), .B(n683), .C(n682), .D(n681), .Y(n684) );
  XNOR2X1 U649 ( .A(n678), .B(n294), .Y(n683) );
  OR2X1 U650 ( .A(n297), .B(n441), .Y(n708) );
  ADDHXL U651 ( .A(center_addr[2]), .B(\r419/carry [2]), .CO(\r419/carry [3]), 
        .S(Yadd1[2]) );
  ADDHXL U652 ( .A(center_addr[1]), .B(center_addr[0]), .CO(\r419/carry [2]), 
        .S(Yadd1[1]) );
  CLKINVX1 U653 ( .A(n261), .Y(n607) );
  CLKINVX1 U654 ( .A(n270), .Y(n608) );
  ADDHXL U655 ( .A(center_addr[3]), .B(\r419/carry [3]), .CO(\r419/carry [4]), 
        .S(Yadd1[3]) );
  CLKINVX1 U656 ( .A(n265), .Y(n569) );
  CLKINVX1 U657 ( .A(sram_q[6]), .Y(n677) );
  CLKINVX1 U658 ( .A(sram_q[7]), .Y(n680) );
  CLKINVX1 U659 ( .A(sram_q[5]), .Y(n678) );
  CLKINVX1 U660 ( .A(sram_q[4]), .Y(n679) );
  CLKINVX1 U661 ( .A(sram_q[3]), .Y(n690) );
  CLKINVX1 U662 ( .A(sram_q[1]), .Y(n689) );
  CLKINVX1 U663 ( .A(sram_q[2]), .Y(n686) );
  CLKINVX1 U664 ( .A(sram_q[0]), .Y(n688) );
  OA22X1 U665 ( .A0(n98), .A1(center_addr[0]), .B0(n246), .B1(n100), .Y(n83)
         );
  AOI221XL U666 ( .A0(n101), .A1(FF_rom[1]), .B0(n102), .B1(FF_rom[7]), .C0(
        n106), .Y(n98) );
  AOI221XL U667 ( .A0(n101), .A1(FF_rom[0]), .B0(n102), .B1(FF_rom[6]), .C0(
        n103), .Y(n100) );
  OAI33X1 U668 ( .A0(center_addr[2]), .A1(n242), .A2(n247), .B0(center_addr[1]), .B1(n241), .B2(n248), .Y(n106) );
  OAI33X1 U669 ( .A0(center_addr[2]), .A1(n243), .A2(n247), .B0(center_addr[1]), .B1(n240), .B2(n248), .Y(n103) );
  OAI221XL U670 ( .A0(n237), .A1(n710), .B0(n51), .B1(n690), .C0(n622), .Y(
        n322) );
  OAI221XL U671 ( .A0(n236), .A1(n710), .B0(n51), .B1(n679), .C0(n621), .Y(
        n326) );
  AOI222XL U672 ( .A0(n629), .A1(n449), .B0(n466), .B1(n655), .C0(n465), .C1(
        n665), .Y(n621) );
  OAI221XL U673 ( .A0(n235), .A1(n710), .B0(n51), .B1(n678), .C0(n620), .Y(
        n330) );
  AOI222XL U674 ( .A0(n629), .A1(n450), .B0(n466), .B1(n654), .C0(n465), .C1(
        n664), .Y(n620) );
  OAI221XL U675 ( .A0(n234), .A1(n710), .B0(n51), .B1(n677), .C0(n625), .Y(
        n334) );
  AOI222XL U676 ( .A0(n629), .A1(n444), .B0(n466), .B1(n659), .C0(n465), .C1(
        n669), .Y(n625) );
  OAI221XL U677 ( .A0(n233), .A1(n710), .B0(n51), .B1(n680), .C0(n623), .Y(
        n338) );
  AOI222XL U678 ( .A0(n629), .A1(n451), .B0(n466), .B1(n658), .C0(n465), .C1(
        n668), .Y(n623) );
  OAI221XL U679 ( .A0(n238), .A1(n710), .B0(n51), .B1(n686), .C0(n618), .Y(
        n342) );
  AOI222XL U680 ( .A0(n629), .A1(n447), .B0(n466), .B1(n637), .C0(n465), .C1(
        n647), .Y(n618) );
  OAI221XL U681 ( .A0(n239), .A1(n710), .B0(n51), .B1(n688), .C0(n630), .Y(
        n346) );
  AOI222XL U682 ( .A0(n629), .A1(n445), .B0(n466), .B1(n633), .C0(n465), .C1(
        n643), .Y(n630) );
  OAI221XL U683 ( .A0(n244), .A1(n710), .B0(n51), .B1(n689), .C0(n624), .Y(
        n358) );
  AOI222XL U684 ( .A0(n629), .A1(n446), .B0(n466), .B1(n632), .C0(n465), .C1(
        n642), .Y(n624) );
  CLKINVX1 U685 ( .A(n615), .Y(n617) );
  OAI32X1 U686 ( .A0(n245), .A1(n83), .A2(n82), .B0(n84), .B1(n687), .Y(n615)
         );
  NAND4X1 U687 ( .A(n246), .B(n249), .C(n250), .D(n102), .Y(n18) );
  OAI211X1 U688 ( .A0(n142), .A1(n433), .B0(n20), .C0(n296), .Y(n516) );
  AOI2BB2X1 U689 ( .B0(n17), .B1(n45), .A0N(n738), .A1N(n38), .Y(n142) );
  OAI2BB2XL U690 ( .B0(n713), .B1(n239), .A0N(N299), .A1N(n713), .Y(n353) );
  OAI2BB2XL U691 ( .B0(n713), .B1(n233), .A0N(N306), .A1N(n713), .Y(n347) );
  OAI2BB2XL U692 ( .B0(n713), .B1(n234), .A0N(N305), .A1N(n713), .Y(n348) );
  OAI2BB2XL U693 ( .B0(n713), .B1(n235), .A0N(N304), .A1N(n713), .Y(n349) );
  OAI2BB2XL U694 ( .B0(n713), .B1(n236), .A0N(N303), .A1N(n713), .Y(n350) );
  OAI2BB2XL U695 ( .B0(n713), .B1(n237), .A0N(N302), .A1N(n713), .Y(n351) );
  OAI2BB2XL U696 ( .B0(n713), .B1(n238), .A0N(N301), .A1N(n713), .Y(n352) );
  OAI2BB2XL U697 ( .B0(n713), .B1(n244), .A0N(N300), .A1N(n713), .Y(n354) );
  NOR2X1 U698 ( .A(n248), .B(n247), .Y(n101) );
  OA22X1 U699 ( .A0(n296), .A1(n40), .B0(n82), .B1(n443), .Y(n84) );
  OAI211X1 U700 ( .A0(n742), .A1(n148), .B0(n149), .C0(n150), .Y(n403) );
  CLKINVX1 U701 ( .A(Ysub1[2]), .Y(n742) );
  AOI2BB2X1 U702 ( .B0(Yadd1[2]), .B1(n151), .A0N(n152), .A1N(n248), .Y(n150)
         );
  OAI211X1 U703 ( .A0(n740), .A1(n148), .B0(n149), .C0(n171), .Y(n418) );
  CLKINVX1 U704 ( .A(Ysub1[3]), .Y(n740) );
  AOI2BB2X1 U705 ( .B0(Yadd1[3]), .B1(n151), .A0N(n152), .A1N(n249), .Y(n171)
         );
  OR2X1 U706 ( .A(n297), .B(n516), .Y(n522) );
  OR4X1 U707 ( .A(n82), .B(n429), .C(n245), .D(n83), .Y(n526) );
  OR2X1 U708 ( .A(n22), .B(n296), .Y(n82) );
  OAI222XL U709 ( .A0(n680), .A1(n523), .B0(n284), .B1(n522), .C0(n276), .C1(
        n521), .Y(n387) );
  OAI222XL U710 ( .A0(n677), .A1(n523), .B0(n285), .B1(n522), .C0(n277), .C1(
        n521), .Y(n389) );
  OAI222XL U711 ( .A0(n679), .A1(n523), .B0(n287), .B1(n522), .C0(n279), .C1(
        n521), .Y(n393) );
  OAI222XL U712 ( .A0(n686), .A1(n523), .B0(n269), .B1(n522), .C0(n260), .C1(
        n521), .Y(n397) );
  OAI222XL U713 ( .A0(n689), .A1(n523), .B0(n270), .B1(n522), .C0(n261), .C1(
        n521), .Y(n399) );
  OAI222XL U714 ( .A0(n688), .A1(n523), .B0(n271), .B1(n522), .C0(n262), .C1(
        n521), .Y(n401) );
  OAI222XL U715 ( .A0(n736), .A1(n158), .B0(n731), .B1(n160), .C0(n253), .C1(
        n161), .Y(n409) );
  CLKINVX1 U716 ( .A(Xadd1[3]), .Y(n731) );
  CLKINVX1 U717 ( .A(Xsub1[3]), .Y(n736) );
  OAI222XL U718 ( .A0(n735), .A1(n158), .B0(n732), .B1(n160), .C0(n252), .C1(
        n161), .Y(n411) );
  CLKINVX1 U719 ( .A(Xadd1[2]), .Y(n732) );
  CLKINVX1 U720 ( .A(Xsub1[2]), .Y(n735) );
  OAI222XL U721 ( .A0(n737), .A1(n158), .B0(n730), .B1(n160), .C0(n254), .C1(
        n161), .Y(n413) );
  CLKINVX1 U722 ( .A(Xsub1[4]), .Y(n737) );
  CLKINVX1 U723 ( .A(Xadd1[4]), .Y(n730) );
  OAI222XL U724 ( .A0(n734), .A1(n158), .B0(n733), .B1(n160), .C0(n251), .C1(
        n161), .Y(n415) );
  CLKINVX1 U725 ( .A(Xadd1[1]), .Y(n733) );
  CLKINVX1 U726 ( .A(Xsub1[1]), .Y(n734) );
  OAI222XL U727 ( .A0(center_addr[5]), .A1(n158), .B0(center_addr[5]), .B1(
        n160), .C0(n255), .C1(n161), .Y(n420) );
  OAI222XL U728 ( .A0(n678), .A1(n523), .B0(n286), .B1(n522), .C0(n278), .C1(
        n521), .Y(n391) );
  OAI211X1 U729 ( .A0(n739), .A1(n148), .B0(n149), .C0(n154), .Y(n405) );
  CLKINVX1 U730 ( .A(Ysub1[4]), .Y(n739) );
  AOI2BB2X1 U731 ( .B0(Yadd1[4]), .B1(n151), .A0N(n152), .A1N(n250), .Y(n154)
         );
  OAI211X1 U732 ( .A0(n741), .A1(n148), .B0(n149), .C0(n156), .Y(n406) );
  CLKINVX1 U733 ( .A(Ysub1[1]), .Y(n741) );
  AOI2BB2X1 U734 ( .B0(Yadd1[1]), .B1(n151), .A0N(n152), .A1N(n247), .Y(n156)
         );
  OAI211X1 U735 ( .A0(center_addr[0]), .A1(n148), .B0(n149), .C0(n169), .Y(
        n416) );
  AOI2BB2X1 U736 ( .B0(n246), .B1(n151), .A0N(n152), .A1N(n246), .Y(n169) );
  NAND4X1 U737 ( .A(n251), .B(n252), .C(n175), .D(n253), .Y(n30) );
  NOR2X1 U738 ( .A(center_addr[5]), .B(center_addr[9]), .Y(n175) );
  NAND4X1 U739 ( .A(center_addr[5]), .B(center_addr[9]), .C(n177), .D(
        center_addr[8]), .Y(n145) );
  NOR2X1 U740 ( .A(n251), .B(n252), .Y(n177) );
  CLKINVX1 U741 ( .A(n518), .Y(n627) );
  OAI211X1 U742 ( .A0(n38), .A1(n297), .B0(n631), .C0(n519), .Y(n518) );
  AOI21X1 U743 ( .A0(n26), .A1(n711), .B0(n245), .Y(n407) );
  NAND3X1 U744 ( .A(n36), .B(n23), .C(n41), .Y(ns[0]) );
  AOI32X1 U745 ( .A0(n297), .A1(n443), .A2(n728), .B0(n296), .B1(n44), .Y(n41)
         );
  OAI211X1 U746 ( .A0(n45), .A1(n38), .B0(n46), .C0(n433), .Y(n44) );
  NAND2X1 U747 ( .A(n232), .B(n23), .Y(n318) );
  AO22X1 U748 ( .A0(n464), .A1(sram_q[3]), .B0(n520), .B1(n604), .Y(n396) );
  AO22X1 U749 ( .A0(n464), .A1(sram_q[5]), .B0(n520), .B1(n430), .Y(n392) );
  AO22X1 U750 ( .A0(n464), .A1(sram_q[4]), .B0(n520), .B1(n435), .Y(n394) );
  AO22X1 U751 ( .A0(n464), .A1(sram_q[2]), .B0(n520), .B1(FF3[2]), .Y(n398) );
  AO22X1 U752 ( .A0(n464), .A1(sram_q[1]), .B0(n520), .B1(n608), .Y(n400) );
  AO22X1 U753 ( .A0(n464), .A1(sram_q[7]), .B0(n520), .B1(FF3[7]), .Y(n388) );
  AO22X1 U754 ( .A0(n464), .A1(sram_q[6]), .B0(n520), .B1(FF3[6]), .Y(n390) );
  AO22X1 U755 ( .A0(n464), .A1(sram_q[0]), .B0(n520), .B1(FF3[0]), .Y(n402) );
  XNOR2X1 U756 ( .A(n646), .B(n288), .Y(n649) );
  NAND2X1 U757 ( .A(FF3[3]), .B(n256), .Y(n546) );
  OAI222XL U758 ( .A0(n690), .A1(n523), .B0(n268), .B1(n522), .C0(n259), .C1(
        n521), .Y(n395) );
  MX2X1 U759 ( .A(FF1[7]), .B(FF2[7]), .S0(n454), .Y(n658) );
  AOI31X1 U760 ( .A0(FF1[2]), .A1(n534), .A2(n260), .B0(n533), .Y(n540) );
  NAND3XL U761 ( .A(n549), .B(n257), .C(FF3[2]), .Y(n554) );
  INVX12 U762 ( .A(n469), .Y(sram_wen) );
  INVX12 U763 ( .A(n311), .Y(sram_d[0]) );
  INVX12 U764 ( .A(n310), .Y(sram_d[1]) );
  INVX12 U765 ( .A(n312), .Y(sram_d[2]) );
  INVX12 U766 ( .A(n317), .Y(sram_d[3]) );
  INVX12 U767 ( .A(n316), .Y(sram_d[4]) );
  INVX12 U768 ( .A(n315), .Y(sram_d[5]) );
  INVX12 U769 ( .A(n314), .Y(sram_d[6]) );
  INVX12 U770 ( .A(n313), .Y(sram_d[7]) );
  INVX12 U771 ( .A(n309), .Y(sram_a[0]) );
  INVX12 U772 ( .A(n308), .Y(sram_a[1]) );
  INVX12 U773 ( .A(n307), .Y(sram_a[2]) );
  INVX12 U774 ( .A(n306), .Y(sram_a[3]) );
  INVX12 U775 ( .A(n305), .Y(sram_a[4]) );
  INVX12 U776 ( .A(n304), .Y(sram_a[5]) );
  INVX12 U777 ( .A(n303), .Y(sram_a[6]) );
  INVX12 U778 ( .A(n302), .Y(sram_a[7]) );
  INVX12 U779 ( .A(n301), .Y(sram_a[8]) );
  INVX12 U780 ( .A(n300), .Y(sram_a[9]) );
  INVX12 U781 ( .A(n489), .Y(rom_a[0]) );
  INVX12 U782 ( .A(n491), .Y(rom_a[1]) );
  INVX12 U783 ( .A(n493), .Y(rom_a[2]) );
  INVX12 U784 ( .A(n495), .Y(rom_a[3]) );
  INVX12 U785 ( .A(n497), .Y(rom_a[4]) );
  INVX12 U786 ( .A(n499), .Y(rom_a[5]) );
  INVX12 U787 ( .A(n501), .Y(rom_a[6]) );
  OAI2BB2X2 U788 ( .B0(n504), .B1(n503), .A0N(n539), .A1N(n540), .Y(n544) );
  NOR2XL U789 ( .A(FF2[5]), .B(n282), .Y(n503) );
  AOI222XL U790 ( .A0(n629), .A1(n448), .B0(n466), .B1(n636), .C0(n465), .C1(
        n646), .Y(n622) );
  XNOR2XL U791 ( .A(n636), .B(n288), .Y(n639) );
  OR2X4 U792 ( .A(FF2[5]), .B(n282), .Y(n541) );
  XOR2X1 U793 ( .A(\r417/carry [4]), .B(center_addr[9]), .Y(Xadd1[4]) );
  NOR2X1 U794 ( .A(center_addr[6]), .B(center_addr[5]), .Y(n718) );
  AO21X1 U795 ( .A0(center_addr[5]), .A1(center_addr[6]), .B0(n718), .Y(
        Xsub1[1]) );
  NAND2X1 U796 ( .A(n718), .B(n252), .Y(n719) );
  OAI21XL U797 ( .A0(n718), .A1(n252), .B0(n719), .Y(Xsub1[2]) );
  XNOR2X1 U798 ( .A(center_addr[8]), .B(n719), .Y(Xsub1[3]) );
  NOR2X1 U799 ( .A(center_addr[8]), .B(n719), .Y(n720) );
  XOR2X1 U800 ( .A(center_addr[9]), .B(n720), .Y(Xsub1[4]) );
  XOR2X1 U801 ( .A(\r419/carry [4]), .B(center_addr[4]), .Y(Yadd1[4]) );
  NOR2X1 U802 ( .A(center_addr[1]), .B(center_addr[0]), .Y(n721) );
  AO21X1 U803 ( .A0(center_addr[0]), .A1(center_addr[1]), .B0(n721), .Y(
        Ysub1[1]) );
  NAND2X1 U804 ( .A(n721), .B(n248), .Y(n722) );
  OAI21XL U805 ( .A0(n721), .A1(n248), .B0(n722), .Y(Ysub1[2]) );
  XNOR2X1 U806 ( .A(center_addr[3]), .B(n722), .Y(Ysub1[3]) );
  NOR2X1 U807 ( .A(center_addr[3]), .B(n722), .Y(n723) );
  XOR2X1 U808 ( .A(center_addr[4]), .B(n723), .Y(Ysub1[4]) );
endmodule

