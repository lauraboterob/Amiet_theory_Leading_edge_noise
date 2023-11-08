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
%hold all
[fluid,input] = inputs_definition();
R = input.z;
angle = 0:1:180;
x = R*cosd(angle);
z = R*sind(angle);
%% specifiy frequency
for i = 1: length(x)
input.x = x(i);
input.z = z(i);
[f,omega,Kapa(:,i),mu(:,i),kc,kb(:,i),Kyb(:,i),Kxb(:,i),Ky(:,i),Kx(:,i),sigma(i),beta] = wavesnumbers(input,fluid);
%[~,pos] = min(abs(omega_d-omega));
Ky(:,i) = 1.5*beta*mu(:,i)/input.semichord;
%% Trailing edge noise prediction
[L(:,i),L1(:,i),L2(:,i)] = Transfer_function(mu(:,i),beta,input,Kx(:,i),Ky(:,i),sigma(i),Kapa(:,i));
%% plot for the specific frequency
factor(i) = abs(kc*L(:,i).*(input.z/sigma(i)));
factor1(i) = abs(kc*L1(:,i).*(input.z/sigma(i)));
factor2(i) = abs(kc*L2(:,i).*(input.z/sigma(i)));
end 

figure(1)
polarplot(pi/180*angle,factor,'DisplayName','Total')
hold on
polarplot(pi/180*angle,factor1,'DisplayName','f1')
polarplot(pi/180*angle,factor2,'DisplayName','f2')
legend

figure(2)
polarplot(pi/180*angle,imag(L),'DisplayName','Total')
hold on
polarplot(pi/180*angle,imag(L1),'DisplayName','f1')
polarplot(pi/180*angle,imag(L2),'DisplayName','f2')
legend


figure(3)
polarplot(pi/180*angle,real(L),'DisplayName','Total')
hold on
polarplot(pi/180*angle,real(L1),'DisplayName','f1')
polarplot(pi/180*angle,real(L2),'DisplayName','f2')
legend
% 
% figure(2)
% semilogx(omega/fluid.c0*input.chord,10*log10(abs(f1(:,19)).^2))
% 
% figure(3)
% semilogx(omega/fluid.c0*input.chord,10*log10(abs(f2(:,19)).^2))

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
