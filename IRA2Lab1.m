close all
clear all
clc

H = tf ([15], [1 6 5 0])
D = 1;

H0 = feedback (H * D, 1);
t = 0:30;
figure(1)
subplot (311)
step(H0)

subplot (312)
impulse(H0)

subplot (313)
rampa = lsim (H0, t, t);
plot (t, rampa)


Te1 = 0.01;
Te2 = 0.1;
Te3 = 1;

Hzoh1 = c2d (H0,Te1,'zoh');
Hzoh2 = c2d (H0,Te2,'zoh');
Hzoh3 = c2d (H0,Te3,'zoh');


figure(2)
subplot (311);
step(Hzoh1);
subplot (312);
impulse(Hzoh1);
subplot(313);
z1 = 0:Te1:30;
rampa1 = lsim (Hzoh1,z1,z1);
plot (z1, rampa1)


figure(3)
subplot (311);
step(Hzoh2);
subplot (312);
impulse(Hzoh2);
subplot(313);
z2 = 0:Te2:30;
rampa2 = lsim (Hzoh2,z2,z2);
plot (z2, rampa2)


figure(4)
subplot (311);
step(Hzoh3);
subplot (312);
impulse(Hzoh3);
subplot(313);
z3 = 0:Te3:30;
rampa3 = lsim (Hzoh3,z3,z3);
plot (z3, rampa3)


Htus1 = c2d(H0,Te1,'tustin');
Htus2 = c2d(H0,Te2,'tustin');
Htus3 = c2d(H0,Te3,'tustin');

figure(5)
subplot (311);
step(Htus1);
subplot (312);
impulse(Htus1);
subplot(313);
t1 = 0:Te1:30;
rampa_tus1 = lsim (Htus1,t1,t1);
plot (t1, rampa_tus1)

figure(6)
subplot (311);
step(Htus2);
subplot (312);
impulse(Htus2);
subplot(313);
t2 = 0:Te2:30;
rampa_tus2 = lsim (Htus2,t2,t2);
plot (t2, rampa_tus2)

figure(7)
subplot (311);
step(Htus3);
subplot (312);
impulse(Htus3);
subplot(313);hold on
t3 = 0:Te3:10;
rampa_tus3 = lsim (Htus3,t3,t3);
plot (t3, rampa_tus3)

ram = lsim (H0, t3,t3);
plot (t3, ram)


%%
H = tf ([15], [1 6 5 0])
D = 1;
te = 1;
t = 0:te:30;
Hzoh = c2d (H,te,'zoh');
H0zoh = feedback (Hzoh*D, te);
ram = lsim (H0zoh, t, t);
plot (t, ram)
