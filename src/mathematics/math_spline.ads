package Math_Spline is

   type Two_Polynomial is array (Natural range 0 .. 2) of Float; -- [t², t, c]
   type Polynomial_Array is array (Positive range 1 .. 3) of Two_Polynomial;
   type Spline_Range is array (Positive range 1 .. 2) of Float;

   --  The spline is supposed uniform
   type Spline is record

      S_t : Polynomial_Array;
      Interval : Spline_Range;

   end record;

   function Random_Coefficients return Two_Polynomial;

   function Get_Pi_1 (Pi : Two_Polynomial; Knot : Float) return Two_Polynomial;

   procedure Print (P : Two_Polynomial);

   procedure Print (S : Spline);

private

   function Trunc (x : Float; To : Natural) return Float;

end Math_Spline;