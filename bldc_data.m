clear
clc

t_sim = 20;                   % tiempo de simulacion
t_int = 1e-5;                 % paso de integracion numerica 
plot_dec = floor(1e-3/t_int); % decimacion para el scope

% parametros del modelo
kt = 2;

W_nom = 20e3;       % velocidad nominal RPM

% parametros del STC de velocidad
L = 2;         % cota para la derivada de la perturbacion
stc.l1 = 1.7*sqrt(L);
stc.l2 = L;
stc.ts = 1e-4;  % tiempo de muestreo (cuanto mas grande mejor)
stc.UM = 1;
stc.I_gain = 300;

% parámetros del motor
pmsm.spec.poles = 8;
pmsm.spec.slots = 9;
pmsm.perf.kt = 0.13;        % Nm/A
pmsm.perf.Rph = 0.0146;       % ohm
pmsm.perf.Rs = 3/2 * pmsm.perf.Rph;       % ohm
pmsm.perf.L = 12e-6;     % H
pmsm.perf.phi = 0.03;     % V*s/rad

% parámetros de los observadores
theta_obs_gain = 2e6;
flux_obs_gain = 2e5;
speed_obs.ki = 7000;
speed_obs.kp = 700;


% Condiciones nominales
P_pmp = 68e3;                % W      
E_pmp = 0.75;                % eficiencia (0.8 - 0.5)
R_pmp = 0.1;                 % radio del impulsor
P_nom = P_pmp/E_pmp;         % W      
W_nom_r = W_nom *2*pi/60;       % velocidad nominal 1/s
T_nom = P_nom/W_nom_r;         % N.m
Q_nom = 7;                   % MPa

% fluido
rng = 0:0.1:1.2;
fluid.W = rng*W_nom;
fluid.P = Q_nom*rng.^2;

% parametros mecanicos
Jm = 0.3*0.05^2;             % momento de inercia equivalente en el eje del rotor
b  = T_nom/Q_nom;      % disipasion viscosa 