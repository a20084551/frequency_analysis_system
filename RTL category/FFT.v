module FFT (clk, rst, stp_valid,
po_0, po_1, po_2, po_3, po_4, po_5, po_6, po_7, 
po_8, po_9, po_10, po_11, po_12, po_13, po_14, po_15,
fft_valid,
fft_d00, fft_d01, fft_d02, fft_d03, fft_d04, fft_d05, fft_d06, fft_d07, 
fft_d08, fft_d09, fft_d10, fft_d11, fft_d12, fft_d13, fft_d14, fft_d15);

input clk, rst;
input stp_valid;
input signed [15:0] po_0, po_1, po_2, po_3, po_4, po_5, po_6, po_7, 
                    po_8, po_9, po_10, po_11, po_12, po_13, po_14, po_15;
output  reg fft_valid;
output reg signed [31:0] fft_d00, fft_d01, fft_d02, fft_d03, fft_d04, fft_d05, fft_d06, fft_d07, 
                         fft_d08, fft_d09, fft_d10, fft_d11, fft_d12, fft_d13, fft_d14, fft_d15;

parameter signed [31:0] real_0 = 32'h00010000;  // The real part of the reference table about COS(x)+i*SIN(x) value , 0: 001
parameter signed [31:0] real_1 = 32'h0000EC83;  // The real part of the reference table about COS(x)+i*SIN(x) value , 1: 9.238739e-001
parameter signed [31:0] real_2 = 32'h0000B504;  // The real part of the reference table about COS(x)+i*SIN(x) value , 2: 7.070923e-001
parameter signed [31:0] real_3 = 32'h000061F7;  // The real part of the reference table about COS(x)+i*SIN(x) value , 3: 3.826752e-001
parameter signed [31:0] real_4 = 32'h00000000;  // The real part of the reference table about COS(x)+i*SIN(x) value , 4: 000
parameter signed [31:0] real_5 = 32'hFFFF9E09;  // The real part of the reference table about COS(x)+i*SIN(x) value , 5: -3.826752e-001
parameter signed [31:0] real_6 = 32'hFFFF4AFC;  // The real part of the reference table about COS(x)+i*SIN(x) value , 6: -7.070923e-001
parameter signed [31:0] real_7 = 32'hFFFF137D;  // The real part of the reference table about COS(x)+i*SIN(x) value , 7: -9.238739e-001

parameter signed [31:0] img_0 = 32'h00000000;  // The imag part of the reference table about COS(x)+i*SIN(x) value , 0: 000
parameter signed [31:0] img_1 = 32'hFFFF9E09;  // The imag part of the reference table about COS(x)+i*SIN(x) value , 1: -3.826752e-001
parameter signed [31:0] img_2 = 32'hFFFF4AFC;  // The imag part of the reference table about COS(x)+i*SIN(x) value , 2: -7.070923e-001
parameter signed [31:0] img_3 = 32'hFFFF137D;  // The imag part of the reference table about COS(x)+i*SIN(x) value , 3: -9.238739e-001
parameter signed [31:0] img_4 = 32'hFFFF0000;  // The imag part of the reference table about COS(x)+i*SIN(x) value , 4: -01
parameter signed [31:0] img_5 = 32'hFFFF137D;  // The imag part of the reference table about COS(x)+i*SIN(x) value , 5: -9.238739e-001
parameter signed [31:0] img_6 = 32'hFFFF4AFC;  // The imag part of the reference table about COS(x)+i*SIN(x) value , 6: -7.070923e-001
parameter signed [31:0] img_7 = 32'hFFFF9E09;  // The imag part of the reference table about COS(x)+i*SIN(x) value , 7: -3.826752e-001

reg signed [15:0] s_r [15:0];
reg signed [15:0] s_w [15:0];

reg signed [147:0] s1_r [15:0]; 
reg signed [147:0] s2_r [15:0];
reg signed [147:0] s3_r [15:0];
reg signed [147:0] s4_r [15:0];

