
% parametros del STC de velocidad
L = 1000;          % cota para la derivada de la perturbacion
v_stc.e_norm = 0.01;
v_stc.bu = 0.001;

v_stc.k2 = 0; % 1000;

if v_stc.k2 > 0
    L = L/v_stc.k2;
end
v_stc.l1 = 1.7*sqrt(L);
v_stc.l2 = L;
v_stc.ts = 1e-4;     % tiempo de muestreo (cuanto mas grande mejor)
v_stc.UM = 1;
v_stc.Ur = 100*v_stc.ts;

v_stc.u_norm = I_max;
v_stc.bf = 0; 
v_stc.e_tol = 0; %1/v_stc.e_norm;
if v_stc.k2 > 0
    v_stc.e_tol = v_stc.e_tol * v_stc.k2;
end
v_stc.e_bar = v_stc.e_tol;
v_stc.e_b   = 0; 
v_stc.e_mu  = 10/v_stc.e_norm;
v_stc.f_max = 10;


