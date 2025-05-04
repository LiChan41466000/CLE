wvSetPosition -win $_nWave1 {("G1" 0)}
wvOpenFile -win $_nWave1 {/home/UIS113/UIS113a01/icc2016cb/CLE.fsdb}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/test"
wvGetSignalSetScope -win $_nWave1 "/test/u_CLE"
wvSetPosition -win $_nWave1 {("G1" 41)}
wvSetPosition -win $_nWave1 {("G1" 41)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/test/u_CLE/FF1\[7:0\]} \
{/test/u_CLE/FF2\[7:0\]} \
{/test/u_CLE/FF3\[7:0\]} \
{/test/u_CLE/FF4\[7:0\]} \
{/test/u_CLE/FF5\[7:0\]} \
{/test/u_CLE/FF_rom\[7:0\]} \
{/test/u_CLE/Label\[7:0\]} \
{/test/u_CLE/ROM_read} \
{/test/u_CLE/Xadd1\[4:0\]} \
{/test/u_CLE/Xsub1\[4:0\]} \
{/test/u_CLE/Yadd1\[4:0\]} \
{/test/u_CLE/Ysub1\[4:0\]} \
{/test/u_CLE/ZP_sel} \
{/test/u_CLE/buttom} \
{/test/u_CLE/center_addr\[9:0\]} \
{/test/u_CLE/clk} \
{/test/u_CLE/com1\[7:0\]} \
{/test/u_CLE/com2\[7:0\]} \
{/test/u_CLE/counter_X\[4:0\]} \
{/test/u_CLE/counter_Y\[4:0\]} \
{/test/u_CLE/cs\[3:0\]} \
{/test/u_CLE/finish} \
{/test/u_CLE/first_scan} \
{/test/u_CLE/ini_label\[7:0\]} \
{/test/u_CLE/init_count} \
{/test/u_CLE/left} \
{/test/u_CLE/max_Label\[7:0\]} \
{/test/u_CLE/nochange} \
{/test/u_CLE/ns\[3:0\]} \
{/test/u_CLE/reset} \
{/test/u_CLE/right} \
{/test/u_CLE/rom_a\[6:0\]} \
{/test/u_CLE/rom_a_temp\[7:0\]} \
{/test/u_CLE/rom_detect} \
{/test/u_CLE/rom_q\[7:0\]} \
{/test/u_CLE/sram_a\[9:0\]} \
{/test/u_CLE/sram_d\[7:0\]} \
{/test/u_CLE/sram_q\[7:0\]} \
{/test/u_CLE/sram_q_temp\[7:0\]} \
{/test/u_CLE/sram_wen} \
{/test/u_CLE/top} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 \
           18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 \
           40 41 )} 
wvSetPosition -win $_nWave1 {("G1" 41)}
wvSetPosition -win $_nWave1 {("G1" 41)}
wvSetPosition -win $_nWave1 {("G1" 41)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/test/u_CLE/FF1\[7:0\]} \
{/test/u_CLE/FF2\[7:0\]} \
{/test/u_CLE/FF3\[7:0\]} \
{/test/u_CLE/FF4\[7:0\]} \
{/test/u_CLE/FF5\[7:0\]} \
{/test/u_CLE/FF_rom\[7:0\]} \
{/test/u_CLE/Label\[7:0\]} \
{/test/u_CLE/ROM_read} \
{/test/u_CLE/Xadd1\[4:0\]} \
{/test/u_CLE/Xsub1\[4:0\]} \
{/test/u_CLE/Yadd1\[4:0\]} \
{/test/u_CLE/Ysub1\[4:0\]} \
{/test/u_CLE/ZP_sel} \
{/test/u_CLE/buttom} \
{/test/u_CLE/center_addr\[9:0\]} \
{/test/u_CLE/clk} \
{/test/u_CLE/com1\[7:0\]} \
{/test/u_CLE/com2\[7:0\]} \
{/test/u_CLE/counter_X\[4:0\]} \
{/test/u_CLE/counter_Y\[4:0\]} \
{/test/u_CLE/cs\[3:0\]} \
{/test/u_CLE/finish} \
{/test/u_CLE/first_scan} \
{/test/u_CLE/ini_label\[7:0\]} \
{/test/u_CLE/init_count} \
{/test/u_CLE/left} \
{/test/u_CLE/max_Label\[7:0\]} \
{/test/u_CLE/nochange} \
{/test/u_CLE/ns\[3:0\]} \
{/test/u_CLE/reset} \
{/test/u_CLE/right} \
{/test/u_CLE/rom_a\[6:0\]} \
{/test/u_CLE/rom_a_temp\[7:0\]} \
{/test/u_CLE/rom_detect} \
{/test/u_CLE/rom_q\[7:0\]} \
{/test/u_CLE/sram_a\[9:0\]} \
{/test/u_CLE/sram_d\[7:0\]} \
{/test/u_CLE/sram_q\[7:0\]} \
{/test/u_CLE/sram_q_temp\[7:0\]} \
{/test/u_CLE/sram_wen} \
{/test/u_CLE/top} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 \
           18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 \
           40 41 )} 
wvSetPosition -win $_nWave1 {("G1" 41)}
wvGetSignalClose -win $_nWave1
wvExit
