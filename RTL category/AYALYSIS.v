module ANALYSIS(clk, rst, fft_valid, 
fft_d0, fft_d1, fft_d2, fft_d3, fft_d4, fft_d5, fft_d6, fft_d7, 
fft_d8, fft_d9, fft_d10, fft_d11, fft_d12, fft_d13, fft_d14, fft_d15,
done, freq);

input clk, rst;
input fft_valid;
input [31:0] fft_d0, fft_d1, fft_d2, fft_d3, fft_d4, fft_d5, fft_d6, fft_d7, 
              fft_d8, fft_d9, fft_d10, fft_d11, fft_d12, fft_d13, fft_d14, fft_d15;
output reg done;
output reg [3:0] freq;

parameter IDLE = 0 , ACC = 1 , CAL = 2 , SORT = 3 , OUT1 = 4 , OUT2 = 5;

reg [3:0] cs , ns;
reg [31:0] band [15:0];
reg [31:0] band_r [15:0];
reg [2:0] scnt;
reg [3:0] f [15:0];

reg [31:0] s1 [7:0];
reg [31:0] s2 [3:0];
reg [31:0] s3 [1:0];
reg [31:0] s4;

reg [3:0] f1 [7:0];
reg [3:0] f2 [3:0];
reg [3:0] f3 [1:0];
reg [3:0] f4;

always @ (posedge clk) begin 
    if(rst) begin 
        cs <= IDLE;
    end else begin 
        cs <= ns;
    end
end

always @ (*) begin 
    case(cs)
        IDLE : begin 
            if(fft_valid) begin 
                ns = ACC;
            end else begin 
                ns = IDLE;
            end
        end

        ACC : begin 
            ns <= CAL;
        end


        CAL : begin 
            if(band_r[15] == 0) begin 
                ns = CAL;
            end else begin 
                ns = SORT;
            end
        end

        SORT : begin 
            if(scnt == 4) begin 
                ns = OUT1;
            end else begin 
                ns = SORT;
            end
        end

        OUT1 : begin 
            ns = OUT2;
        end

        OUT2 : begin 
            ns = IDLE;
        end

    endcase
end

always @ (*) begin 
    case(cs)
        IDLE : begin 
            done = 0;
        end

        SORT : begin 
            done = 0;
        end

        OUT1 : begin 
            done = 0;
        end

        OUT2 : begin 
            done = 1;
        end

    endcase
end

