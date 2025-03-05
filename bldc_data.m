clear
clc

F_clk = 168e6; % Hz

% N = 20.000 RPM
% Preq=104 kW (eficiencia = 0.65)
% deltaP req= 7 MPa
% mpunto = 4.15 kg/s
% densidad = 430 kg/m3
% variacion maxima de deltaP requerido < 5%
% LCH4 entre 90 y 100 K

% Condiciones nominales
P_pmp = 68e3;                % W      
E_pmp = 0.75;                % eficiencia (0.8 - 0.5)
R_pmp = 0.1;                 % radio del impulsor
P_nom = P_pmp/E_pmp;         % W      
W_nom = 20e3 *2*pi/60;       % velocidad nominal 1/s
T_nom = P_nom/W_nom;         % N.m
Q_nom = 7;                   % MPa


% A 25 °C, la velocidad del sonido en el agua es de 1.593 m/s.
Mach = W_nom * R_pmp / 1600;

% Valores maximos
Vcc   = 360;                 % tension de alimentacion 
I_max = 400;                 % corriente maxima
P_max = I_max*Vcc;           % potencia electrica maxima
V_nom = 0.8*Vcc;             % tension efectiva nominal
I_nom = P_nom/V_nom;         % corriente maxima

% parametros electricos
pwm.freq   = 50e3;
pwm.period = 1/pwm.freq;
pwm.slope  = pwm.freq*2;
pwm.clk    = 2e-9;           % paso de integracion numerica 

% Wmax   = 15*W_nom;           % velocidad maxima en vacio
% Kv     = 0.05*V_nom/W_nom;
% Ra     = 0.05;               % resistencia Ω
% La     = 0.1;                % inductancia H
% Kt     = T_nom/I_nom;

% fluido
rng = 0:0.1:1.2;
fluid.W = rng*W_nom;
fluid.P = Q_nom*rng.^2;

% parametros mecanicos
Jm = 0.3*0.05^2;             % momento de inercia equivalente en el eje del rotor
b  = T_nom/Q_nom;      % disipasion viscosa 

% sensores
i_sns.qnt = I_max/2^11;
i_sns.nse = i_sns.qnt;

w_sns.qnt = 1.2*W_nom/2^16;

%%
% parámetros del motor
pmsm.spec.poles = 8;
pmsm.spec.slots = 9;
pmsm.perf.kt    = 0.13;                % Nm/A
pmsm.perf.Rph   = 0.0146;              % ohm
pmsm.perf.Rs    = 3/2 * pmsm.perf.Rph; % ohm
pmsm.perf.L     = 12e-6;               % H
pmsm.perf.phi   = 0.03;                % V*s/rad

%%
R  = pmsm.perf.Rph;               % resistencia Ω
Ld = pmsm.perf.L;                 % inductancia H
Lq = Ld; 

w = 0;
P = pmsm.spec.poles;
A = [-R/Lq      Lq/Ld*P*w
    -Ld/Lq*P*w     -R/Lq];
B = [1/Ld  0 ; 0 1/Lq];
MDL = ss(A, B, eye(2), zeros(2,2), 'StateName', {'I_d' 'I_q'},'InputName', {'v_d' 'v_q'},'OutputName', {'I_d' 'I_q'});


% parámetros de los observadores
theta_obs_gain = 2e6;
flux_obs_gain = 4e4;
speed_obs.ki = 150000;
speed_obs.kp = 100000;
current_limit = 300;

