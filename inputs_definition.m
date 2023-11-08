function [fluid,input] = inputs_definition()
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%% fluid properties 
fluid           = struct; 
fluid.T         = 22;
fluid.Tk        = fluid.T+273.15;
fluid.P         = 100000;
fluid.ni        = 1.5e-5;
fluid.gamma     = 1.4;
fluid.R         = 287;
fluid.c0        = 340; %sqrt(fluid.gamma*fluid.R*fluid.Tk);
fluid.rho       = 1.225;
%fluid.rho       = fluid.P/(fluid.R*fluid.Tk);

%% test case parameters
%default ans:
input           = struct;
input.chord     = 0.3;
input.span      = 0.42;
input.U         = 68; %31.1;
input.x         = 0;
input.y         = 0;
input.z         = 1.5;
input.urms      = 1; %3.65;
input.Lambda    = 0.05; %0.0534;
input.Ky        = 0;

prompt         = {'Chord [m]:', 'Span [m]:','U$_\infty$ [m/s]:'...
    'Mic position x [m]:', 'Mic position y [m]:',...
'Mic position z [m]:','K_y','u_rms:','Lambda:'};
dlg_title      = 'Input';
num_lines      = 1;
defaultans     = {num2str(input.chord),num2str(input.span)...
 ,num2str(input.U),num2str(input.x),num2str(input.y),num2str(input.z),...
 num2str(input.Ky),num2str(input.urms),num2str(input.Lambda)};
data           = inputdlg(prompt,dlg_title,num_lines,defaultans);
input.chord    = str2double(data{1});
input.span     = str2double(data{2});
input.semichord = input.chord/2;
input.U        = str2double(data{3});
input.x        = str2double(data{4});
input.y        = str2double(data{5});
input.z        = str2double(data{6});
input.Ky       = str2double(data{7});
input.urms      = str2double(data{8});
input.Lambda   = str2double(data{9});
input.M        = input.U/fluid.c0;
input.Re       = input.chord*input.U/fluid.ni;
list = {'von Karman','Liepmann','TUD'};
[indx] = listdlg('ListString', list, 'Name', 'Turbulence spectrum');
input.model = list(indx);
%input.model = 'von Karman';
list = {'No-Correction','Roger-Moreau','Dissipation-range'};
[indx] = listdlg('ListString', list, 'Name', 'Correction');
input.correction = list(indx);
%input.correction = 'No-Correction';
end