always @ (posedge clk) begin 
    case(cs)
        IDLE : begin 
            band[0] <= 0;
            band[1] <= 0;
            band[2] <= 0;
            band[3] <= 0;
            band[4] <= 0;
            band[5] <= 0;
            band[6] <= 0;
            band[7] <= 0;
            band[8] <= 0;
            band[9] <= 0;
            band[10] <= 0;
            band[11] <= 0;
            band[12] <= 0;
            band[13] <= 0;
            band[14] <= 0;
            band[15] <= 0;

            f[0] <= 0;
            f[1] <= 1;
            f[2] <= 2;
            f[3] <= 3;
            f[4] <= 4;
            f[5] <= 5;
            f[6] <= 6;
            f[7] <= 7;
            f[8] <= 8;
            f[9] <= 9;
            f[10] <= 10;
            f[11] <= 11;
            f[12] <= 12;
            f[13] <= 13;
            f[14] <= 14;
            f[15] <= 15;

            scnt <= 0;
            f4 <= 0; 
            s4 <= 0;
            freq <= 0;
        end

        ACC : begin 
            band[0] <= fft_d0;
            band[1] <= fft_d1;
            band[2] <= fft_d2;
            band[3] <= fft_d3;
            band[4] <= fft_d4;
            band[5] <= fft_d5;
            band[6] <= fft_d6;
            band[7] <= fft_d7;
            band[8] <= fft_d8;
            band[9] <= fft_d9;
            band[10] <= fft_d10;
            band[11] <= fft_d11;
            band[12] <= fft_d12;
            band[13] <= fft_d13;
            band[14] <= fft_d14;
            band[15] <= fft_d15;
        end

        CAL : begin 
            band_r[0] <= $signed({band[0][31:16]}) * $signed({band[0][31:16]}) + $signed({band[0][15:0]}) * $signed({band[0][15:0]});
            band_r[1] <= $signed({band[1][31:16]}) * $signed({band[1][31:16]}) + $signed({band[1][15:0]}) * $signed({band[1][15:0]});
            band_r[2] <= $signed({band[2][31:16]}) * $signed({band[2][31:16]}) + $signed({band[2][15:0]}) * $signed({band[2][15:0]});
            band_r[3] <= $signed({band[3][31:16]}) * $signed({band[3][31:16]}) + $signed({band[3][15:0]}) * $signed({band[3][15:0]});
            band_r[4] <= $signed({band[4][31:16]}) * $signed({band[4][31:16]}) + $signed({band[4][15:0]}) * $signed({band[4][15:0]});
            band_r[5] <= $signed({band[5][31:16]}) * $signed({band[5][31:16]}) + $signed({band[5][15:0]}) * $signed({band[5][15:0]});
            band_r[6] <= $signed({band[6][31:16]}) * $signed({band[6][31:16]}) + $signed({band[6][15:0]}) * $signed({band[6][15:0]});
            band_r[7] <= $signed({band[7][31:16]}) * $signed({band[7][31:16]}) + $signed({band[7][15:0]}) * $signed({band[7][15:0]});
            band_r[8] <= $signed({band[8][31:16]}) * $signed({band[8][31:16]}) + $signed({band[8][15:0]}) * $signed({band[8][15:0]});
            band_r[9] <= $signed({band[9][31:16]}) * $signed({band[9][31:16]}) + $signed({band[9][15:0]}) * $signed({band[9][15:0]});
            band_r[10] <= $signed({band[10][31:16]}) * $signed({band[10][31:16]}) + $signed({band[10][15:0]}) * $signed({band[10][15:0]});
            band_r[11] <= $signed({band[11][31:16]}) * $signed({band[11][31:16]}) + $signed({band[11][15:0]}) * $signed({band[11][15:0]});
            band_r[12] <= $signed({band[12][31:16]}) * $signed({band[12][31:16]}) + $signed({band[12][15:0]}) * $signed({band[12][15:0]});
            band_r[13] <= $signed({band[13][31:16]}) * $signed({band[13][31:16]}) + $signed({band[13][15:0]}) * $signed({band[13][15:0]});
            band_r[14] <= $signed({band[14][31:16]}) * $signed({band[14][31:16]}) + $signed({band[14][15:0]}) * $signed({band[14][15:0]});
            band_r[15] <= $signed({band[15][31:16]}) * $signed({band[15][31:16]}) + $signed({band[15][15:0]}) * $signed({band[15][15:0]});
        end

        SORT : begin 
            scnt <= scnt + 1;
            
            case(scnt)
                0 : begin 
                    if(band_r[0] < band_r[1]) begin 
                        s1[0] <= band_r[1];
                        f1[0] <= f[1];
                    end else begin 
                        s1[0] <= band_r[0];
                        f1[0] <= f[0];
                    end

                    if(band_r[2] < band_r[3]) begin 
                        s1[1] <= band_r[3];
                        f1[1] <= f[3];
                    end else begin 
                        s1[1] <= band_r[2];
                        f1[1] <= f[2];
                    end

                    if(band_r[4] < band_r[5]) begin 
                        s1[2] <= band_r[5];
                        f1[2] <= f[5];
                    end else begin 
                        s1[2] <= band_r[4];
                        f1[2] <= f[4];
                    end

                    if(band_r[6] < band_r[7]) begin 
                        s1[3] <= band_r[7];
                        f1[3] <= f[7];
                    end else begin 
                        s1[3] <= band_r[6];
                        f1[3] <= f[6];
                    end

                    if(band_r[8] < band_r[9]) begin 
                        s1[4] <= band_r[9];
                        f1[4] <= f[9];
                    end else begin 
                        s1[4] <= band_r[8];
                        f1[4] <= f[8];
                    end

                    if(band_r[10] < band_r[11]) begin 
                        s1[5] <= band_r[11];
                        f1[5] <= f[11];
                    end else begin 
                        s1[5] <= band_r[10];
                        f1[5] <= f[10];
                    end

                    if(band_r[12] < band_r[13]) begin 
                        s1[6] <= band_r[13];
                        f1[6] <= f[13];
                    end else begin 
                        s1[6] <= band_r[12];
                        f1[6] <= f[12];
                    end

                    if(band_r[14] < band_r[15]) begin 
                        s1[7] <= band_r[15];
                        f1[7] <= f[15];
                    end else begin 
                        s1[7] <= band_r[14];
                        f1[7] <= f[14];
                    end
                end

                1 : begin 
                    if(s1[0] < s1[1]) begin 
                        s2[0] <= s1[1];
                        f2[0] <= f1[1];
                    end else begin 
                        s2[0] <= s1[0];
                        f2[0] <= f1[0];
                    end

                    if(s1[2] < s1[3]) begin 
                        s2[1] <= s1[3];
                        f2[1] <= f1[3];
                    end else begin 
                        s2[1] <= s1[2];
                        f2[1] <= f1[2];
                    end

                    if(s1[4] < s1[5]) begin 
                        s2[2] <= s1[5];
                        f2[2] <= f1[5];
                    end else begin 
                        s2[2] <= s1[4];
                        f2[2] <= f1[4];
                    end

                    if(s1[6] < s1[7]) begin 
                        s2[3] <= s1[7];
                        f2[3] <= f1[7];
                    end else begin 
                        s2[3] <= s1[6];
                        f2[3] <= f1[6];
                    end
                end

                2 : begin 
                    if(s2[0] < s2[1]) begin 
                        s3[0] <= s2[1];
                        f3[0] <= f2[1];
                    end else begin 
                        s3[0] <= s2[0];
                        f3[0] <= f2[0];
                    end

                    if(s2[2] < s2[3]) begin 
                        s3[1] <= s2[3];
                        f3[1] <= f2[3];
                    end else begin 
                        s3[1] <= s2[2];
                        f3[1] <= f2[2];
                    end
                end

                3 : begin 
                    if(s3[0] < s3[1]) begin 
                        s4 <= s3[1];
                        f4 <= f3[1];
                    end else begin 
                        s4 <= s3[0];
                        f4 <= f3[0];
                    end    
                end

                default : begin 
                    scnt <= 0;
                end

            endcase
        end

        OUT1 : begin 
            freq <= f4;
        end

    endcase
end

  
endmodule