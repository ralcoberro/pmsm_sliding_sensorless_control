
% parametros de la perturbacion 
p.t = 10; 
p.a = 0.1*W_nom;
p.w = 20*2*pi;               % 10-200 
% p.num = 1;
% p.den = [1/w^2 2/w 1];

% parametros de la referencia 
r.f    = 1; 
r.off  = 0;
r.rate = (W_nom - r.off)/2;
r.a    = 0;
r.lim  = W_nom;


r.num = 1;
r.den = [0.01 1];