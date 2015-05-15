function m = randomXO(b_all, p)

if (p<0),
	m = [-1 -1];
	return;
end;

n = size(b_all,3);
b = squeeze(b_all(:,:,n));

ind = find(b == 0);
move = ind( ceil(rand*numel(ind)) );
[i j] = ind2sub(size(b), move);
m = [i j];
