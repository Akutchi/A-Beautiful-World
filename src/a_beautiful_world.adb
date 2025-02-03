with Gtk.Main;  use Gtk.Main;

with Generation;     use Generation;

with Image_IO;
with Image_IO.Holders;
with Image_IO.Operations;

with Main_Windows;
with Canvas;
with Constants;
with Math_Spline;

procedure a_beautiful_world is

   package IIO renames Image_IO;
   package IIO_H renames Image_IO.Holders;
   package IIO_O renames Image_IO.Operations;

   package M_S renames Math_Spline;

   Win           : Main_Windows.Main_Window;
   Main_Canvas   : Canvas.Image_Canvas;

   Img : IIO_H.Handle;
   X, Y : Natural := 0;
   Iteration : Boolean;

begin

   Generate_Baseline;
   Generate_Hills_Model;
   Generate_Deep_Ocean_Model;
   Generate_Biomes;

   IIO_O.Read (Constants.Map_Destination, Img);

   declare
         Data : constant IIO.Image_Data := Img.Value;
   begin

      Init;

      Main_Windows.Gtk_New (Win);

      Canvas.Gtk_New (Main_Canvas);
      Canvas.Initial_Setup (Main_Canvas);
      Canvas.Realize (Main_Canvas);

      Main_Windows.Add (Win, Main_Canvas);
      Main_Windows.Show_All (Win);

      Y := 100;

      loop

         Canvas.Shift_Pixel (Main_Canvas, X, Y, Constants.Black, Data);
         Iteration := Main_Iteration_Do (Blocking => False);
         delay 0.05;

      end loop;
   end;

end a_beautiful_world;
