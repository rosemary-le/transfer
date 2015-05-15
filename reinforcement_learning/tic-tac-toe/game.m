function outcome = game(p1_hdl, p2_hdl, draw)
% OUTCOME = GAME(PLAYER1_FUN, PLAYER2_FUN)
% Runs a single game of tic-tac-toe
%
% PLAYER1_FUN and PLAYER2_FUN are function handles that
% take 3x3 board state, player number (1 or 2) and return 
% 2x1 move position. Board state is composed of 1, 2, or
% 0 at each of the 3x3 positions.
%

board = zeros(3,3,1);
p = 1;
n = 1;
if (draw)
	draw_board(board);
end;
while ( end_state(board) == -1 ),
	if (p == 1),
		m = p1_hdl(board,p);
    	else
		m = p2_hdl(board,p);
	end;
	board(:,:,n+1) = board(:,:,n);
	board(m(1), m(2), n+1) = p;

	if (draw)
		draw_board(board);
	end;
	p = -1 * p + 3; % changes 1->2 and 2->1
	n = n + 1;
end;

p1_hdl(board, -1);
p2_hdl(board, -2);

outcome = end_state(board);
if (draw)
	switch outcome,
		case 1
			title('PLAYER 1 WINS');
		case 2
			title('PLAYER 2 WINS');
		case 0
			title('DRAW');
	end;
end;
	

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DRAW_BOARD handles the graphics.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function draw_board(board)
%
% Draw board lines
%
hold off;
plot([1.5 1.5], [.5 3.5], '-k');
hold on;
plot([2.5 2.5], [.5 3.5], '-k');
plot([.5 3.5], [1.5 1.5], '-k');
plot([.5 3.5], [2.5 2.5], '-k');
axis([.5 3.5 .5 3.5]);

set(gca, 'YTick', []);
set(gca, 'XTick', []);
set(gca, 'YColor', [1 1 1]);
set(gca, 'XColor', [1 1 1]);
set(gcf, 'Color', [1 1 1]);

%
% Draw move marks
%
n = size(board,3);
b = squeeze(board(:,:,n));
ind = find(b);
r = 0.3;
for i = 1:numel(ind)
	[x y] = ind2sub(size(b), ind(i));
	if (b(ind(i)) == 1),				% draw X
		plot([x-r x+r], [y-r y+r], '-r');
		plot([x+r x-r], [y-r y+r], '-r');
	else,								% draw O
		theta = [0:2*pi/64:2*pi];
		plot(r*sin(theta)+x, r*cos(theta)+y, '-b');
	end;
end;
