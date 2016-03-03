

with Ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with ada.strings.unbounded; use ada.strings.unbounded;
with ada.strings.unbounded.Text_IO; use ada.strings.unbounded.Text_IO;
with stack; use stack;


procedure sudoku is
	op : character;
	--filename : string(1..50);
	--last : natural;
	infp : file_type;
	outfp : file_type;
	str : character;
	count: integer:=1;
	type grid is array(1..9,1..9) of integer;
	puzle_grid:grid;
	type num_array is array(1..81 ) of integer;
	puzle_array:num_array;
	index:integer:=1;



-- sudoku 
--recursive function 
function recur_sudoku(puzle_grid: grid; 
						row:integer; 
					column:integer)return Integer is
	pos: integer ;
	begin
		--loop
		--end loop;
		return 1;
end recur_sudoku;


	-- check if value is valid at pos on puzle grid
	function valid (puzle_grid: grid; 
						row:integer;
					column:integer;
					val:integer)return Integer is

	begin
		-- check current row
		-- check current column
		for i in 1..9 loop
			if puzle_grid(i,column) = val then return 0; end if;
			if puzle_grid(row,i) = val then return 0; end if;
		end loop;
		
		-- check current box
		--loop
		--end loop;
		return 1;
	end valid;



	procedure polulate_grid (puzle_array: in num_array; 
								puzle_grid:in out grid) is	
		index: integer:=1;
		begin
		for row in 1..9 loop
			for column in 1..9 loop
				puzle_grid(row,column) := puzle_array(index);
				index := index +1;
			end loop;
		end loop;
	end polulate_grid;
		
	--print puzle given puzle grid 
	procedure put_puzle (puzle_grid:in grid) is	
		begin
		for row in 1..9 loop
		if row = 1 or row =4 or row=7  then
			put(" +-------+-------+-------+");
			new_line;
		end if;
			
		for column in 1..9 loop
			if column = 1 or column =4 or column=7  then
				put(" |");
			end if;
					
			put( puzle_grid(row,column),width =>2);
				
			if column=9 then
				put(" | ");
				new_line;
			end if;
		end loop;
		
		if row = 9 then
			put(" +-------+-------+-------+");
			new_line;
		end if;
		
	end loop;
	end put_puzle;				

begin
		-- get filename
	--	put("enter full name of sudoku file: ");
	--	get_line(filename, last);
	--	put_line(filename);

		-- open file and read content put into array	
	--open (infp,in_file,filename(1..last));
	open (infp,in_file,"file.txt");
	puzle_array:= (1..81 => 0);
	loop
		exit when end_of_file(infp);
		get(infp,str);
		--put(count); put(" "); put(str); 
		-- convert ascii value to actual value 
		puzle_array(count) := Character'Pos(str)-48;
		count := count +1;
	end loop;

	close(infp);

	--create and output to file
	create (outfp, out_file, "results.txt");
	--if is_open(outfp) then
		--set_output(outfp);
		--close(outfp);
	--end if;

	--set_output(standard_output);


	-- polulate puzzle grid

--	for row in 1..9 loop
--		for column in 1..9 loop
--			puzle_grid(row,column) := puzle_array(index);
--			index := index +1;
--		end loop;
--	end loop;
		
	polulate_grid (puzle_array=>puzle_array, puzle_grid=>puzle_grid);
	put_puzle(puzle_grid => puzle_grid);


	
	-- print puzzle
	new_line;
	for row in 1..9 loop
		if row = 1 or row =4 or row=7  then
			put(" +-------+-------+-------+");
			new_line;
		end if;
			
		for column in 1..9 loop
			if column = 1 or column =4 or column=7  then
				put(" |");
			end if;
					
			put( puzle_grid(row,column),width =>2);
				
			if column=9 then
				put(" | ");
				new_line;
			end if;
		end loop;
		
		if row = 9 then
			put(" +-------+-------+-------+");
			new_line;
		end if;
		
	end loop;




	push('c');
	push('a');
	push('f');
	pop(op);
	put(op);
	
	pop(op);
	put(op);
	
	pop(op);
	put(op);
	put(op);
	
	
end sudoku;
