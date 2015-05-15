function td0

nTrials = 100;
nSteps = 30;

x = zeros(nSteps,1);
w = zeros(nSteps,1);

gamma = 1;
alpha = 0.2;

for trial = 1:nTrials
	for step = 1:nSteps
		x = zeros(nSteps,1);
		if (step >= 10)
			x(step-9) = 1;
		end;
		V(trial,step) = dot(x,w);
		r(trial,step) = (step==20);

		if (step > 1)
			delta(trial,step-1) = r(trial,step-1)+gamma*V(trial,step)-V(trial,step-1);
			dw = alpha * delta(trial,step-1) * xlast;
			w = w + dw;
		end;

		xlast = x;
	end;
end;

subplot(1,2,1);
surf(V);
title('V');
xlabel('time');
ylabel('trial');
subplot(1,2,2);
surf(delta);
title('\delta');
xlabel('time');
ylabel('trial');
