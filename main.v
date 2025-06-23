module vending_machine(
    input clk,
    input rst,
    input [1:0]in,
    output reg out,
    output reg [1:0] change,
    output reg [1:0] c_state,
    output reg [1:0] n_state
   );

parameter s0 = 2'b00;
parameter s1 = 2'b01;
parameter s2 = 2'b10;

    //reg [1:0] c_state, n_state;

    always @(posedge clk )
      begin
        
        if (rst ==1)
         begin
           c_state =0;
           n_state =0;
           change = 2'b00; 
        end
        else
          c_state = n_state;
        
        case (c_state)
            s0: //state 0 : 0 rs
            if (in == 2'b00)
              begin
                n_state = s0; //stay in state 0
                out = 0; //no item dispensed
                change = 2'b00; //no change
              end 
            else if (in == 2'b01) //5 rs inserted
              begin
                n_state = s1; //move to state 1
                out = 0; //no item dispensed
                change = 2'b00; //no change
              end 
            else if (in == 2'b10) //10 rs inserted
              begin
                n_state = s2; //move to state 2
                out = 0; //no item dispensed
                change = 2'b00; //no change
              end 
            s1: //state 1 : 5 rs
               if (in == 2'b00)
                begin
                    n_state = s0;
                    out = 0; //no item dispensed
                    change = 2'b01; // change returned 5 rs
                end
                else if (in == 2'b01) 
                begin
                    n_state = s2; 
                    out = 0; //no item dispensed
                    change = 2'b00; //no change
                end
                else if (in == 2'b10)
                begin
                    n_state = s0;
                    out = 1; // item dispensed
                    change = 2'b00; //no change
                end
            s2: //state 2 : 10 rs
                if (in == 2'b00)
                begin
                    n_state = s0;
                    out = 0; //no item dispensed
                    change = 2'b10; // change returned 10 rs
                end
                else if (in == 2'b01)
                begin
                    n_state = s0; 
                    out = 1; // item dispensed
                    change = 2'b00; //no change
                end
                else if (in == 2'b10)
                begin
                    n_state = s0; 
                    out = 1; // item dispensed
                    change = 2'b01; // change returned 5rs and one bottle
                end

        endcase
        end
endmodule