reg signed [147:0] s1_w [15:0];
reg signed [147:0] s2_w [15:0];
reg signed [147:0] s3_w [15:0];
reg signed [147:0] s4_w [15:0];

reg [4:0] fft_cnt;

always @ (posedge clk)begin
	if(rst)begin
	    fft_cnt <= 0;
        fft_valid <= 0;
	end else begin
		if(stp_valid ||fft_cnt > 0)begin
			if(fft_cnt > 5)begin
			    fft_cnt <= 0;
			    fft_valid <= 1;
			end else begin
			    fft_cnt <= fft_cnt+1;
			    fft_valid <= 0;
			end
		end else begin 
			fft_valid <= 0;
		end
	end
end

always @ (posedge clk) begin 
    if(stp_valid || ( (fft_cnt > 0) & (fft_cnt < 6))) begin 
        s1_r[0] <= (po_0 + po_8) * real_0; 
        s1_r[1] <= (po_1 + po_9) * real_0;
        s1_r[2] <= (po_2 + po_10) * real_0; 
        s1_r[3] <= (po_3 + po_11) * real_0; 
        s1_r[4] <= (po_4 + po_12) * real_0; 
        s1_r[5] <= (po_5 + po_13) * real_0; 
        s1_r[6] <= (po_6 + po_14) * real_0; 
        s1_r[7] <= (po_7 + po_15) * real_0; 
        
        s1_w[0] <= 0; 
        s1_w[1] <= 0; 
        s1_w[2] <= 0; 
        s1_w[3] <= 0; 
        s1_w[4] <= 0; 
        s1_w[5] <= 0; 
        s1_w[6] <= 0; 
        s1_w[7] <= 0; 

        s1_r[ 8] <= (po_0 - po_8) * real_0;
        s1_r[ 9] <= (po_1 - po_9) * real_1;
        s1_r[10] <= (po_2 - po_10) * real_2;
        s1_r[11] <= (po_3 - po_11) * real_3;
        s1_r[12] <= (po_4 - po_12) * real_4;
        s1_r[13] <= (po_5 - po_13) * real_5;
        s1_r[14] <= (po_6 - po_14) * real_6;
        s1_r[15] <= (po_7 - po_15) * real_7;

        s1_w[ 8] <= (po_0 - po_8) * img_0;
        s1_w[ 9] <= (po_1 - po_9) * img_1;
        s1_w[10] <= (po_2 - po_10) * img_2;
        s1_w[11] <= (po_3 - po_11) * img_3;
        s1_w[12] <= (po_4 - po_12) * img_4;
        s1_w[13] <= (po_5 - po_13) * img_5;
        s1_w[14] <= (po_6 - po_14) * img_6;
        s1_w[15] <= (po_7 - po_15) * img_7;
    end
end

