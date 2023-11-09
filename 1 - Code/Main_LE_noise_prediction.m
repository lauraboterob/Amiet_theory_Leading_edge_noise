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
%hold all
%% inputs
[fluid,inputs] = inputs_definition();

%% Define waves number
[f,omega,mu,Kyb,Kxb,Ky,Kx,sigma,beta,k] = wavesnumbers(inputs,fluid);

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
 Phi_ww= phi_ww;
end     

%% convert to 1/3 octave
%[sortedData,Fc,Flow,Fhigh] = NarrowToNthOctave(f,10*log10(S_pp),3);
%sortedData_Pa2_db=10*log10(8*pi*10.^(sortedData/10)/(20*10^-6)^2);

%% plots
plots(f,S_pp,Phi_ww)



