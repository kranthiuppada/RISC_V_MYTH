\m5_TLV_version 1d: tl-x.org
\m5
\SV
   m5_makerchip_module
\TLV
   // Free-running counter
   $cnt[31:0] = $reset ? 0 : $cnt + 1;

   // End simulation after 40 cycles
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule
   
