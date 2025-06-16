\m5_TLV_version 1d: tl-x.org
\m5
   
   // ============================================
   // Welcome, new visitors! Try the "Learn" menu.
   // ============================================
   
   //use(m5-1.0)   /// uncomment to use M5 macro library.
\SV
   // Macro providing required top-level module definition, random
   // stimulus support, and Verilator config.
   m5_makerchip_module   // (Expanded in Nav-TLV pane.)
\TLV
    
    
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
         // Save output to memory on op = 5
         $mem[31:0] = ($op == 3'b101 && $valid) ? (>>2$out) : >>2$mem;

         // Main ALU result selection
         $alu_out[31:0] = ($op[1] ? 
                            ($op[0] ? $quot : $prod) : 
                            ($op[0] ? $diff : $sum));

         // Final output mux: includes recall (op=100)
         $out[31:0] = $valid ? 
                        (($op == 3'b100) ? >>2$mem : $alu_out)
                     : 32'b0;
   // Assert these to end simulation (before the cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule
