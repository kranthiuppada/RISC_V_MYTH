\m5_TLV_version 1d: tl-x.org
\m5
\SV
   m5_makerchip_module
\TLV
   $reset = *reset;

   $val1[31:0] = >>$out;
   $val2[31:0] = $rand2[3:0];
   $op[1:0] = $rand[1:0];

   $sum[31:0]  = $val1 + $val2;
   $diff[31:0] = $val1 - $val2;
   $prod[31:0] = $val1 * $val2;
   $quot[31:0] = $val2 == 0 ? 32'b0 : $val1 / $val2;

  $out[31:0] = $reset ? 32'b0 :  $op == 2'b00 ? $sum :  $op == 2'b01 ? $diff : $op == 2'b10 ? $prod : $quot;
           

   // End condition
   *passed = *cyc_cnt > 50;
   *failed = 1'b0;
\SV
endmodule


