with Ada.Text_IO; use Ada.Text_IO;

with GNAT.Semaphores; use GNAT.Semaphores;
procedure Lr4 is
   type Mas is array (1..5) of Integer;
   arr : Mas := (0,0,0,0,0);
   --arr : array(1..5) of Integer := (0,0,0,0,0);
   function Max_Eating (arr: in Mas) return Integer is
      max : Integer := arr(1);
      id : Integer := 1;
   begin
      for I in 1..arr'Length loop
         if max < arr(i) then
            max := arr(i);
            id := i;
         end if;
      end loop;
      return id;
   end Max_Eating;

task type Phylosopher is
      entry Start(Id : Integer);
   end Phylosopher;

   Forks : array (1..5) of Counting_Semaphore(1, Default_Ceiling);
   Waiter : Counting_Semaphore(1,Default_Ceiling);

   task body Phylosopher is
      Id : Integer;
      Id_Left_Fork, Id_Right_Fork : Integer;
   begin
      accept Start (Id : in Integer) do
         Phylosopher.Id := Id;
      end Start;
      Id_Left_Fork := Id;
      Id_Right_Fork := Id rem 5 + 1;

      for I in 1..2 loop

         Put_Line("Phylosopher " & Id'Img & " thinking " & I'Img & " time");
         if id = Max_Eating(arr) then
            Waiter.Release;
         else
         Waiter.Seize;
         Forks(Id_Left_Fork).Seize;

         Put_Line("Phylosopher " & Id'Img & " took left fork");

         Forks(Id_Right_Fork).Seize;

         Put_Line("Phylosopher " & Id'Img & " took right fork");

         Put_Line("Phylosopher " & Id'Img & " eating" & I'Img & " time");
         arr(id) := i;
         Waiter.Release;
         Forks(Id_Right_Fork).Release;

         Put_Line("Phylosopher " & Id'Img & " put right fork");

         Forks(Id_Left_Fork).Release;

            Put_Line("Phylosopher " & Id'Img & " put left fork");
         end if;
      end loop;
   end Phylosopher;

   Phylosophers : array (1..5) of Phylosopher;
Begin
   for I in Phylosophers'Range loop
      Phylosophers(I).Start(I);
   end loop;
end Lr4;
