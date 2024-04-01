Hf = tf(2,conv([1,1],[10,1]),'iodelay',1);
zpk(Hf);
phase_Hf = -180 + 60 + 15;
%bode(Hf)
wt_prim = 0.17;
Ti = 4/wt_prim;
H_modul = abs(evalfr(Hf,i*wt_prim));
Kp = 1/H_modul;
Hpi = tf([Kp*Ti,1],[Ti,0]);
Ho = feedback(Hf*Hpi,1);
step(Ho);
%%
[y,t] = step(feedback(Hf*Hpi,1));
err = ones(length(y),1) - y;
t = 1:1:length(err);
figure
u = lsim(Hpi,err,t);
plot(t,u);
%%
Te = 0.2;
Hpi_dis = c2d(Hpi,Te,'tustin');

%%
Te2 = 0.5
Hpi_dis_2 = c2d (Hpi, Te2, 'tustin');