always @ (posedge clk) begin 
    if(stp_valid || ( (fft_cnt > 0) & (fft_cnt < 6))) begin 
        s2_r[0] <= (s1_r[0] + s1_r[4]) * real_0;
        s2_r[1] <= (s1_r[1] + s1_r[5]) * real_0;
        s2_r[2] <= (s1_r[2] + s1_r[6]) * real_0;
        s2_r[3] <= (s1_r[3] + s1_r[7]) * real_0;

        s2_w[0] <= (s1_w[0] + s1_w[4]) * real_0;
        s2_w[1] <= (s1_w[1] + s1_w[5]) * real_0;
        s2_w[2] <= (s1_w[2] + s1_w[6]) * real_0;
        s2_w[3] <= (s1_w[3] + s1_w[7]) * real_0;
                
        s2_r[4] <= (s1_r[0]-s1_r[4]) * real_0 + (s1_w[4]-s1_w[0]) * img_0;
        s2_r[5] <= (s1_r[1]-s1_r[5]) * real_2 + (s1_w[5]-s1_w[1]) * img_2;
        s2_r[6] <= (s1_r[2]-s1_r[6]) * real_4 + (s1_w[6]-s1_w[2]) * img_4;
        s2_r[7] <= (s1_r[3]-s1_r[7]) * real_6 + (s1_w[7]-s1_w[3]) * img_6;

        s2_w[4] <= (s1_r[0]-s1_r[4]) * img_0 + (s1_w[0]-s1_w[4]) * real_0;
        s2_w[5] <= (s1_r[1]-s1_r[5]) * img_2 + (s1_w[1]-s1_w[5]) * real_2;
        s2_w[6] <= (s1_r[2]-s1_r[6]) * img_4 + (s1_w[2]-s1_w[6]) * real_4;
        s2_w[7] <= (s1_r[3]-s1_r[7]) * img_6 + (s1_w[3]-s1_w[7]) * real_6;

        s2_r[8] <= (s1_r[8]+s1_r[12]) * real_0;
        s2_r[9] <= (s1_r[9]+s1_r[13]) * real_0;
        s2_r[10] <= (s1_r[10]+s1_r[14]) * real_0;
        s2_r[11] <= (s1_r[11]+s1_r[15]) * real_0;

        s2_w[8] <= (s1_w[8]+s1_w[12]) * real_0;
        s2_w[9] <= (s1_w[9]+s1_w[13]) * real_0;
        s2_w[10] <= (s1_w[10]+s1_w[14]) * real_0;
        s2_w[11] <= (s1_w[11]+s1_w[15]) * real_0;
                
        s2_r[12] <= (s1_r[8]-s1_r[12]) * real_0 + (s1_w[12]-s1_w[8]) * img_0;
        s2_r[13] <= (s1_r[9]-s1_r[13]) * real_2 + (s1_w[13]-s1_w[9]) * img_2;
        s2_r[14] <= (s1_r[10]-s1_r[14]) * real_4 + (s1_w[14]-s1_w[10]) * img_4;
        s2_r[15] <= (s1_r[11]-s1_r[15]) * real_6 + (s1_w[15]-s1_w[11]) * img_6;
        s2_w[12] <= (s1_r[8]-s1_r[12]) * img_0 + (s1_w[8]-s1_w[12]) * real_0;
        s2_w[13] <= (s1_r[9]-s1_r[13]) * img_2 + (s1_w[9]-s1_w[13]) * real_2;
        s2_w[14] <= (s1_r[10]-s1_r[14]) * img_4 + (s1_w[10]-s1_w[14]) * real_4;
        s2_w[15] <= (s1_r[11]-s1_r[15]) * img_6 + (s1_w[11]-s1_w[15]) * real_6; 
    end

end

