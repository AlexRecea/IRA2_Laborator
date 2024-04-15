Hf = tf (1, [3.34 1], 'iodelay', 1.86);

Te = 1;

Hz = c2d (Hf,Te, 'zoh');

num1 = Hz.Numerator{:}
den1 = Hz.Denominator{:}

q = 1/sum(num1)

P = q * num1;
Q = q * den1;

Hc = tf (Q, [1 0 -P],Te, "variable", "z^-1");
H0 = feedback (Hc*Hz, 1);
step (H0); hold on

step (feedback(Hc,Hz))

%% Dahlin
Kf = 0.2;
T1 = 50;
T2 = 3;
taum = 2;
Te = 1;

Hf = tf (Kf, conv([T1 1],[T2 1]), 'iodelay', taum);
Hfz = c2d (Hf, Te, 'zoh');
[num, den] = tfdata(Hfz, 'v');
Hfzz = tf ([0 0 num], den, Te, 'Variable', 'z^-1')

step (Hf)
lambda = 35;
H0 = tf (1, [lambda 1], 'iodelay', taum);

N = taum / Te;
HH0 = c2d (H0, Te, 'zoh');
numarator = HH0.Numerator{:};
numitor = HH0.Denominator{:};
%[num, den] = tfdata (H0,'v');
HH0zz = tf ([0 0 numarator], numitor, Te, 'Variable', 'z^-1');
H01zz = minreal (HH0zz/(1-HH0zz))
Hdcz = minreal (H01zz/Hfzz)

step (feedback(Hdcz, Hfzz))

denf = conv ([1 -1], [1 +0.01942 +0.01942])
numf = [32.67 -55.44 22.95]
H_corectat = tf (numf, denf, Te, 'Variable', 'z^-1')

step (feedback (H_corectat, Hfzz))

step (feedback (H_corectat*Hfzz,1))


