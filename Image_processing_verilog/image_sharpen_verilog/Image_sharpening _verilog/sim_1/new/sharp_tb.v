`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.08.2022 18:26:35
// Design Name: 
// Module Name: sharp_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sharp_tb;
    parameter N = 128;
    parameter H = 8;
    parameter M = 11;
    reg clk ;
    reg [H:0] in ;
    wire [M:0] out ;
    //reg [M:0] image_in [N-1:0][N-1:0] ;
    //reg [M:0] image_out [N-1:0][N-1:0] ;
    integer file_read ;
    integer file_write ;
    integer pixel, f;
    
    module_sharp inst(in, out, clk);
    
    initial clk = 1'b0 ;
    
    always clk = #1 ~clk ;
    
    initial
        begin
            file_read = $fopen("D:/xilinx_vivado/assignments/output_v2.txt", "r");
            while( ! $feof(file_read)) begin
                $fscanf(file_read, "%d\n",pixel);
                in = pixel ;
                //$display("%d",pixel);
                #2 ;
            end
            $fclose(file_read);
        end   
        //$writememh("output_v1.txt",image_out[i3][j3] );
    integer i ,j ;
   
    initial begin
        f = $fopen("D:/xilinx_vivado/assignments/output2_v7.txt","w");
        #32772 ;
        for (i = 0; i<N; i=i+1) begin
            for (j = 0; j<N; j=j+1) begin
                $fdisplay(f,"%d\n",out);
                $display("%d %d", i,j );
                #2 ;
            end
        end
        $fclose(f);  
    end
                  
endmodule
