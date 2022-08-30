`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.08.2022 22:24:18
// Design Name: 
// Module Name: top_dip
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


module top_dip( in, out , clk);
    parameter N = 128;
    parameter M = 8;
    input clk ;
    input [M:0]in;
    output reg[M:0]out;
    reg [M:0] image_in [N-1:0][N-1:0] ;
    reg [M:0] image_in2 [N+1:0][N+1:0] ;
    reg [M:0] image_out [N-1:0][N-1:0] ;
    
    reg [2:0]prc = 0;
    reg [2:0]prc1 = 0;
    reg load = 1 ;
    
    integer i = 0 ;
    integer j = 0 ;
    
    // image loading 
    always @ (posedge clk ) begin
        if (load == 1) begin  
            if ( (i < N) && ~( i==N-1 && j==N ) ) begin
                if ( j < N) begin
                    image_in[i][j] = in ;
                    //$display("image[%d][%d]: %d",i,j,in);
                    j = j+1 ;
                end else begin
                    j = 0;
                    image_in[i+1][0] = in ;
                    i = i+1 ;
                    //$display("image[%d][%d]: %d",i,j,in);
                    j = j+1 ;
                end
            end else begin
                j = 0 ;
                i = 0;
                prc = 1;
                load = 0 ;
            end
        end
    end 
    
    // padding 
    integer i1,i2,j1 ;
    always @(prc) begin
        if (prc == 1) begin
            for (i1 = 0; i1<N ; i1=i1+1) 
                for (j1 = 0; j1<N ; j1 = j1+1) begin
                    image_in2[i1+1][j1+1] = image_in[i1][j1] ;
                end
            for (i2 = 0; i2<N+2 ; i2=i2+1) begin 
                 image_in2[i2][0] = 0 ;
                 image_in2[i2][N+1] = 0 ;
                 image_in2[0][i2] = 0 ;
                 image_in2[N+1][i2] = 0 ;
            end
            //$display("%d", prc);
            prc1 = 2 ; 
            //$display("%d", prc);
        end
    end
     
    //real multiply = 0.111111 ;
    
    integer i3,j3,c3,d3;
    reg [2*M-1:0]sum ;
    wire [M-1:0]factor = 8'b0001_1100 ;
    always @(prc1) begin
        if (prc1 == 2) begin 
            for ( i3 = 0; i3<N ; i3=i3+1) begin
                for ( j3 = 0; j3<N ; j3=j3+1) begin
                    sum = 0;
                    for ( c3 = 0; c3<3 ; c3 = c3+1) begin
                        for ( d3 = 0 ; d3<3 ; d3 =d3+1) begin 
                            sum = sum + image_in2[c3+i3][d3+j3];
                        end 
                    end
                    sum = sum*factor ;
                    image_out[i3][j3] = sum>>8 ;  
                    #2 out = sum>>8 ; 
                end  
                //$writememh("output_v1.txt",);
            end
            //prc = 3;                  
        end
    end 
    

    
endmodule
