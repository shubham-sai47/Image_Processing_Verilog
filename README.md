# Image_Processing_Verilog
Parameterized Verilog code for Image Sharpening (Laplacian Filter) and Image smoothening (Average Filter) on 128x128 image


This was done as a part of the following assignment ---->

Q1
Design an Image Enhancement hardware in Verilog. 

You have to design and test all the individual block
The image size is 128 X 128. Each pixel of the image is of 8 bits.
Please note input/output cannot be an array. So Input in this case will be a vector of 131072 (128*128*8 ) bits which is then to be converted into a two dimensional matrix inside the module. For Image Smoothening use a 3 X 3 Average Filter .For Image Sharpening use a 3 X 3 Laplacian Kernel. Make sure that you are handling negative numbers properly.

Both Image Smoothening and Image sharpening is a convolution operation in the image as shown below.

![alt-text](https://github.com/shubham-sai47/Image_Processing_Verilog/blob/main/Image_processing_verilog/2D_Convolution_Animation.gif?raw=true)

The addition is of sharpened and Enhanced Image is to be performed.
Finally, the image pixels have to be normalized between 0 to 255 to get the final enhanced image.
