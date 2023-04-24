module  FAS (data_valid, data, clk, rst, fir_d, fir_valid, fft_valid, done, freq,
 fft_d1, fft_d2, fft_d3, fft_d4, fft_d5, fft_d6, fft_d7, fft_d8,
 fft_d9, fft_d10, fft_d11, fft_d12, fft_d13, fft_d14, fft_d15, fft_d0);

input clk, rst;
input data_valid;
input [15:0] data; 
output fir_valid, fft_valid;
output [15:0] fir_d;
output [31:0] fft_d1, fft_d2, fft_d3, fft_d4, fft_d5, fft_d6, fft_d7, fft_d8;
output [31:0] fft_d9, fft_d10, fft_d11, fft_d12, fft_d13, fft_d14, fft_d15, fft_d0;
output done;
output [3:0] freq;

wire stp_valid;
//wire stp_valid_p;
wire signed [15:0] po_0, po_1, po_2, po_3, po_4, po_5, po_6, po_7,
                   po_8, po_9, po_10, po_11, po_12, po_13, po_14, po_15;

//wire signed [15:0] po_0_p, po_1_p, po_2_p, po_3_p, po_4_p, po_5_p, po_6_p, po_7_p,
//                   po_8_p, po_9_p, po_10_p, po_11_p, po_12_p, po_13_p, po_14_p, po_15_p;

wire fir_valid_p;
wire signed [15:0] fir_d_p;

wire [31:0] fft_d1_d, fft_d2_d, fft_d3_d, fft_d4_d, fft_d5_d, fft_d6_d, fft_d7_d, fft_d8_d,
            fft_d9_d, fft_d10_d, fft_d11_d, fft_d12_d, fft_d13_d, fft_d14_d, fft_d15_d, fft_d0_d;

wire fft_valid_d;

FIR fir_0(
    .clk(clk), 
    .rst(rst),
    .data_valid(data_valid),
    .data(data),

    .fir_valid(fir_valid),
    .fir_d(fir_d)
  );

fir_sipo sir_sipo_0(
    .clk(clk),
    .rst(rst),
    .fir_valid(fir_valid),
    .fir_d(fir_d),

    .fir_valid_p(fir_valid_p),
    .fir_d_p(fir_d_p)
);

SIPO sipo_0(
    .clk(clk), 
    .rst(rst),
    .fir_valid(fir_valid),
    .fir_d(fir_d),

    .stp_valid(stp_valid),
    .po_0(po_0), 
    .po_1(po_1), 
    .po_2(po_2), 
    .po_3(po_3), 
    .po_4(po_4), 
    .po_5(po_5), 
    .po_6(po_6), 
    .po_7(po_7),
    .po_8(po_8), 
    .po_9(po_9), 
    .po_10(po_10), 
    .po_11(po_11), 
    .po_12(po_12), 
    .po_13(po_13), 
    .po_14(po_14), 
    .po_15(po_15)
  );

/*
sipo_fft sipo_fft0(
    .clk(clk),
    .rst(rst),
    .stp_valid(stp_valid),
    .po_0(po_0), 
    .po_1(po_1), 
    .po_2(po_2), 
    .po_3(po_3), 
    .po_4(po_4), 
    .po_5(po_5), 
    .po_6(po_6), 
    .po_7(po_7),
    .po_8(po_8), 
    .po_9(po_9), 
    .po_10(po_10), 
    .po_11(po_11), 
    .po_12(po_12), 
    .po_13(po_13), 
    .po_14(po_14), 
    .po_15(po_15),
    
    .stp_valid_p(stp_valid_p),
    .po_0_p(po_0_p), 
    .po_1_p(po_1_p), 
    .po_2_p(po_2_p), 
    .po_3_p(po_3_p), 
    .po_4_p(po_4_p), 
    .po_5_p(po_5_p), 
    .po_6_p(po_6_p), 
    .po_7_p(po_7_p),
    .po_8_p(po_8_p), 
    .po_9_p(po_9_p), 
    .po_10_p(po_10_p), 
    .po_11_p(po_11_p), 
    .po_12_p(po_12_p), 
    .po_13_p(po_13_p), 
    .po_14_p(po_14_p), 
    .po_15_p(po_15_p)
);
*/

