function r = end_state(b_all)
% r is 1 if player 1 wins, 2 if player 2 win, 
% 0 if a draw, and -1 otherwise

n = size(b_all,3);
b = squeeze(b_all(:,:,n));

diag1 = [];
diag2 = [];
for i = 1:3
	if ( all(b(:,i)==1) || all(b(i,:)==1) ),
		r = 1;
		return;
	end;
	
	if ( all(b(:,i)==2) || all(b(i,:)==2) ),
		r = 2; 
		return;
	end;

	diag1 = [diag1 b(i,i)];
	diag2 = [diag2 b(4-i,i)];
end;

if (all(diag1==1) || all(diag2==1)),
	r = 1;
	return;
elseif (all(diag1==2) || all(diag2==2)),
	r = 2;
	return;
end;

if (all(b)),
	r = 0;
else,
	r = -1;
end;
