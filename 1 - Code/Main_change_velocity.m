%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is the main script to calculate the trailing edge noise at different
% directivity angles based on the theory of Roger-Moreu 2005. 
% In this code, the back scattering effect is also taken into account. 
% Laura Botero Bolívar - University of Twente 
% l.boterobolivar@utwente.nl
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Set the case
clear all
close all
%hold all
[fluid,inputs] = inputs_definition();
%% specifiy frequency
U = [20, 30, 40, 50];
for i = 1: length(U)
inputs.U = U(i);
inputs.M        = inputs.U/fluid.c0;
inputs.Re       = inputs.chord*inputs.U/fluid.ni;
[omega, S_pp(:,i), I, S0,f,delta_s] = TE_noise_Prediction(inputs,fluid);
if i ~=1
figure(1)
hold on 
semilogx(f,10*log10(S_pp(:,i))-30*log10(U(i)/U(1)))

figure(2)
hold on 
semilogx(f,10*log10(S_pp(:,i))-40*log10(U(i)/U(1)))

figure(3)
hold on 
semilogx(f,10*log10(S_pp(:,i))-50*log10(U(i)/U(1)))

figure(4)
hold on 
semilogx(f*delta_s/U(i),10*log10(S_pp(:,i))-30*log10(U(i)/U(1)))

figure(5)
hold on 
semilogx(f*delta_s/U(i),10*log10(S_pp(:,i))-40*log10(U(i)/U(1)))

figure(6)
hold on 
semilogx(f*delta_s/U(i),10*log10(S_pp(:,i))-50*log10(U(i)/U(1)))

figure(7)
hold on 
semilogx(f/U(i),10*log10(S_pp(:,i)/(U(i)^3)))

figure(8)
hold on 
semilogx(f/U(i),10*log10(S_pp(:,i)/(U(i)^4)))

figure(9)
hold on 
semilogx(f/U(i),10*log10(S_pp(:,i)/(U(i)^5)))
end 
end 


% figure(4)
% semilogx(omega/fluid.c0*input.chord,k_min_bar_prime(:,19))
% 
% figure(5)
% semilogx(omega/fluid.c0*input.chord,imag(A1_prime(:,19)))
% 
% 
% figure(6)
% semilogx(omega/fluid.c0*input.chord,C(:,19))
% 
% figure(7)
% semilogx(omega/fluid.c0*input.chord,mu_bar(:,19))
% 
% figure(8)
% semilogx(omega/fluid.c0*input.chord,K_bar(:,19))
% 
% kc_vector = omega/fluid.c0*input.chord;