FFT fft_0(
    .clk(clk), 
    .rst(rst),
    .stp_valid(stp_valid),
    .po_0(po_0), 
    .po_1(po_1), 
    .po_2(po_2), 
    .po_3(po_3), 
    .po_4(po_4), 
    .po_5(po_5), 
    .po_6(po_6), 
    .po_7(po_7), 
    .po_8(po_8), 
    .po_9(po_9), 
    .po_10(po_10), 
    .po_11(po_11), 
    .po_12(po_12), 
    .po_13(po_13), 
    .po_14(po_14), 
    .po_15(po_15),

    .fft_valid(fft_valid),
    .fft_d00(fft_d0), 
    .fft_d01(fft_d1), 
    .fft_d02(fft_d2), 
    .fft_d03(fft_d3), 
    .fft_d04(fft_d4), 
    .fft_d05(fft_d5), 
    .fft_d06(fft_d6), 
    .fft_d07(fft_d7),
    .fft_d08(fft_d8), 
    .fft_d09(fft_d9), 
    .fft_d10(fft_d10), 
    .fft_d11(fft_d11),
    .fft_d12(fft_d12), 
    .fft_d13(fft_d13), 
    .fft_d14(fft_d14), 
    .fft_d15(fft_d15)
  );

fft_ana fft_ana_0(
    .clk(clk), 
    .rst(rst),
    .fft_valid(fft_valid),
    .fft_d0(fft_d0), 
    .fft_d1(fft_d1), 
    .fft_d2(fft_d2), 
    .fft_d3(fft_d3), 
    .fft_d4(fft_d4), 
    .fft_d5(fft_d5), 
    .fft_d6(fft_d6), 
    .fft_d7(fft_d7),
    .fft_d8(fft_d8), 
    .fft_d9(fft_d9), 
    .fft_d10(fft_d10), 
    .fft_d11(fft_d11),
    .fft_d12(fft_d12), 
    .fft_d13(fft_d13), 
    .fft_d14(fft_d14), 
    .fft_d15(fft_d15),

    .fft_d0_d(fft_d0_d), 
    .fft_d1_d(fft_d1_d), 
    .fft_d2_d(fft_d2_d), 
    .fft_d3_d(fft_d3_d), 
    .fft_d4_d(fft_d4_d), 
    .fft_d5_d(fft_d5_d), 
    .fft_d6_d(fft_d6_d), 
    .fft_d7_d(fft_d7_d),
    .fft_d8_d(fft_d8_d), 
    .fft_d9_d(fft_d9_d), 
    .fft_d10_d(fft_d10_d), 
    .fft_d11_d(fft_d11_d),
    .fft_d12_d(fft_d12_d), 
    .fft_d13_d(fft_d13_d), 
    .fft_d14_d(fft_d14_d), 
    .fft_d15_d(fft_d15_d),
    .fft_valid_d(fft_valid_d)
);


ANALYSIS analysis_0(
    .clk(clk), 
    .rst(rst),
    .fft_valid(fft_valid_d), 
    .fft_d0(fft_d0_d), 
    .fft_d1(fft_d1_d), 
    .fft_d2(fft_d2_d), 
    .fft_d3(fft_d3_d), 
    .fft_d4(fft_d4_d), 
    .fft_d5(fft_d5_d), 
    .fft_d6(fft_d6_d), 
    .fft_d7(fft_d7_d),
    .fft_d8(fft_d8_d), 
    .fft_d9(fft_d9_d), 
    .fft_d10(fft_d10_d), 
    .fft_d11(fft_d11_d),
    .fft_d12(fft_d12_d), 
    .fft_d13(fft_d13_d), 
    .fft_d14(fft_d14_d), 
    .fft_d15(fft_d15_d),
    
    .done(done),
    .freq(freq)
  );


endmodule

