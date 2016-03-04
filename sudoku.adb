

with Ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with ada.strings.unbounded; use ada.strings.unbounded;
with ada.strings.unbounded.Text_IO; use ada.strings.unbounded.Text_IO;
with stack; use stack;



------------------------------------------------------------- 	
---Procedure: Sudoku puzzle solver main procedure
-------------------------------------------------------------
procedure sudoku is
	outfp : file_type;
	type grid is array(1..9,1..9) of integer;
	puzzle_grid:grid;
	type num_array is array(1..81 ) of integer;
	puzzle_array:num_array;
	a,b,c : integer;


	------------------------------------------------------------- 	
	---Procedure: Open File, parse and put into number array 
	-------------------------------------------------------------
	procedure open_file(puzzle_array: out num_array) is
		filename : string(1..50);
		last : natural;
		infp : file_type;
		str : character;
		count: integer:=1;
	begin
		put("enter full name of sudoku file: ");
		--get_line(filename, last);
		--open (infp,in_file,filename(1..last));
		open (infp,in_file,"file.txt");
		
		new_line;
		loop exit when end_of_file(infp);
			get(infp,str);
			-- make sure only ascii numbers values are put into array
			if(Character'Pos(str) in  48..57) then 
				puzzle_array(count) := Character'Pos(str)-48;  --ascii to num
				count := count +1;
			end if;
			
			if (count=81) then exit; end if;
		end loop;
		
		if count /= 81 then           --err if array not full 
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
		index: integer:=1;
	begin
		for row in 1..9 loop
			for col in 1..9 loop
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
		for row in 1..9 loop
			if row = 1 or row =4 or row=7  then
				put(" +-------+-------+-------+");
				new_line;
			end if;
				
			for col in 1..9 loop
				if col = 1 or col =4 or col=7  then put(" |"); end if;
				put( puzzle_grid(row,col),width =>2);
				if col=9 then put(" | "); new_line; end if;
			end loop;
			
			if row = 9 then
				put(" +-------+-------+-------+"); new_line;
			end if;	
		end loop;
	end put_puzzle;	
	
	------------------------------------------------------------- 	
	---Function: check if value is valid at pos on puzzle grid
	-------------------------------------------------------------
	function valid (puzzle_grid: grid; row:integer;
					col:integer; val:integer) return boolean is
	boxrow,boxcol: integer;
	begin
		-- check applicable rows and columns 
		for i in 1..9 loop
			if puzzle_grid(i,col) = val then return false; end if;
			if puzzle_grid(row,i) = val then return false; end if;
		end loop;
		
		-- check current box 
		boxrow := (row/3)*3;
		boxcol := (col/3)*3;	
		for r in 1..3 loop
			for c in 1..3 loop
				put(r+boxrow);
				put(c+boxcol);
				put(puzzle_grid((r+boxrow),(c+boxcol))); new_line;
				if (puzzle_grid((r+boxrow),(c+boxcol)) = val) then
					return false;
				end if ;
			end loop;
		end loop;
		
		return true;
	end valid;

	------------------------------------------------------------- 	
	---Function: recursive 
	-------------------------------------------------------------
	function recur_sudoku(puzzle_grid : grid; row : integer; 
								 col:integer)return Integer is
		pos: integer ;
		begin
			--loop
			--end loop;
			return 1;
	end recur_sudoku;			


begin
		-- get filename
	--	put("enter full name of sudoku file: ");
	--	get_line(filename, last);
	--	put_line(filename);

		-- open file and read content put into array	
	--open (infp,in_file,filename(1..last));
--	open (infp,in_file,"file.txt");
--	puzzle_array:= (1..81 => 0);
--	loop
--		exit when end_of_file(infp);
--		get(infp,str);
		--put(count); put(" "); put(str); 
		-- convert ascii value to actual value 
--		puzzle_array(count) := Character'Pos(str)-48;
--		count := count +1;
--	end loop;
--
--	close(infp);

	--create and output to file
--	create (outfp, out_file, "results.txt");
	--if is_open(outfp) then
		--set_output(outfp);
		--close(outfp);
	--end if;

	--set_output(standard_output);

	open_file(puzzle_array =>puzzle_array);
	polulate_grid (puzzle_array=>puzzle_array, puzzle_grid=>puzzle_grid);
	put_puzzle(puzzle_grid => puzzle_grid);


	


a :=4;
b :=4;
c :=2;


if (valid (puzzle_grid=>puzzle_grid, 
						row=>a,
					col=>b,
				val=>c) ) then 
				
				puzzle_grid(a,b):=c;
				put_puzzle(puzzle_grid);
				put ("test");
		end if;
					
					



	
end sudoku;
