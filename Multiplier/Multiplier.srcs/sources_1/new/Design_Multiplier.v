module float_multiplier(
		input [31:0] a,
		input [31:0] b,
		output [31:0] result
		);

wire sign,product_round,normalised,is_zero;
wire [8:0] exponent,sum_exponent;
// We will add 2 8 bit exponents therefore their sum might be greater than 255,therefore 9 bits are assigned
wire [22:0] final_mantissa;
wire [23:0] sfm_a,sfm_b;
//The standard form contains a hidden bit,therefore 24 bits are assigned
wire [47:0] product,product_normalised;
//Multiplication of two 24 bit numbers gives 48 bits
wire Exception,Underflow,Overflow;


assign sign = a[31] ^ b[31];
//0 represents positive,1 represents negative
assign Exception = (&a[30:23]) | (&b[30:23]);
//Checks whether one of the exponents is 255

//Hidden bit=1 if exponent>0, Hidden bit=0 if exponent=0 
assign sfm_a = (|a[30:23]) ? {1'b1,a[22:0]} : {1'b0,a[22:0]};
assign sfm_b = (|b[30:23]) ? {1'b1,b[22:0]} : {1'b0,b[22:0]};

assign product = sfm_a * sfm_b;			
//Mantissa Multiplication

assign product_round = |product_normalised[22:0];  
//Ending 22 bits are OR'ed for rounding operation.

assign normalised = product[47] ? 1'b1 : 1'b0;	
//After mantissa multiplication possible values to the left of decimal point are 01 or 11,if 01 then it is normalised,if 11 then all bits are shifted one bit to the left and 1 is added to final exponent

assign product_normalised = normalised ? product : product << 1;	
// If normalised no shift else it is shifted to the left by one bit

assign final_mantissa = product_normalised[46:24] + (product_normalised[23] & product_round); 
//First 23 bits of the normalised product form the final mantissa and the rounded_product bit is added based on the next bit of the normalised product
  //Last 23 bits of the products are rounded to bring the bits down to 23 using the Reduction Or operator


assign is_zero = Exception ? 1'b0 :(a==32'b0) ? 1'b1: (b==32'b0) ? 1'b1:(final_mantissa == 23'd0 && exponent[8:0]==9'd0) ? 1'b1 : 1'b0;
//assigns 1 is both final mantissa and exponent is 0

assign sum_exponent = a[30:23] + b[30:23];
//Addition of exponents
assign exponent = sum_exponent - 8'd127 + normalised;

assign Overflow = ((exponent[8] & !exponent[7]) & !is_zero) ; 
//Checks overflow condition(exponent>255)(Max possible exponent=384(510-127+1) but since that case is an exception(exponents should not be equal to 255)as described above,it does not occur,therefore any number greater than 255 will start with 10 which is used for checking overflow

assign Underflow = ((exponent[8] & exponent[7]) & !is_zero) ? 1'b1 : 1'b0; 
//Checks underflow condition (exponent<127)(Since we are subtracting bigger number from smaller one,therefore 2's complement representation is used in which the first bit is 1 as resultant is negative )

  assign result = Exception ? 32'd0 :is_zero ? 32'd0 : Overflow ? {sign,8'hFF,23'd0} : Underflow ? 32'd0 : {sign,exponent[7:0],final_mantissa};

//Checks for exceptions,if there are no exceptions assigns the resultant product,exponent=11111111 is assigned for infinity or NaN(not a number))

endmodule