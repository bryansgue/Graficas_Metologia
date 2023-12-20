%% Code to show the results of the Inverse kinematic controller

% Clean variables
clc, clear all, close all;
 
% Load variables of the system
%load("Identification.mat");

%% LOAD VALUES FROM MATRICES
n=10;
%% CARGA MIL
load(strcat('Ident_simple_MiL_',int2str(n),'.mat'))

omega_MiL = states(13:15,:);
u_MiL = states(20:22,:);


%% CARGA HiL
load(strcat('Ident_simple_HiL_',int2str(n),'.mat'))

omega_HiL = states(13:15,:);
u_HiL = states(20:22,:);

%% CARGA Real

load("Ident_u_ref_Real_10.mat")
load("Ident_t_Real_10.mat")
load("Ident_states_Real_10.mat")

omega_Real = states(13:15,:);
u_Real = states(20:22,:);

%% Settings


final = 0;
init = 6;
t = t(1,1:end-final);
dim = length(t);

t = t(1,init:end);
ts = 1/30;

%% REFERENCE SIGNALS 
ul_ref = u_ref(1,init:dim);
um_ref = u_ref(2,init:dim);
un_ref = u_ref(3,init:dim);
r_ref = u_ref(4,init:dim);
u_ref = [ul_ref; um_ref; un_ref; r_ref];

%% Velocidad MiL
ul_MiL = double(u_MiL(1,init:dim));
um_MiL = double(u_MiL(2,init:dim));
un_MiL = double(u_MiL(3,init:dim));
r_MiL = double(omega_MiL(3,init:dim));

u_MiL = [ul_MiL; um_MiL; un_MiL; r_MiL];

%% Velocidad HiL
ul_HiL = double(u_HiL(1,init:dim));
um_HiL = double(u_HiL(2,init:dim));
un_HiL = double(u_HiL(3,init:dim));
r_HiL = double(omega_HiL(3,init:dim));

u_HiL = [ul_HiL; um_HiL; un_HiL; r_HiL];

%% Velocidad Real

ul_Real = double(u_Real(1,init:dim));
um_Real = double(u_Real(2,init:dim));
un_Real = double(u_Real(3,init:dim));
r_Real = double(omega_Real(3,init:dim));

u_Real = [ul_Real; um_Real; un_Real; r_Real];


%%
t_iden = t;
%Vel Ref

%tiempo
% Figure propert%% Figures
linewidth_1 = 1; % linewidth 1
linewidth_2 = 2; % linewidth 2
fontsizeLabel = 11; %11
fontsizeLegend = 11;
fontsizeTicks = 11;
fontsizeTitel = 11;
sizeX = 1300; % size figure
sizeY = 750; % size figure

% color propreties
C1 = [246 170 141]/255; % (Rosa Claro)
C2 = [51 187 238]/255; % (Azul Cielo)
C3 = [0 153 136]/255; % (Verde Agua)
C4 = [238 119 51]/255; % (Naranja Vivo)
C5 = [204 51 17]/255; % (Rojo Terracota)
C6 = [238 51 119]/255; % (Rosa Intenso)
C7 = [187 187 187]/255; % (Gris Plateado)
C8 = [80 80 80]/255; % (Gris Oscuro)
C9 = [140 140 140]/255; % (Gris Medio)
C10 = [0 128 255]/255; % (Azul Brillante)
C11 = [234 52 89]/255; % (Rojo Frambuesa)
C12 = [39 124 252]/255; % (Azul Eléctrico)
C13 = [40 122 125]/255; % (Verde Petróleo)
C14 = [252 94 158]/255; % (Rosa Neón)
C15 = [244 171 39]/255; % (Amarillo Dorado)
C16 = [100 121 162]/255; % (Azul Grisáceo)
C17 = [255 0 0]/255; % (Rojo Puro)
C18 = [0 0 0]; % (Negro)

%% New color slection

figure('Position', [500 500 sizeX sizeY])
set(gcf, 'Position', [500 500 sizeX sizeY]);
fig1_comps.fig = gcf;

%% Figure 1
 axes('Position',[0.05 0.8 1 .17]);
%% Data generation
%subplot(4, 1,1)
pos = get(gca, 'Position');
pos(3) = pos(3) / 2;
set(gca, 'Position', pos);

ul_ref = line(t_iden,u_ref(1,1:length(t_iden)));
set(ul_ref, 'LineStyle', '-.', 'Color', C9, 'LineWidth', 1.3*linewidth_1);

