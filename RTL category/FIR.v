`timescale 1ns/10ps
module FIR(
           data_valid, 
           data, 
           clk, 
           rst,
           fir_valid,
           fir_d);

input             data_valid;
input      [15:0] data;
input             clk;
input             rst;
output            fir_valid;
output     [15:0] fir_d;

parameter signed [14:0] FIR_C00 = 15'h7F9E ;     //The FIR_coefficient value 0: -1.495361e-003
parameter signed [14:0] FIR_C01 = 15'h7F86 ;     //The FIR_coefficient value 1: -1.861572e-003
parameter signed [14:0] FIR_C02 = 15'h7FA7 ;     //The FIR_coefficient value 2: -1.358032e-003
parameter signed [14:0] FIR_C03 = 15'h003B ;    //The FIR_coefficient value 3: 9.002686e-004
parameter signed [14:0] FIR_C04 = 15'h014B ;    //The FIR_coefficient value 4: 5.050659e-003
parameter signed [14:0] FIR_C05 = 15'h024A ;    //The FIR_coefficient value 5: 8.941650e-003
parameter signed [14:0] FIR_C06 = 15'h0222 ;    //The FIR_coefficient value 6: 8.331299e-003
parameter signed [14:0] FIR_C07 = 15'h7FE4 ;     //The FIR_coefficient value 7: -4.272461e-004
parameter signed [14:0] FIR_C08 = 15'h7BC5 ;     //The FIR_coefficient value 8: -1.652527e-002
parameter signed [14:0] FIR_C09 = 15'h77CA ;     //The FIR_coefficient value 9: -3.207397e-002
parameter signed [14:0] FIR_C10 = 15'h774E ;     //The FIR_coefficient value 10: -3.396606e-002
parameter signed [14:0] FIR_C11 = 15'h7D74 ;     //The FIR_coefficient value 11: -9.948730e-003
parameter signed [14:0] FIR_C12 = 15'h0B1A ;    //The FIR_coefficient value 12: 4.336548e-002
parameter signed [14:0] FIR_C13 = 15'h1DAC ;    //The FIR_coefficient value 14: 1.159058e-001
parameter signed [14:0] FIR_C14 = 15'h2F9E ;    //The FIR_coefficient value 14: 1.860046e-001
parameter signed [14:0] FIR_C15 = 15'h3AA9 ;    //The FIR_coefficient value 14: 2.291412e-001

reg signed [15:0] data_r;
reg        [23:0] dat1       [0:15];
reg        [23:0] dat2       [0:15];
wire       [29:0] mul        [0:15];
wire       [23:0] w_out;
reg               fir_valid;
reg        [5:0]  cnt;
integer       i;

assign mul[0]  = data_r * FIR_C00;
assign mul[1]  = data_r * FIR_C01;
assign mul[2]  = data_r * FIR_C02;
assign mul[3]  = data_r * FIR_C03;
assign mul[4]  = data_r * FIR_C04;
assign mul[5]  = data_r * FIR_C05;
assign mul[6]  = data_r * FIR_C06;
assign mul[7]  = data_r * FIR_C07;
assign mul[8]  = data_r * FIR_C08;
assign mul[9]  = data_r * FIR_C09;
assign mul[10] = data_r * FIR_C10;
assign mul[11] = data_r * FIR_C11;
assign mul[12] = data_r * FIR_C12;
assign mul[13] = data_r * FIR_C13;
assign mul[14] = data_r * FIR_C14;
assign mul[15] = data_r * FIR_C15;


always @(posedge clk) begin
    if (~data_valid) data_r <= 16'b0;
    else data_r <= data;
end

always @(posedge clk) begin
    if (~data_valid) begin
        for (i = 0; i < 16; i = i + 1) begin
            dat1[i] <= 24'b0;
        end
    end else begin
        dat1[0][23:22] <= {2{mul[0][29]}};
        dat1[0][21:0]  <= mul[0][29:8];
        for (i = 1; i < 16; i = i + 1) begin
            dat1[i] <= dat1[i - 1] + {{2{mul[i][29]}}, mul[i][29:8]};
        end
    end
end

always @(posedge clk) begin
    if (~data_valid) begin
        for (i = 0; i < 16; i = i + 1) begin
            dat2[i] <= 24'b0;
         end
    end else begin
        dat2[15] <= dat1[15] + {{2{mul[15][29]}}, mul[15][29:8]};
        for (i = 0; i < 15; i = i + 1) begin
            dat2[i] <= dat2[i + 1] + {{2{mul[i][29]}}, mul[i][29:8]};
        end
    end
end

assign fir_d = dat2[0][23:8] + dat2[0][23];

always @(posedge clk) begin
    if (~data_valid) cnt <= 6'b0;
    else cnt <= cnt + 6'b1;
end

always @(posedge clk) begin
    if (rst) begin 
        fir_valid <= 1'b0;
    end else begin 
        if(cnt > 31) begin 
            fir_valid <= 1;
        end
    end 
end

endmodule
