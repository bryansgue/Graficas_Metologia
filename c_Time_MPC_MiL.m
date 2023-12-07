%% Code to show the results of the Inverse kinematic controller

% Clean variables
clc, clear all, close all;
 
%% CARGA MIL
load('MPC_MiL.mat');

h_MiL = x_states(1:4,:);
u_MiL = x_states(5:8,:);

%%Tarea deseada
hd = ref(1:4,:);
hd_p = ref(5:8,:);

t = t_time(1,1:end-31);

% t_1 = t;

% Action de control dinamica
u = u_input;

% Error definition
for k = 1:length(t)
    error_vector(:,k) = hd(1:3, k)-h_MiL(1:3, k);
    error_dynamic(k) = norm(error_vector(:,k),2);
end

% Figure propert%% Figures
lw = 1; % linewidth 1
lwV = 2; % linewidth 2
fontsizeLabel = 11; %11
fontsizeLegend = 11;
fontsizeTicks = 11;
fontsizeTitel = 11;
sizeX = 1300; % size figure
sizeY = 750; % size figure

% color propreties
c1 = [80, 81, 79]/255;
c2 = [244, 213, 141]/255;
c3 = [242, 95, 92]/255;
c4 = [112, 141, 129]/255;

C18 = [0 0 0];
c5 = [130, 37, 37]/255;
c6 = [205, 167, 37]/255;
c7 = [81, 115, 180]/255;

C1 = [246 170 141]/255;
C2 = [51 187 238]/255;
C3 = [0 153 136]/255;
C4 = [238 119 51]/255;
C5 = [204 51 17]/255;
C6 = [238 51 119]/255;
C7 = [187 187 187]/255;
C8 = [80 80 80]/255;
C9 = [140 140 140]/255;
C10 = [0 128 255]/255;
C11 = [234 52 89]/255;
C12 = [39 124 252]/255;
C13 = [40 122 125]/255;
%C14 = [86 215 219]/255;
C14 = [252 94 158]/255;
C15 = [244 171 39]/255;
C16 = [100 121 162]/255;
C17 = [255 0 0]/255;
%% New color slection

figure('Position', [500 500 sizeX sizeY])
set(gcf, 'Position', [500 500 sizeX sizeY]);
fig1_comps.fig = gcf;


axes('Position',[0.45 0.28 .54 .31]);
%% Data generation
error_vx_plot = line(t(1,1:length(mpc_time(1,:))),mpc_time(1,:));
set(error_vx_plot, 'LineStyle', '-', 'Color', C5, 'LineWidth', 1.3*lw);

% Define el valor constante
valor_constante = 1/30;

% Crea un vector con el mismo tamaño que el eje x con el valor constante
linea_constante = ones(size(t)) * valor_constante;

% Dibuja la línea horizontal en el valor constante
error_vy_plot = line(t, linea_constante);
set(error_vy_plot, 'LineStyle', '-', 'Color', C3, 'LineWidth', 1.3*lw);



% fig1_comps.p1 = ul_plot;
%% Title of the image
%hTitle_4 = title({'$\textrm{(d)}$'},'fontsize',14,'interpreter','latex','Color',C18);
xlabel('$\textrm{Time experiment}[s]$','fontsize',10,'interpreter','latex','Color',C18);
ylabel('$\textrm{Time}~[s]$','fontsize',10,'interpreter','latex', 'Color',C18);

%% Legend nomeclature
hLegend_4 = legend([error_vy_plot, error_vx_plot],{'$Time~loop$','$MPC~time~solve$','${\mu}_{n}$'},'fontsize',12,'interpreter','latex','Color',[255 255 255]/255,'Location','northeast','NumColumns',1,'TextColor','black');
 set(gca,'ticklabelinterpreter','latex',...
         'fontsize',1.3*fontsizeTicks)
%% Figure properties
ax_4 = gca;
ax_4.Box = 'on';
ax_4.BoxStyle = 'full';
ax_4.TickLength = [0.01;0.01];
ax_4.TickDirMode = 'auto';
ax_4.YMinorTick = 'on';
ax_4.XMinorTick = 'on';
ax_4.XMinorGrid = 'on';
ax_4.YMinorGrid = 'on';
%ax_1.MinorGridColor = '#8f8f8f';
ax_4.MinorGridAlpha = 0.15;
ax_4.LineWidth = 0.8;
ax_4.XLim = [0 t(end)];

% 
set(gcf, 'Color', 'w'); % Sets axes background
%%
export_fig c_Time_MPC_MiL.pdf -q101

