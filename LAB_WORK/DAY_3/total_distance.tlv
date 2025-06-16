\m4_TLV_version 1d: tl-x.org
\m4
   
   // ============================================
   // Welcome, new visitors! Try the "Learn" menu.
   // ============================================
   
   //use(m5-1.0)   /// uncomment to use M5 macro library.
\SV
   // Macro providing required top-level module definition, random
   // stimulus support, and Verilator config.
   m4_makerchip_module   // (Expanded in Nav-TLV pane.)
   `include "sqrt32.v"
\TLV
   |calc
      @1
         $reset = *reset;
      ?$valid
         @1
            $aa_sqr[31:0] = $aa[3:0] * $aa;
            $bb_sqr[31:0] = $bb[3:0] * $bb;
         @2
            $cc_sqr[31:0] = $aa_sqr + $bb_sqr;
         @3
            $cc[31:0] = sqrt($cc_sqr);
      @4
         $total_distance[63:0] = $reset ? 0 : ($valid ? (>>1$total_distance + $cc) : $RETAIN);
   
   // Assert these to end simulation (before the cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule
