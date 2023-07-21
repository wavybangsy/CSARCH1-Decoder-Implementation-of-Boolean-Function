//Culala, Mary Erika L. | S14

`timescale 1ns / 1ps

module YCulM(En,F,A,B,C,D);
    input En, A, B, C, D;
    output reg F;
    wire CO0, CO1, CO2, CO3, O0, O1, O2, O3, O4, O5, O6, O7, O8, O9, O10, O11, O12, O13, O14, O15;
    wire NO1, NO2, NO3, NO4, NO5, NO6, FD;

    DCD_2x4 D1(En, A, B, CO0, CO1, CO2, CO3);
    DCD_2x4 D2(CO0, C, D, O0, O1, O2, O3);
    DCD_2x4 D3(CO1, C, D, O4, O5, O6, O7);
    DCD_2x4 D4(CO2, C, D, O8, O9, O10, O11);
    DCD_2x4 D5(CO3, C, D, O12, O13, O14, O15);

    OUT G1(FD, O4, O6, O7, O8, O10, O11);

    always @*
    begin
        case(En)
            1: F = FD;
            0: F = 1'bZ; 
        endcase
    end
endmodule

module DCD_2x4(En, In0, In1, O0, O1, O2, O3);
    input En, In0, In1;
    output O0, O1, O2, O3;

    assign O0 = (En& ~In0& ~In1);
    assign O1 = (En& ~In0& In1);
    assign O2 = (En& In0& ~In1);
    assign O3 = (En& In0& In1);   
endmodule

module OUT(D, O1, O2, O3, O4, O5, O6);
    input O1, O2, O3, O4, O5, O6;
    wire NO1, NO2, NO3, NO4, NO5, NO6, L;
    output D;

    // Negative Output
    not (NO1, O1);
    not (NO2, O2);
    not (NO3, O3);
    not (NO4, O4);
    not (NO5, O5);
    not (NO6, O6);

    // NAND
    and (L, NO1, NO2, NO3, NO4, NO5, NO6);
    not (D, L);

endmodule


