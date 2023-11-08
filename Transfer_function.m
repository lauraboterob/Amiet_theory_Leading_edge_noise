function [L, L1, L2] = Transfer_function(mu,beta,inputs,kx,ky,sigma)
b = inputs.semichord;
x = inputs.x;
y = inputs.y;
z = inputs.z;
M = inputs.M;
for i = 1:length(kx)
  if  (ky(i)*b)^2 < (kx(i)*b*inputs.M/(beta))^2
        kapa = sqrt(mu(i)^2 - (ky(i)*b/beta)^2);
        theta1 = kapa - mu(i)*x/sigma;
        theta2 = mu(i)*(M - x/sigma) - pi/4;
        theta3 = kapa + mu(i)*x/sigma;

        % Leading edge correction - Eq. A.76 of Leandro's thesis
        L1(i) = (1/pi) * conj(sqrt( 2 ./ (theta1 .* (kx(i)*b + beta^2*kapa)))).* ...
            Fresnel_int_conj(2*theta1) .* exp(1i*theta2);
        

        % Trailing edge correction - Eq. A.77 of Leandro's thesis
        L2(i) = exp(1i*theta2) ./ (theta1.*pi.*sqrt(2*pi*(kx(i)*b+beta^2.*kapa))) .* ...
            ( 1i*(1-exp(-1i*2*theta1)) + (1-1i)*(Fresnel_int_conj(4*kapa) - ...
            conj(sqrt(2*kapa./theta3)) .* exp(-1i*2*theta1) .* Fresnel_int_conj(2*theta3)));

  else 
        kapa_p = sqrt(((ky(i)*b).^2)/(beta^2) - mu(i)^2);
        theta1_p = -1i*kapa_p - mu(i)*x/sigma;
        theta2 = mu(i)*(M - x/sigma) - pi/4;
        theta3_p = kapa_p - 1i*mu(i)*x/sigma;
       
        % Leading edge correction - Eq. A.154 of Leandro's thesis
%         L1 = 1 ./ (pi*sqrt(kapa_p*beta^2+1i*k_x*b)) .* (exp(1i*mu*(M-x/sigma))) .* ...
%             1/sqrt(theta) .* exp(-1i*pi/4) .* erfz(2*1i*theta);

         L1(i) = (1/pi)*sqrt((2)/((kx(i)*b-1i*beta^2*kapa_p)*theta1_p))*...
             Fresnel_int_conj(2*theta1_p)*exp(1i*theta2); % Breasciani 2021 A.2
        
         % Trailing edge correction - Eq. A.174 of Leandro's thesis
        %L2 = -exp(1i*mu*(M-x/sigma)) ./ (pi*sqrt(2*pi*(kapa_p*beta^2+1i*k_x*b))) .* ...
            %1./(kapa_p-1i*mu*x/sigma) .* ( 1 - erfz(sqrt(4*kapa_p)) - ...
           % exp(-2*(kapa_p-1i*mu*x/sigma)) + sqrt(2*kapa_p) .* exp(-2*(kapa_p-1i*mu*x/sigma)) ./ sqrt(kapa_p+1i*mu*x/sigma) .* ...
           % erfz(sqrt(2*(kapa_p+1i*mu*x/sigma))) );
        
          L2(i) = -exp(1i*mu(i)*(M-x/sigma)) ./ (pi*theta3_p.*sqrt(2*pi*(kapa_p*beta^2+1i*kx(i)*b))) .* ...
            ( 1 - erfz(sqrt(4*kapa_p)) - exp(-2*theta3_p) + ...
            sqrt(2*kapa_p) .* exp(-2*theta3_p) ./ sqrt(kapa_p+1i*mu(i)*x/sigma) .* ...
            erfz(sqrt(2*(kapa_p+1i*mu(i)*x/sigma))));
      
  end 
      L(i)=L1(i)+L2(i);
end 


end

