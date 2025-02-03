with Ada.Text_IO;
with Math_Spline;

procedure Spline_gen is

   S_Interval : constant Math_Spline.Spline_Range := (0.0, 3.0);
   S : Math_Spline.Spline;
begin

   S := S.Initialize (S_Interval);
   Math_Spline.Print (S);

end Spline_gen;