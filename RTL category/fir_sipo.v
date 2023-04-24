module fir_sipo(
    input fir_valid , clk , rst,
    input [15:0] fir_d,

    output reg fir_valid_p,
    output reg [15:0] fir_d_p
);

always @ (posedge clk) begin 
    if(rst) begin 
        fir_valid_p <= 0;
        fir_d_p <= 0;
    end else begin 
        fir_valid_p <= fir_valid;
        fir_d_p <= fir_d;
    end
end

endmodule