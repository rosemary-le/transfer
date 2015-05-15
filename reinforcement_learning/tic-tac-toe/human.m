function move = human(board_all, player)

move = [-1 -1];
if (player < 0), 
	return; 
end;

n = size(board_all, 3);
board = squeeze(board_all(:,:,n));

while (move == [-1 -1]),
	move = round(ginput(1));

	if (move(1) < 1 || move(1) > 3),
		move = [-1 -1];
		continue;
	end;

	if (move(2) < 1 || move(1) > 3),
		move = [-1 -1];
		continue;
	end;

	if ( board(move(1),move(2)) ~= 0),
		move = [1 -1];
		continue;
	end;
end;
