bldc_data

Iq.ts = pwm.period;  
L = 10000;
Iq.stc.k2 = 0;
%i_stc.kd = 4e-6;
if Iq.stc.k2 > 0
    L = L/Iq.stc.k2;
end
Iq.stc.l1 = 1.7*sqrt(L);
Iq.stc.l2 = L;
Iq.stc.e_tol = 10;
Iq.stc.e_bar = 10; %i_stc.e_tol;
Iq.stc.e_b   = 1;
Iq.stc.e_mu  = 80;
Iq.stc.f_max = 10;

Iq.UM  = 0.95; 
Iq.u_norm = Vcc;
Iq.bf = 0; %0.0001;
Iq.bd = 0; 
Iq.bu = 0.02/Iq.u_norm;
Iq.rlim = I_max*Iq.ts;

f = 1/(Vcc*Iq.bu);
Iq.pid.kp    =  1*f;
Iq.pid.ki_ts = 40*f*Iq.ts;
Iq.pid.kd    =   0*f;
Iq.f1 = 0.5/Iq.ts;
Iq.f2 = 0.5;


%%
Id = Iq;  
L = 1;
Id.stc.l1 = 1.7*sqrt(L);
Id.stc.l2 = L;

Id.stc.e_tol = 0; % 0.01;
Id.stc.e_bar = 0.1;
Id.stc.e_b   = 0;
Id.stc.e_mu  = 1;
Id.stc.f_max = 10;

f = 1/(Vcc*Iq.bu);
Id.pid.kp    = 1*f;
Id.pid.ki_ts = 1*f*Iq.ts;
Id.pid.kd    =   0*f;
Id.f1 = 0.5/Iq.ts;
Id.f2 = 0.5;