always @ (posedge clk) begin 
    if(stp_valid || ( (fft_cnt > 0) & (fft_cnt < 6))) begin 
        s3_r[0] <= (s2_r[0]+s2_r[2]) * real_0;
        s3_r[1] <= (s2_r[1]+s2_r[3]) * real_0;
        s3_r[4] <= (s2_r[4]+s2_r[6]) * real_0;
        s3_r[5] <= (s2_r[5]+s2_r[7]) * real_0;
        s3_r[8] <= (s2_r[8]+s2_r[10]) * real_0;
        s3_r[9] <= (s2_r[9]+s2_r[11]) * real_0;
        s3_r[12] <= (s2_r[12]+s2_r[14]) * real_0;
        s3_r[13] <= (s2_r[13]+s2_r[15]) * real_0;

        s3_w[0] <= (s2_w[0]+s2_w[2]) * real_0;
        s3_w[1] <= (s2_w[1]+s2_w[3]) * real_0;
        s3_w[4] <= (s2_w[4]+s2_w[6]) * real_0;
        s3_w[5] <= (s2_w[5]+s2_w[7]) * real_0;
        s3_w[8] <= (s2_w[8]+s2_w[10]) * real_0;
        s3_w[9] <= (s2_w[9]+s2_w[11]) * real_0;
        s3_w[12] <= (s2_w[12]+s2_w[14]) * real_0;
        s3_w[13] <= (s2_w[13]+s2_w[15]) * real_0;

        s3_r[2] <= (s2_r[0] - s2_r[2]) * real_0 + (s2_w[2] - s2_w[0]) * img_0;               
        s3_r[3] <= (s2_r[1] - s2_r[3]) * real_4 + (s2_w[3] - s2_w[1]) * img_4;           
        s3_r[6] <= (s2_r[4] - s2_r[6]) * real_0 + (s2_w[6] - s2_w[4]) * img_0;
        s3_r[7] <= (s2_r[5] - s2_r[7]) * real_4 + (s2_w[7] - s2_w[5]) * img_4;           
        s3_r[10] <= (s2_r[8] - s2_r[10]) * real_0 + (s2_w[10] - s2_w[8]) * img_0;
        s3_r[11] <= (s2_r[9] - s2_r[11]) * real_4 + (s2_w[11] - s2_w[9]) * img_4;                                  
        s3_r[14] <= (s2_r[12] - s2_r[14]) * real_0 + (s2_w[14] - s2_w[12]) * img_0;
        s3_r[15] <= (s2_r[13] - s2_r[15]) * real_4 + (s2_w[15] - s2_w[13]) * img_4;
    
        s3_w[2] <= (s2_r[0] - s2_r[2]) * img_0 + (s2_w[0] - s2_w[2]) * real_0;
        s3_w[3] <= (s2_r[1] - s2_r[3]) * img_4 + (s2_w[1] - s2_w[3]) * real_4;           
        s3_w[6] <= (s2_r[4] - s2_r[6]) * img_0 + (s2_w[4] - s2_w[6]) * real_0;          
        s3_w[7] <= (s2_r[5] - s2_r[7]) * img_4 + (s2_w[5] - s2_w[7]) * real_4;
        s3_w[10] <= (s2_r[8] - s2_r[10]) * img_0 + (s2_w[8] - s2_w[10]) * real_0;
        s3_w[11] <= (s2_r[9] - s2_r[11]) * img_4 + (s2_w[9] - s2_w[11]) * real_4;          
        s3_w[14] <= (s2_r[12] - s2_r[14]) * img_0 + (s2_w[12] - s2_w[14]) * real_0;
        s3_w[15] <= (s2_r[13] - s2_r[15]) * img_4 + (s2_w[13] - s2_w[15]) * real_4;
    end
end

