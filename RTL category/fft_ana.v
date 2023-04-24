module fft_ana(
    input clk , rst , fft_valid ,

    input [31:0] fft_d0 , fft_d1, fft_d2, fft_d3, fft_d4, fft_d5, fft_d6, fft_d7, fft_d8,
                 fft_d9, fft_d10, fft_d11, fft_d12, fft_d13, fft_d14, fft_d15,

    output reg [31:0] fft_d0_d , fft_d1_d, fft_d2_d, fft_d3_d, fft_d4_d, fft_d5_d, fft_d6_d, fft_d7_d, fft_d8_d,
                  fft_d9_d, fft_d10_d, fft_d11_d, fft_d12_d, fft_d13_d, fft_d14_d, fft_d15_d,

    output reg fft_valid_d
);

always @ (posedge clk) begin 
    if(rst) begin 
        fft_d0_d <= 0;
        fft_d1_d <= 0;
        fft_d2_d <= 0;
        fft_d3_d <= 0;
        fft_d4_d <= 0;
        fft_d5_d <= 0;
        fft_d6_d <= 0;
        fft_d7_d <= 0;
        fft_d8_d <= 0;
        fft_d9_d <= 0;
        fft_d10_d <= 0;
        fft_d11_d <= 0;
        fft_d12_d <= 0;
        fft_d13_d <= 0;
        fft_d14_d <= 0;
        fft_d15_d <= 0;

        fft_valid_d <= 0;

    end else begin 
        fft_d0_d <= fft_d0;
        fft_d1_d <= fft_d1;
        fft_d2_d <= fft_d2;
        fft_d3_d <= fft_d3;
        fft_d4_d <= fft_d4;
        fft_d5_d <= fft_d5;
        fft_d6_d <= fft_d6;
        fft_d7_d <= fft_d7;
        fft_d8_d <= fft_d8;
        fft_d9_d <= fft_d9;
        fft_d10_d <= fft_d10;
        fft_d11_d <= fft_d11;
        fft_d12_d <= fft_d12;
        fft_d13_d <= fft_d13;
        fft_d14_d <= fft_d14;
        fft_d15_d <= fft_d15;
        fft_valid_d <= fft_valid;
    end
end

endmodule