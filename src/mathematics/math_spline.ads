package Math_Spline is

   type Two_Polynomial is array (Natural range 0 .. 2) of Float; -- [t², t, c]
   type Polynomial_Array is array (Positive range 1 .. 3) of Two_Polynomial;
   type Spline_Range is array (Positive range 1 .. 2) of Float;

   type Spline is tagged private;

   function Initialize (S : Spline; S_Interval : Spline_Range) return Spline;

   function Evaluate (S : Spline; t : Float) return Float;
   --  let [a, b] be the spline range. Then,
   --  if t < a : Evaluate => Float (System.Min_Float)
   --  if t > b : Evaluate => Float (System.Max_Float)

   procedure Print (P : Two_Polynomial);

   procedure Print (S : Spline);

private

   function Trunc (x : Float; To : Natural) return Float;

   function Evaluate (P : Two_Polynomial; t : Float) return Float;

   --  The spline is supposed uniform
   type Spline is tagged record

      S_t : Polynomial_Array;
      Interval : Spline_Range;

   end record;

   function Random_Coefficients return Two_Polynomial;

   function Get_Pi_1 (Pi : Two_Polynomial; Knot : Float) return Two_Polynomial;

end Math_Spline;