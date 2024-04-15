T1 = 3.34;
taum = 1.86;
Te = 1;

Hf1 = tf(1,[T1,1],'iodelay',taum);

Hfz = c2d(Hf1,Te,'zoh');

Num1 = Hf1z.Numerator{:};
Den1 = Hf1z.Denominator{:};

%Hf1z = tf(Num1,Den1,Te,"Variable","z^-1")

q = 1/sum(Num1);

Pz = q*Num1;
Qz = q*Den1;

Hc1 = tf(Qz,[1 0 -Pz],Te,"Variable","z^-1");

H01 = feedback(Hfz*Hc1,1)
step(H01)

figure
step(feedback(Hc1,Hfz))

%% Dahlin
Kf2 = 0.2;
T1 = 50;
T2 = 3;
taum = 2;
Te = 1;

Hf2 = tf(Kf2,conv([T1,1],[T2,1]),'iodelay',taum);

Hfz = c2d(Hf2,Te,'zoh');
[num,den] = tfdata(Hfz,'v');
Hfzz = tf([0 0 num],den,Te,'Variable','z^-1') %introduci zero care reprezinta timp mort

step(Hfz)

ts = 100;
lamda = ts/4;

H02s = tf(1,[lamda,1],'iodelay',taum);

H02z = c2d(H02s,Te,'zoh');
% Num2 = H02z.Numerator{:}
% Den2 = H02z.Denominator{:}
[Num2,Den2] = tfdata(H02z,'v');
H02zz = filt([0 0 Num2],Den2);

H0zz = minreal(H02zz/(1-H02zz));
Hcz = minreal(H0zz/Hfzz);
zpk(Hcz) %aici ne uitam sa vedem care este polul care ne influenteaza cel mai mult
%in cazul nostru o sa fie acela din mijloc (avem 1 integrator, 2 poli
%complex conjugati, si cel din mijloc e intrusul

figure
step(feedback(Hcz*Hfzz,1)) %raspunsul sistemului in bucla inchisa

figure
step(feedback(Hcz,Hfzz)) %cum arata comanda de la regulator

figure
Q = deconv(Hcz.Denominator{:},[1,0.899])
Hrz = tf(Hcz.Numerator{:},Q,Te,'Variable','z^-1')
zpk(Hrz)

figure
step(feedback(Hcz*1.889*Hfzz,1))
figure
step(feedback(Hrz*1.889,Hfzz))

A = Hrz.Numerator{:}/1.889;
B =  Hrz.Denominator{:}/1.899;

Hrzm = tf(A,B,Te,'Variable','z^-1')

minreal(Hrzm)