ul = line(t_iden,u_Real(1,1:length(t_iden)));
set(ul, 'LineStyle', '-', 'Color', C10, 'LineWidth', 1.3*linewidth_1);

ul_MiL = line(t_iden,u_MiL(1,1:length(t_iden)));
set(ul_MiL, 'LineStyle', '--', 'Color', C4, 'LineWidth', 1.3*linewidth_1);

ul_HiL = line(t_iden,u_HiL(1,1:length(t_iden)));
set(ul_HiL, 'LineStyle', '--', 'Color', C14, 'LineWidth', 1.3*linewidth_1);

%% Title of the image
title('(a)', 'Interpreter', 'latex')
ylabel('$[m/s]$','fontsize',9,'interpreter','latex', 'Color',C18);

%% Legend nomeclature
Legend_1 = legend([ul_ref,ul, ul_MiL, ul_HiL],{'$\mu_{l_{ref}}$','$\nu_{l}$','$\nu_{l_{MiL}}$','$\nu_{l_{HiL}}$'},'fontsize',11,'interpreter','latex','Color',[255 255 255]/255,'NumColumns',1,'TextColor','black');

set(gca,'ticklabelinterpreter','latex','fontsize',1*fontsizeTicks)
%% Figure properties
ax_1 = gca;
ax_1.Box = 'on';
ax_1.BoxStyle = 'full';
ax_1.TickLength = [0.01;0.01];
ax_1.TickDirMode = 'auto';
ax_1.XTickLabel = [];
ax_1.YMinorTick = 'on';
ax_1.XMinorTick = 'on';
ax_1.XMinorGrid = 'on';
ax_1.YMinorGrid = 'on';
%ax_1.MinorGridColor = '#8f8f8f';
ax_1.MinorGridAlpha = 0.15;
ax_1.LineWidth = 0.8;
ax_1.XLim = [0 t_iden(end)];

%% Figure 2
%axes('Position',[0.04 0.58 .45 .17]);
axes('Position',[0.05 0.58 1 .17]);

pos = get(gca, 'Position');
pos(3) = pos(3) / 2;
set(gca, 'Position', pos);
%% Data generation
um_ref = line(t_iden,u_ref(2,1:length(t_iden)));
set(um_ref, 'LineStyle', '-.', 'Color', C9, 'LineWidth', 1.3*linewidth_1);

um = line(t_iden,u_Real(2,1:length(t_iden)));
set(um, 'LineStyle', '-', 'Color', C10, 'LineWidth', 1.3*linewidth_1);

um_MiL = line(t_iden,u_MiL(2,1:length(t_iden)));
set(um_MiL, 'LineStyle', '--', 'Color', C4, 'LineWidth', 1.3*linewidth_1);

um_HiL = line(t_iden,u_HiL(2,1:length(t_iden)));
set(um_HiL, 'LineStyle', '--', 'Color', C14, 'LineWidth', 1.3*linewidth_1);

% fig1_comps.p1 = ul_plot;
%% Title of the image
title('(b)', 'Interpreter', 'latex')
ylabel('$[m/s]$','fontsize',9,'interpreter','latex', 'Color',C18);

%% Legend nomeclature
Legend_2 = legend([um_ref,um, um_MiL, um_HiL],{'$\mu_{m_{ref}}$','$\nu_{m}$','$\nu_{m_{MiL}}$','$\nu_{m_{HiL}}$'},'fontsize',11,'interpreter','latex','Color',[255 255 255]/255,'NumColumns',1,'TextColor','black');

set(gca,'ticklabelinterpreter','latex', 'fontsize',1*fontsizeTicks)
%% Figure properties
ax_2 = gca;
ax_2.Box = 'on';
ax_2.BoxStyle = 'full';
ax_2.TickLength = [0.01;0.01];
ax_2.TickDirMode = 'auto';
ax_2.XTickLabel = [];
ax_2.YMinorTick = 'on';
ax_2.XMinorTick = 'on';
ax_2.XMinorGrid = 'on';
ax_2.YMinorGrid = 'on';
%ax_1.MinorGridColor = '#8f8f8f';
ax_2.MinorGridAlpha = 0.15;
ax_2.LineWidth = 0.8;
ax_2.XLim = [0 t_iden(end)];