always @ (posedge clk) begin 
    if(stp_valid || ( (fft_cnt > 0) & (fft_cnt < 6)) ) begin 
        s4_r[0] <= (s3_r[0] + s3_r[1]) * real_0;
        s4_w[0] <= (s3_w[0] + s3_w[1]) * real_0;
        s4_r[2] <= (s3_r[2] + s3_r[3]) * real_0;
        s4_w[2] <= (s3_w[2] + s3_w[3]) * real_0;
        s4_r[4] <= (s3_r[4] + s3_r[5]) * real_0;
        s4_w[4] <= (s3_w[4] + s3_w[5]) * real_0;
        s4_r[6] <= (s3_r[6] + s3_r[7]) * real_0;
        s4_w[6] <= (s3_w[6] + s3_w[7]) * real_0;
        s4_r[8] <= (s3_r[8] + s3_r[9]) * real_0;
        s4_w[8] <= (s3_w[8] + s3_w[9]) * real_0;
        s4_r[10] <= (s3_r[10] + s3_r[11]) * real_0;
        s4_w[10] <= (s3_w[10] + s3_w[11]) * real_0;
        s4_r[12] <= (s3_r[12] + s3_r[13]) * real_0;
        s4_w[12] <= (s3_w[12] + s3_w[13]) * real_0;
        s4_r[14] <= (s3_r[14] + s3_r[15]) * real_0;
        s4_w[14] <= (s3_w[14] + s3_w[15]) * real_0;
        
        s4_r[1] <= ((s3_r[0] - s3_r[1]) * real_0) + ((s3_w[1] - s3_w[0]) * img_0);
        s4_r[3] <= ((s3_r[2] - s3_r[3]) * real_0) + ((s3_w[3] - s3_w[2]) * img_0);
        s4_r[5] <= ((s3_r[4] - s3_r[5]) * real_0) + ((s3_w[5] - s3_w[4]) * img_0);
        s4_r[7] <= ((s3_r[6] - s3_r[7]) * real_0) + ((s3_w[7] - s3_w[6]) * img_0);
        s4_r[9] <= ((s3_r[8] - s3_r[9]) * real_0) + ((s3_w[9] - s3_w[8]) * img_0);
        s4_r[11] <= ((s3_r[10] - s3_r[11]) * real_0) + ((s3_w[11] - s3_w[10]) * img_0);                                    
        s4_r[13] <= ((s3_r[12] - s3_r[13]) * real_0) + ((s3_w[13] - s3_w[12]) * img_0);
        s4_r[15] <= ((s3_r[14] - s3_r[15]) * real_0) + ((s3_w[15] - s3_w[14]) * img_0);

        s4_w[1] <= ((s3_r[0] - s3_r[1]) * img_0) + ((s3_w[0] - s3_w[1]) * real_0);
        s4_w[3] <= ((s3_r[2] - s3_r[3]) * img_0) + ((s3_w[2] - s3_w[3]) * real_0);
        s4_w[5] <= ((s3_r[4] - s3_r[5]) * img_0) + ((s3_w[4] - s3_w[5]) * real_0);	
        s4_w[7] <= ((s3_r[6] - s3_r[7]) * img_0) + ((s3_w[6] - s3_w[7]) * real_0);                                   
        s4_w[9] <= ((s3_r[8] - s3_r[9]) * img_0)  + ((s3_w[8] - s3_w[9]) * real_0);
        s4_w[11] <= ((s3_r[10] - s3_r[11]) * img_0) + ((s3_w[10] - s3_w[11]) * real_0);                                   
        s4_w[13] <= ((s3_r[12] - s3_r[13]) * img_0) + ((s3_w[12] - s3_w[13]) * real_0);					                      
        s4_w[15] <= ((s3_r[14] - s3_r[15]) * img_0) + ((s3_w[14] - s3_w[15]) * real_0);
    end
end


