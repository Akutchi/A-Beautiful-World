with Math_Spline;

procedure Spline_gen is

   S_Interval : Math_Spline.Spline_Range := (0.0, 3.0);

   P0 : constant Math_Spline.Two_Polynomial := Math_Spline.Random_Coefficients;
   P1 : constant Math_Spline.Two_Polynomial := Math_Spline.Get_Pi_1 (P0, 1.0);
   P2 : constant Math_Spline.Two_Polynomial := Math_Spline.Get_Pi_1 (P1, 2.0);

   S : Math_Spline.Spline := (S_t => (P0, P1, P2), Interval => S_Interval);

begin

   Math_Spline.Print (S);

end Spline_gen;