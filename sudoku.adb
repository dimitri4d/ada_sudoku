with Ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with ada.strings.unbounded; use ada.strings.unbounded;
with ada.strings.unbounded.Text_IO; use ada.strings.unbounded.Text_IO;


------------------------------------------------------------- 	
---Procedure: Sudoku puzzle solver main procedure
-------------------------------------------------------------
procedure sudoku is
	outfp : file_type;
	type grid is array(0..8,0..8) of integer;
	puzzle_grid:grid;
	type num_array is array(0..80 ) of integer;
	puzzle_array:num_array;
	sol : integer;

	------------------------------------------------------------- 	
	---Procedure: Open File, parse and put into number array 
	-------------------------------------------------------------
	procedure open_file(puzzle_array: out num_array) is
		filename : string(1..50);
		last : natural;
		infp : file_type;
		str : character;
		count: integer:=0;
	begin
		put("enter full name of sudoku file: ");
		get_line(filename, last);
		open (infp,in_file,filename(1..last));
		
		new_line;
		loop exit when end_of_file(infp);
			get(infp,str);
			-- make sure only ascii numbers values are put into array
			if(Character'Pos(str) in  48..57) then 
				puzzle_array(count) := Character'Pos(str)-48;  --ascii to num
				count := count +1;
			end if;
			if (count=80) then exit; end if;
		end loop;
		
		if count /= 80 then           --err if array not full 
		put ("There was an error in read file !");
		raise data_error;
		end if;
		close(infp);
	end open_file;

	------------------------------------------------------------- 	
	---Procedure: populate puzzle 2d array given number array
	-------------------------------------------------------------
	procedure polulate_grid (puzzle_array: in num_array; 
								puzzle_grid:in out grid) is	
		index: integer:=0;
	begin
		for row in 0..8 loop
			for col in 0..8 loop
				puzzle_grid(row,col) := puzzle_array(index);
				index := index +1;
			end loop;
		end loop;
	end polulate_grid;
	
	------------------------------------------------------------- 	
	---Procedure: print out formated puzzle given puzzle 2d array
	------------------------------------------------------------- 
	procedure put_puzzle (puzzle_grid:in grid) is	
	begin
		for row in 0..8 loop
			if row = 0 or row =3 or row=6  then
				put(" +-------+-------+-------+");
				new_line;
			end if;
				
			for col in 0..8 loop
				if col = 0 or col =3 or col=6  then put(" |"); end if;
				put( puzzle_grid(row,col),width =>2);
				if col=8 then put(" | "); new_line; end if;
			end loop;
			
			if row = 8 then
				put(" +-------+-------+-------+"); new_line;
			end if;	
		end loop;
	end put_puzzle;	
	
	------------------------------------------------------------- 	
	---Function: check if value is valid at pos on puzzle grid
	-------------------------------------------------------------
	function valid (puzzle_grid: grid; row,col,val:integer) return boolean is
		boxrow,boxcol,row1,row2,col1,col2: integer;
	begin
		-- check applicable rows and columns 
		for i in 0..8 loop
			if puzzle_grid(i,col) = val then 
				return false; 
			elsif puzzle_grid(row,i) = val then 
			return false; end if;
		end loop;
		
		-- check applicable box 
		boxrow := (row/3)*3;
		boxcol := (col/3)*3;
		row1 := (row + 2) rem 3;
    	row2 := (row + 4) rem 3;
    	col1 := (col + 2) rem 3;
    	col2 := (col + 4) rem 3;
		
		if puzzle_grid(row1+boxrow,col1+boxcol) = val then
    		return false;
    	elsif puzzle_grid(row2+boxrow,col1+boxcol) = val then
    		return false;
   		elsif puzzle_grid(row1+boxrow,col2+boxcol) = val then
   			return false;
   		elsif puzzle_grid(row2+boxrow,col2+boxcol) = val then
   			return false;
   		end if;
		
		return true;
	end valid;
	
	------------------------------------------------------------- 	
	---Function: solve puzzle using recursion 
	-------------------------------------------------------------
	procedure solve_puzzle(puzzle_grid:in out grid; row,col:in integer; sol: out integer)
	 is
	over : integer;
	begin
		-- game complete, solution true
		if row = 9 then 
			sol := 1; 
			return;
		end if;
		
		-- check if position already filled? onto next cell
		if (puzzle_grid(row,col) /=0) then
			if(col = 8) then
				solve_puzzle(puzzle_grid, row+1, 0,over);
				if over = 1 then sol := 1; return; end if;
			else
				solve_puzzle(puzzle_grid, row, col+1, over);
				if over = 1 then sol := 1; return; end if;
			end if;
			sol := 0;
			return;
		end if;
		
		-- loop through possible numbers, 
		--recurse for for valid ones to check if part of solution
		for index in 1..9 loop
			if (valid(puzzle_grid,row,col,index) ) then 
				
				puzzle_grid(row,col) := index;
				put(index);put(row+1);put(col+1);new_line;
				--put_puzzle(puzzle_grid);
				if(col = 8) then
					solve_puzzle(puzzle_grid,row+1,0,over);
					if over = 1 then sol := 1;
						return; 
					end if;
				else
					solve_puzzle(puzzle_grid,row,col+1,over);
					if over = 1 then sol := 1;
						return; 
					end if;
				end if;
				puzzle_grid(row,col):=0;
			end if;		
		end loop;	
	end solve_puzzle;			

	------------------------------------------------------------- 	
	---Procedure: Write results to file 
	-------------------------------------------------------------
	procedure write_file(puzzle_grid: in grid) is
		filename : string(1..50);
		last : natural;
		outfp : file_type;
	begin
		put("enter file name to output results ");
		get_line(filename, last);
		create (outfp,out_file,filename(1..last));
		set_output(outfp);
		put_puzzle(puzzle_grid);
		close(outfp);
	end write_file;

begin	
	open_file(puzzle_array =>puzzle_array);
	polulate_grid (puzzle_array=>puzzle_array, puzzle_grid=>puzzle_grid);
	put_puzzle(puzzle_grid => puzzle_grid);
	solve_puzzle(puzzle_grid, 0, 0, sol);
	put_puzzle(puzzle_grid);
	write_file(puzzle_grid);
end sudoku;