%% Figure 3
%axes('Position',[0.04 0.37 .45 .17]);
axes('Position',[0.05 0.37 1 .17]);
pos = get(gca, 'Position');
pos(3) = pos(3) / 2;
set(gca, 'Position', pos);
%% Data generation
un_ref = line(t_iden,u_ref(3,1:length(t_iden)));
set(un_ref, 'LineStyle', '-.', 'Color', C9, 'LineWidth', 1.3*linewidth_1);

un = line(t_iden,u_Real(3,1:length(t_iden)));
set(un, 'LineStyle', '-', 'Color', C10, 'LineWidth', 1.3*linewidth_1);

un_MiL = line(t_iden,u_MiL(3,1:length(t_iden)));
set(un_MiL, 'LineStyle', '--', 'Color', C4, 'LineWidth', 1.3*linewidth_1);

un_HiL = line(t_iden,u_HiL(3,1:length(t_iden)));
set(un_HiL, 'LineStyle', '--', 'Color', C14, 'LineWidth', 1.3*linewidth_1);

% fig1_comps.p1 = ul_plot;
%% Title of the image
title('(c)', 'Interpreter', 'latex')
ylabel('$[m/s]$','fontsize',9,'interpreter','latex', 'Color',C18);

%% Legend nomeclature
Legend_3 = legend([un_ref,un, un_MiL, un_HiL],{'$\mu_{n_{ref}}$','$\nu_{n}$','$\nu_{n_{MiL}}$','$\nu_{n_{HiL}}$'},'fontsize',11,'interpreter','latex','Color',[255 255 255]/255,'NumColumns',1,'TextColor','black');

set(gca,'ticklabelinterpreter','latex','fontsize',1*fontsizeTicks)
%% Figure properties
ax_3 = gca;
ax_3.Box = 'on';
ax_3.BoxStyle = 'full';
ax_3.TickLength = [0.01;0.01];
ax_3.TickDirMode = 'auto';
ax_3.XTickLabel = [];
ax_3.YMinorTick = 'on';
ax_3.XMinorTick = 'on';
ax_3.XMinorGrid = 'on';
ax_3.YMinorGrid = 'on';
%ax_1.MinorGridColor = '#8f8f8f';
ax_3.MinorGridAlpha = 0.15;
ax_3.LineWidth = 0.8;
ax_3.XLim = [0 t_iden(end)];

%% Figure 4

%axes('Position',[0.04 0.16 .45 .17]);
axes('Position',[0.05 0.16 1 .17]);
pos = get(gca, 'Position');
pos(3) = pos(3) / 2;
set(gca, 'Position', pos);
%% Data generation
w_ref = line(t_iden,u_ref(4,1:length(t_iden)));
set(w_ref, 'LineStyle', '-.', 'Color', C9, 'LineWidth', 1.3*linewidth_1);

w = line(t_iden,u_Real(4,1:length(t_iden)));
set(w, 'LineStyle', '-', 'Color', C10, 'LineWidth', 1.3*linewidth_1);

w_MiL = line(t_iden,u_MiL(4,1:length(t_iden)));
set(w_MiL, 'LineStyle', '--', 'Color', C4, 'LineWidth', 1.3*linewidth_1);

w_HiL = line(t_iden,u_HiL(4,1:length(t_iden)));
set(w_HiL, 'LineStyle', '--', 'Color', C14, 'LineWidth', 1.3*linewidth_1);

% fig1_comps.p1 = ul_plot;
%% Title of the image
title('(d)', 'Interpreter', 'latex')
xlabel('$\textrm{Time}[s]$','fontsize',9,'interpreter','latex','Color',C18);
ylabel('$[rad/s]$','fontsize',9,'interpreter','latex', 'Color',C18);

%% Legend nomeclature
Legend_4 = legend([w_ref,w, w_MiL, w_HiL],{'$\mu_{\omega_{{ref}}}$','$\nu_\omega$','$\nu_{\omega_{{MiL}}}$','$\nu_{\omega_{{HiL}}}$'},'fontsize',11,'interpreter','latex','Color',[255 255 255]/255,'NumColumns',1,'TextColor','black');

set(gca,'ticklabelinterpreter','latex','fontsize',1*fontsizeTicks)
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
ax_4.XLim = [0 t_iden(end)];
% 

set(gcf, 'Color', 'w'); % Sets axes background

%
export_fig Result_MiL_HiL_ref.pdf -q101