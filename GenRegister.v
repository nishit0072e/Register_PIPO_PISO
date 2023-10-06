`timescale 1ns / 1ps

//PIPO

module GenRegister(
    input clkIn,
    output clkOut,
    input [7:0] regIn,
    output [7:0] regOut,
    input bitIn,
    input shift,
    output bitOut
    );
    reg [27:0] counter=0;
    reg flag=0;
    reg [7:0]data=0;// for parallel output
    reg [7:0]data1=0;// for serial output
    
    //always@(regIn)begin //Data copy when input changes
    //    data=regIn;
    //end
    
    always@(posedge clkIn)begin //Clock Divider
    
    if(shift==1)begin
        data1=data;
    end
    
    counter = counter + 1;
    if(counter==100000000)begin
        counter = 0;
        flag = !flag;
        
        if(data!=regIn) //Data ressignment
                data=regIn;
                
        if(flag==1)begin
                        
            data1=data1>>1;
        end
    end
              
    end
    
    //always@(posedge flag)begin //Data right shift when flag triggers
        
    //    data=data>>1;
    //end
    
    assign regOut = data; // links variable to output
    assign clkOut = flag;
    assign bitOut = data1[0]; 
    
endmodule
