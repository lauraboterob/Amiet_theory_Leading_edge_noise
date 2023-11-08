function [] = plots(f,S_pp,Phi_ww)
%parameters
font_size = 26;
line_width = 2;
x0=10;
y0=10;
width=1000;
height=0.35*1000/0.5;
fh = 1;
figure(fh)
semilogx(f,10*log10(4*pi*S_pp/(20*10^-6)^2))
hold on
xlabel('$f$ [Hz]','FontSize',font_size,'Interpreter','latex')
ylabel('$10\log_{\mathrm(10)}\frac{S_{pp}}{P_{\mathrm{ref}}^2}$ [dB]','Interpreter','latex','FontSize',font_size,'Interpreter','latex')
set(gca,'FontSize',font_size)
set(gcf,'position',[x0,y0,width,height])
ax = gca;
ax.XAxis.TickLabelInterpreter = 'latex';
ax.YAxis.TickLabelInterpreter = 'latex';
legend('show','Numcolumns',2,'location','best','Interpreter','latex');
grid on
fh = fh + 1;

end

