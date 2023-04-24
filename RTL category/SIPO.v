module SIPO (clk, rst, fir_valid, fir_d, stp_valid,
po_0, po_1, po_2, po_3, po_4, po_5, po_6, po_7, 
po_8, po_9, po_10, po_11, po_12, po_13, po_14, po_15);

input clk, rst;
input fir_valid;
input signed [15:0] fir_d;
output reg stp_valid;
output  signed [15:0] po_0, po_1, po_2, po_3, po_4, po_5, po_6, po_7, 
                    po_8, po_9, po_10, po_11, po_12, po_13, po_14, po_15;
                    
reg [5:0] sipo_cnt;
reg [15:0] DFF[15:0];


assign po_0 = DFF[0];
assign po_1 = DFF[1];
assign po_2 = DFF[2];
assign po_3 = DFF[3];
assign po_4 = DFF[4];
assign po_5 = DFF[5];
assign po_6 = DFF[6];
assign po_7 = DFF[7];
assign po_8 = DFF[8];
assign po_9 = DFF[9];
assign po_10 = DFF[10];
assign po_11 = DFF[11];
assign po_12 = DFF[12];
assign po_13 = DFF[13];
assign po_14 = DFF[14];
assign po_15 = DFF[15];

always @ (posedge clk) begin 
    if(rst) begin 
        sipo_cnt <= 0;
    end else begin 
        if(fir_valid) begin 
            if(sipo_cnt >= 15) begin 
                sipo_cnt <= 0;
            end else begin 
                sipo_cnt <= sipo_cnt + 1; 
            end
        end
    end
end

always @ (posedge clk) begin 
    if(rst) begin 
        stp_valid <= 0;
    end else begin 
        if(fir_valid) begin 
            if(sipo_cnt >= 15) begin 
                stp_valid <= 1;
            end else begin 
                stp_valid <= 0;
            end
        end
    end
end


always @ (posedge clk) begin 
    if(rst) begin 
        DFF[0] <= 0;
        DFF[1] <= 0;
        DFF[2] <= 0;
        DFF[3] <= 0;
        DFF[4] <= 0;
        DFF[5] <= 0;
        DFF[6] <= 0;
        DFF[7] <= 0;
        DFF[8] <= 0;
        DFF[9] <= 0;
        DFF[10] <= 0;
        DFF[11] <= 0;
        DFF[12] <= 0;
        DFF[13] <= 0;
        DFF[14] <= 0;
        DFF[15] <= 0;
    end else begin 
        if(fir_valid) begin 
            DFF[15] <= fir_d;
            DFF[14] <= DFF[15];
            DFF[13] <= DFF[14];
            DFF[12] <= DFF[13];
            DFF[11] <= DFF[12];
            DFF[10] <= DFF[11];
            DFF[9] <= DFF[10];
            DFF[8] <= DFF[9];
            DFF[7] <= DFF[8];
            DFF[6] <= DFF[7];
            DFF[5] <= DFF[6];
            DFF[4] <= DFF[5];
            DFF[3] <= DFF[4];
            DFF[2] <= DFF[3];
            DFF[1] <= DFF[2];
            DFF[0] <= DFF[1];
        end
    end
end


endmodule