function [S_pp] = farfield_noise(k,inputs,fluid,sigma,L,phi_ww)
b = inputs.semichord;
d = inputs.span/2;
% far-field noise calculated in the position x,y,z from the input. 
S_pp = (((k*inputs.z*fluid.rho*b)./(sigma^2)).^2).*(pi*inputs.U*d*abs(L).^2.*phi_ww);
end

