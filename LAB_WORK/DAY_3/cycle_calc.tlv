\TLV_version 1d: tl-x.org
\source top.tlv 8
\SV
   // Macro providing required top-level module definition, random
   // stimulus support, and Verilator config.
   module top(input wire clk, input wire reset, input wire [31:0] cyc_cnt, output wire passed, output wire failed);    /* verilator lint_save */ /* verilator lint_off UNOPTFLAT */  bit [256:0] RW_rand_raw; bit [256+63:0] RW_rand_vect; pseudo_rand #(.WIDTH(257)) pseudo_rand (clk, reset, RW_rand_raw[256:0]); assign RW_rand_vect[256+63:0] = {RW_rand_raw[62:0], RW_rand_raw};  /* verilator lint_restore */  /* verilator lint_off WIDTH */ /* verilator lint_off UNOPTFLAT */   // (Expanded in Nav-TLV pane.)
\TLV
   $reset = *reset;

   |calc
      @1
         $cnt = $reset ? 0 : (>>1$cnt + 1);
         $d1[31:0] = $val1[31:0];
         $d2[31:0] = $val2[31:0];
         $sum[31:0] = $d1 + $d2;
         $diff[31:0] = $d1 - $d2;
         $prod[31:0] = $d1 * $d2;
         $quot[31:0] = $d1 / $d2;

      @2
         $out[31:0] = $valid ?
                        ($op[1] ?
                            ($op[0] ? $quot : $prod) :
                            ($op[0] ? $diff : $sum))
                     : 32'b0;


   // Assert these to end simulation (before the cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule