function [f,omega,mu,Kyb,Kxb,Ky,Kx,sigma,beta,k] = wavesnumbers(inputs,fluid)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
%% geometrical parameters
b = inputs.semichord;
c = inputs.chord;

%% frequenct definition
%kc_d = 10;
%k_d = kc_d/inputs.chord;
%omega = k_d*fluid.c0;
f= linspace(1,5000,1000);
omega   = 2*pi*f;
k   = omega/fluid.c0; %acoustic wavenumber
beta    = sqrt(1-inputs.M^2);
sigma     = sqrt(inputs.x^2 + beta^2*(inputs.y^2+inputs.z^2));
Kx      = omega/inputs.U;              % Chordwise wavenumber [rad/m]
Kxb     = Kx*b;
mu      = Kxb*inputs.M/beta^2;                     % mu
if inputs.Ky == 0 
Kyb = k*inputs.y/sigma; %in the case we have not define ky.
Ky  = Kyb/b;
else 
Kyb = linspace(-inputs.Ky, inputs.Ky, 200);
Ky  = Kyb/b;
end 
%kb      = sqrt(Kxb.^2+Kyb.^2); 
%kc      = k*c;
%Kapa       = sqrt(mu.^2-(Kyb./beta).^2);    % Kapa
end

