%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is the main script to calculate the leading edge noise based on
% the theory of Amiets theory. 
% In this code the transfer functions are calculated from Leandro de
% santana's  thesis
% l.boterobolivar@utwente.nl
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
clear all
close all
%hold all
%% inputs
[fluid,inputs] = inputs_definition();

%% Define waves number
[f,omega,mu,Kyb,Kxb,Ky,Kx,sigma,beta,k] = wavesnumbers(inputs,fluid);
% U = [20,30,40,50];
% L = [60, 72.9, 90, 5, 101]/1000;
U = [21,25,31,35,39];
L = [49.4,50.8,53.4,54.9,56.8]/1000;
u_rms = [3.08,4.55,5.87,7.13];
for i = 1:length(U)
    inputs.U = U(i);
%     inputs.urms = u_rms(i);
%     input.Lambda = L(i);
if inputs.Ky == 0  
    %% Turbulence spectrum
    [Phi_ww] = Turbulence_spectrum(Kx,Ky,inputs);
    %% Correction spectrum
    [Phi_ww] = Turbulence_spectrum_corretion(Phi_ww,inputs,f, fluid,Ky,Kx);
    %% Aeroacoustics transfer function
    [L,L1,L2] = Transfer_function(mu,beta,inputs,Kx,Ky,sigma);
    %% far-field noise
    [S_pp] = farfield_noise(k,inputs,fluid,sigma,L,Phi_ww);
else 
    [phi_ww] = Turbulence_spectrum_smallAR(Kx,Ky,inputs);    
    [L, L1, L2] = Transfer_function_smallAR(mu,beta,inputs,Kx,Ky,sigma);
    for i = 1:length(omega)
        Ky_center = k(i)*inputs.y/sigma+Ky;
        arg = (inputs.span/2)*(k(i)*inputs.y/sigma - Ky_center);
        temp = phi_ww(i,:).*abs(L(i,:)).^2.*(sin(arg).^2)./((k(i)*inputs.y/sigma - Ky_center).^2);
        int_over_ky = trapz(Ky_center,temp);
         if mod(i,100) == 0
               figure(4)
               hold on
               plot(Ky_center,temp)
          end
        S_pp(i) = (((k(i)*inputs.z*fluid.rho*inputs.chord)./(2*sigma^2)).^2).*(inputs.U)*int_over_ky;
    end 
end 

%% plots
%plots(f,S_pp)
figure(1)
semilogx(f/U(i),10*log10(4*pi*S_pp/(20*10^-6)^2)-30*log10(U(i)/U(1)))
hold on

figure(2)
semilogx(f/U(i),10*log10(4*pi*S_pp/(20*10^-6)^2)-40*log10(U(i)/U(1)))
hold on

figure(3)
semilogx(f/U(i),10*log10(4*pi*S_pp/(20*10^-6)^2)-50*log10(U(i)/U(1)))
hold on

figure(4)
semilogx(f,10*log10(4*pi*S_pp/(20*10^-6)^2)-30*log10(U(i)/U(1)))
hold on

figure(5)
semilogx(f,10*log10(4*pi*S_pp/(20*10^-6)^2)-40*log10(U(i)/U(1)))
hold on

figure(6)
semilogx(f,10*log10(4*pi*S_pp/(20*10^-6)^2)-50*log10(U(i)/U(1)))
hold on

figure(7)
semilogx(f*inputs.Lambda/U(i),10*log10(4*pi*S_pp/(20*10^-6)^2)-30*log10(U(i)/U(1)))
hold on

figure(8)
semilogx(f*inputs.Lambda/U(i),10*log10(4*pi*S_pp/(20*10^-6)^2)-40*log10(U(i)/U(1)))
hold on

figure(9)
semilogx(f*inputs.Lambda/U(i),10*log10(4*pi*S_pp/(20*10^-6)^2)-50*log10(U(i)/U(1)))
hold on

end
%% convert to 1/3 octave
%[sortedData,Fc,Flow,Fhigh] = NarrowToNthOctave(f,10*log10(S_pp),3);
%sortedData_Pa2_db=10*log10(8*pi*10.^(sortedData/10)/(20*10^-6)^2);




