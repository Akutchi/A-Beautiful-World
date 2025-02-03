with Ada.Text_IO; use Ada.Text_IO;

with Ada.Numerics.Float_Random;
with System;

with GNAT.Formatted_String; use GNAT.Formatted_String;

package body Math_Spline is

   -----------
   -- Trunc --
   -----------

   function Trunc (x : Float; To : Natural) return Float
   is
   begin

      return Float'Truncation (10.0 * Float (To) * x) *
            1.0 / (10.0 * Float (To));

   end Trunc;

   --------------
   -- Evaluate --
   --------------

   function Evaluate (P : Two_Polynomial; t : Float) return Float
   is
      Value : Float := 0.0;

   begin

      for I in P'Range loop
         Value := Value + P (I) * (t ** (2 - I));
      end loop;

      return Value;

   end Evaluate;

   -------------------------
   -- Random_Coefficients --
   -------------------------

   function Random_Coefficients return Two_Polynomial
   is
      P : Two_Polynomial := (0.0, 0.0, 0.0);
      G : Ada.Numerics.Float_Random.Generator;

   begin

      Ada.Numerics.Float_Random.Reset (G);

      for I in 0 .. 2 loop

         P (I) :=
            Trunc (Ada.Numerics.Float_Random.Random (G) * 2.0 - 1.0, To => 2);

      end loop;

      return P;

   end Random_Coefficients;

   --------------
   -- Get_Pi_1 --
   --------------

   function Get_Pi_1 (Pi : Two_Polynomial; Knot : Float) return Two_Polynomial
   is
      Sum : constant Float := Evaluate (Pi, Knot);
      Pi_1 : Two_Polynomial := (0.0, 0.0, 0.0);

   begin

      for I in 0 .. 2 loop
         Pi_1 (I) := Sum / (3.0 * Knot ** (2 - I));
      end loop;

      return Pi_1;

   end Get_Pi_1;

   ----------------
   -- Initialize --
   ----------------

   function Initialize (S : Spline; S_Interval : Spline_Range) return Spline
   is

      a        : constant Float := S_Interval (S_Interval'First);
      b        : constant Float := S_Interval (S_Interval'Last);
      Knot_1   : constant Float := (1.0 / 3.0) * (b - a);
      Knot_2   : constant Float := (2.0 / 3.0) * (b - a);

      P0 : constant Two_Polynomial := Random_Coefficients;
      P1 : constant Two_Polynomial := Get_Pi_1 (P0, Knot_1);
      P2 : constant Two_Polynomial := Get_Pi_1 (P1, Knot_2);

   begin

      return ((P0, P1, P2), S_Interval);

   end Initialize;

   function Evaluate (S : Spline; t : Float) return Float
   is

      a        : constant Float := S.Interval (S.Interval'First);
      b        : constant Float := S.Interval (S.Interval'Last);
      Knot_1   : constant Float := (1.0 / 3.0) * (b - a);
      Knot_2   : constant Float := (2.0 / 3.0) * (b - a);

   begin

      if t < S.Interval (S.Interval'First) then
         return Float (System.Min_Int);

      elsif t > S.Interval (S.Interval'Last) then
         return Float (System.Max_Int);
      end if;

      if t <= Knot_1 then
         return Evaluate (S.S_t (S.S_t'First), t);

      elsif t > Knot_1 and then t <= Knot_2 then
         return Evaluate (S.S_t (S.S_t'First + 1), t);

      end if;

      return Evaluate (S.S_t (S.S_t'Last), t);

   end Evaluate;

   -----------
   -- Print --
   -----------

   procedure Print (P : Two_Polynomial)
   is
         t_sign : constant String := (if P (1) >= 0.0 then "+" else "-");
         c_sign : constant String := (if P (2) >= 0.0 then "+" else "-");

         Format_t2 : Formatted_String := +("%gt² ");
         Format_t : Formatted_String := +(" %gt ");
         Format_c : Formatted_String := +(" %g");

   begin

      Format_t2 := Format_t2 & P (0);
      Format_t := Format_t & abs (P (1));
      Format_c := Format_c & abs (P (2));

      Put_Line ((-Format_t2) & t_sign & (-Format_t) & c_sign & (-Format_c));

   end Print;

   procedure Print (S : Spline)
   is
   begin

      Print (S.S_t (S.S_t'First));
      Print (S.S_t (S.S_t'First + 1));
      Print (S.S_t (S.S_t'Last));

   end Print;

end Math_Spline;