always @ (posedge clk) begin 
    if(stp_valid || ( (fft_cnt > 0) & (fft_cnt < 6)) ) begin 
        s_r[0] <= {s4_r[0][147], s4_r[0][78:72], s4_r[0][71:64]};
        s_r[1] <= { s4_r[1][147], s4_r[1][78:72], s4_r[1][71:64] };
        s_r[2] <= { s4_r[2][147], s4_r[2][78:72], s4_r[2][71:64] };
        s_r[3] <= { s4_r[3][147], s4_r[3][78:72], s4_r[3][71:64] };
        s_r[4] <= { s4_r[4][147], s4_r[4][78:72], s4_r[4][71:64] };
        s_r[5] <= { s4_r[5][147], s4_r[5][78:72], s4_r[5][71:64] };
        s_r[6] <= { s4_r[6][147], s4_r[6][78:72], s4_r[6][71:64] };
        s_r[7] <= { s4_r[7][147], s4_r[7][78:72], s4_r[7][71:64] };
        s_r[8] <= { s4_r[8][147], s4_r[8][78:72], s4_r[8][71:64] };
        s_r[9] <= { s4_r[9][147], s4_r[9][78:72], s4_r[9][71:64] };
        s_r[10] <= { s4_r[10][147], s4_r[10][78:72], s4_r[10][71:64] };
        s_r[11] <= { s4_r[11][147], s4_r[11][78:72], s4_r[11][71:64] };
        s_r[12] <= { s4_r[12][147], s4_r[12][78:72], s4_r[12][71:64] };
        s_r[13] <= { s4_r[13][147], s4_r[13][78:72], s4_r[13][71:64] };
        s_r[14] <= { s4_r[14][147], s4_r[14][78:72], s4_r[14][71:64] };
        s_r[15] <= { s4_r[15][147], s4_r[15][78:72], s4_r[15][71:64] };
        
        s_w[0] <= { s4_w[0][147] ,s4_w[0][78:72] ,s4_w[0][71:64] }; 
        s_w[1] <= { s4_w[1][147] ,s4_w[1][78:72] ,s4_w[1][71:64] }; 
        s_w[2] <= { s4_w[2][147] ,s4_w[2][78:72] ,s4_w[2][71:64] }; 
        s_w[3] <= { s4_w[3][147] ,s4_w[3][78:72] ,s4_w[3][71:64] }; 
        s_w[4] <= { s4_w[4][147] ,s4_w[4][78:72] ,s4_w[4][71:64] }; 
        s_w[5] <= { s4_w[5][147] ,s4_w[5][78:72] ,s4_w[5][71:64] }; 
        s_w[6] <= { s4_w[6][147] ,s4_w[6][78:72] ,s4_w[6][71:64] };
        s_w[7] <= { s4_w[7][147] ,s4_w[7][78:72] ,s4_w[7][71:64] };
        s_w[8] <= { s4_w[8][147] ,s4_w[8][78:72] ,s4_w[8][71:64] };
        s_w[9] <= { s4_w[9][147] ,s4_w[9][78:72] ,s4_w[9][71:64] };
        s_w[10] <= { s4_w[10][147] ,s4_w[10][78:72] ,s4_w[10][71:64] };
        s_w[11] <= { s4_w[11][147] ,s4_w[11][78:72] ,s4_w[11][71:64] };
        s_w[12] <= { s4_w[12][147] ,s4_w[12][78:72] ,s4_w[12][71:64] };
        s_w[13] <= { s4_w[13][147] ,s4_w[13][78:72] ,s4_w[13][71:64] };
        s_w[14] <= { s4_w[14][147] ,s4_w[14][78:72] ,s4_w[14][71:64] };
        s_w[15] <= { s4_w[15][147] ,s4_w[15][78:72] ,s4_w[15][71:64] };
    end
end

always @ (posedge clk) begin 
    if(stp_valid || ( (fft_cnt > 0) & (fft_cnt < 6)) ) begin 
        fft_d00 <= { s_r[0][15:0], s_w[0][15:0] };
        fft_d08 <= { s_r[1][15:0], s_w[1][15:0] };
        fft_d04 <= { s_r[2][15:0], s_w[2][15:0] };
        fft_d12 <= { s_r[3][15:0], s_w[3][15:0] };
        fft_d02 <= { s_r[4][15:0], s_w[4][15:0] };
        fft_d10 <= { s_r[5][15:0], s_w[5][15:0] };
        fft_d06 <= { s_r[6][15:0], s_w[6][15:0] };
        fft_d14 <= { s_r[7][15:0], s_w[7][15:0] };
        fft_d01 <= { s_r[8][15:0], s_w[8][15:0] };
        fft_d09 <= { s_r[9][15:0], s_w[9][15:0] };
        fft_d05 <= { s_r[10][15:0], s_w[10][15:0] };
        fft_d13 <= { s_r[11][15:0], s_w[11][15:0] };
        fft_d03 <= { s_r[12][15:0], s_w[12][15:0] };
        fft_d11 <= { s_r[13][15:0], s_w[13][15:0] };
        fft_d07 <= { s_r[14][15:0], s_w[14][15:0] };
        fft_d15 <= { s_r[15][15:0], s_w[15][15:0] };
    end
end

endmodule