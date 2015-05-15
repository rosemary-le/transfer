function m = simple_TD0(b_all, p)
% To run must have global variable TD0.V of size 3^9x2.
% Weights TD0.V(:,1) will be used as player 1.
% Weights TD0.V(:,2) will be used as player 2
% Values are stored for each of 3^9 board states
%

global TD0;

%number of moves in the game until this point
n = size(b_all,3);

%%%
% Update weights only at end of game
%%%
if (p<0) % game over, man
	if (end_state(b_all) == 0)
		r = 0;
	elseif (end_state(b_all) / abs(p) == 1)
		r = 1;
	else
		r = -1;
	end;

	b = b2num(squeeze(b_all(:,:,n)));
	TD0.V(b,abs(p)) = r; % legal to fix value of final state to final reward

	for i = n-1:-1:1
		b = b2num(squeeze(b_all(:,:,i)));
		b1 = b2num(squeeze(b_all(:,:,i+1)));
		d = TD0.V(b1,abs(p)) - TD0.V(b,abs(p));
		TD0.V(b,abs(p)) = TD0.V(b,abs(p)) + .1*d;
	end;
    
	m = -1;
	return;
end;


% use the e-greedy action selection algorithm during
% training. set TD0.e=0 to make this fully greedy.
b = squeeze(b_all(:,:,n));
ind = find(b == 0); %indices of possible moves
if (rand < TD0.e),
	move_indx = ceil( rand * numel(ind) );
	move = ind(move_indx);
	[x y] = ind2sub(size(b), move);
	m = [x y];
else
	Vposs = zeros(numel(ind),1);
	for i = 1:numel(ind)
		[x y] = ind2sub(size(b), ind(i));
        	state = b2num(b) + 3^(3*(x-1) + y-1) * p;
		Vposs(i) = TD0.V(state,p);
	end;
	%Vposs'

	ind_max = find(Vposs == max(Vposs));
	if (numel(ind_max) > 0),
		move_indx = ceil( rand * numel(ind_max) );
		move = ind(ind_max(move_indx));
		[x y] = ind2sub(size(b), move);
		m = [x y];
	end;
end;



function num = b2num(b)
num = 1;
for i = 1:3
	for j = 1:3
		n = 3*(i-1) + j-1;
		num = num + 3^n * b(i,j);
	end;
end;


