%% Code to show the results of the Inverse kinematic controller

% Clean variables
% Clean variables
clc, clear all, close all;
 %%
% Load variables of the system
value = 1250;
value_MPC = 1250-30;
%% CARGA MIL
load('Kinetic_Real.mat');

% DAtos de estado
h_Kinetic = x_states(1:4,1:end-value);
u_Kinetic = x_states(5:8,1:end-value);

hd = ref(1:4,1:end-value);
hd_p = ref(5:8,1:end-value);

%% CARGA HIL
load('Com_din_Real.mat');

% DAtos de estado
h_Dinamic = x_states(1:4,1:end-value);
u_Dinamic = x_states(5:8,1:end-value);


%% CARGA REAL
load('MPC_Real.mat');

% DAtos de estado
h_MPC = x_states(1:4,1:end-value_MPC);
u_MPC = x_states(5:8,1:end-value_MPC);

%% Tarea deseada


t_1 = t_time(1:end-value-1);
% Error definition


h_error_Kinetic = hd(1:3, :) - h_Kinetic(1:3, :);
h_error_Dinamic = hd(1:3, :) - h_Dinamic(1:3, :);
h_error_MPC =     hd(1:3, :) - h_MPC(1:3, :);

% Definir el vector de tiempo correctamente
tiempo1 = 1:numel(h_error_Kinetic(1,:));
tiempo2 = 1:numel(h_error_Dinamic(1,:));
tiempo3 = 1:numel(h_error_MPC(1,:));

% Calcular el ISE para cada coordenada
ISE_Kinetic_x = trapz(tiempo1, h_error_Kinetic(1,:).^2);
ISE_Kinetic_y = trapz(tiempo1, h_error_Kinetic(2,:).^2);
ISE_Kinetic_z = trapz(tiempo1, h_error_Kinetic(3,:).^2);


% Calcular el ISE para cada coordenada
ISE_Dinamic_x = trapz(tiempo2, h_error_Dinamic(1,:).^2);
ISE_Dinamic_y = trapz(tiempo2, h_error_Dinamic(2,:).^2);
ISE_Dinamic_z = trapz(tiempo2, h_error_Dinamic(3,:).^2);

% Calcular el ISE para cada coordenada
ISE_MPC_x = trapz(tiempo3, h_error_MPC(1,:).^2);
ISE_MPC_y = trapz(tiempo3, h_error_MPC(2,:).^2);
ISE_MPC_z = trapz(tiempo3, h_error_MPC(3,:).^2);


ERROR = [ISE_Kinetic_x,ISE_Dinamic_x, ISE_MPC_x ;
         ISE_Kinetic_y,ISE_Dinamic_y, ISE_MPC_y;
         ISE_Kinetic_z,ISE_Dinamic_z, ISE_MPC_z];
     
 %% Para RMSE
 
% Calcular el RMSE para h_error_Kinetic
RMSE_Kinetic_x = (mean(h_error_Kinetic(1, :).^2));
RMSE_Kinetic_y = (mean(h_error_Kinetic(2, :).^2));
RMSE_Kinetic_z = (mean(h_error_Kinetic(3, :).^2));

% Calcular el RMSE para h_error_Dinamic
RMSE_Dinamic_x = (mean(h_error_Dinamic(1, :).^2));
RMSE_Dinamic_y = (mean(h_error_Dinamic(2, :).^2));
RMSE_Dinamic_z = (mean(h_error_Dinamic(3, :).^2));

% Calcular el RMSE para h_error_MPC
RMSE_MPC_x = (mean(h_error_MPC(1, :).^2));
RMSE_MPC_y = (mean(h_error_MPC(2, :).^2));
RMSE_MPC_z = (mean(h_error_MPC(3, :).^2));




% Figure propert%% Figures
lw = 1.5; % linewidth 1
lwV = 2; % linewidth 2
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
C19 = [81, 115, 180]/255;

%% New color slection

figure('Position', [500 500 sizeX sizeY])
set(gcf, 'Position', [500 500 sizeX sizeY]);
fig1_comps.fig = gcf;

% Figure 1
axes('Position',[0.05 0.57 .44 .38]);
%% MIL TRAYECTORIA

    %% Desired Trajectory
    hd_plot = line(hd(1,:), hd(2,:));
    set(hd_plot, 'LineStyle', '--', 'Color', C8, 'LineWidth', 1.3*lw)

    %% Real Trajectories
    hold on  % Esto mantiene el gráfico actual activo para que las trayectorias se superpongan
    
    

    % Trayectoria 1 (h_MiL) en Azul Cielo
    h_plot_Kinetic = line(h_Kinetic(1,:), h_Kinetic(2,:));
    set(h_plot_Kinetic, 'LineStyle', '-', 'Color', C5, 'LineWidth', 1.3*lw)

    % Trayectoria 2 (h_HiL) en Verde Petróleo
    h_plot_Dinamic = line(h_Dinamic(1,:), h_Dinamic(2,:));
    set(h_plot_Dinamic, 'LineStyle', '-', 'Color', C3, 'LineWidth', 1.3*lw)
    
    % Trayectoria 3 (h_Real) en Rosa Neón
    h_plot_MPC = line(h_MPC(1,:), h_MPC(2,:));
    set(h_plot_MPC, 'LineStyle', '-', 'Color', C19, 'LineWidth', 1.3*lw)

    hold off  % Esto finaliza el modo de superposición de las trayectorias

    %% Title of the image
    hTitle_1 = title({'$\textrm{(a)}$'},'fontsize',14,'interpreter','latex','Color',C18);
    %hXLabel_1 = xlabel('$x~[m]$','fontsize',9,'interpreter','latex', 'Color',C18);
    hYLabel_1 = ylabel('$y~[m]$','fontsize',9,'interpreter','latex', 'Color',C18);

    %% Legend nomeclature
    hLegend_1 = legend([hd_plot, h_plot_Kinetic, h_plot_Dinamic,  h_plot_MPC ],{'$\mathbf{\eta}_d$','$\mathbf{\eta}_{Kinetic}$','$\mathbf{\eta}_{Dynamic}$','$\mathbf{\eta}_{MPC}$'},'fontsize',12,'interpreter','latex','Color',[255 255 255]/255,'Location','best','NumColumns',1,'TextColor','black');
    set(gca,'ticklabelinterpreter','latex',...
            'fontsize',1.3*fontsizeTicks)
    % Figure properties
    ax_1 = gca;
    ax_1.Box = 'on';
    ax_1.BoxStyle = 'full';
    ax_1.TickLength = [0.005;0.005];
    ax_1.TickDirMode = 'auto';
    ax_1.YMinorTick = 'on';
    ax_1.XMinorTick = 'on';
    % ax_2.XTickLabel = [];
    ax_1.XMinorGrid = 'on';
    ax_1.YMinorGrid = 'on';
    %ax_2.MinorGridColor = '#8f8f8f';
    ax_1.MinorGridAlpha = 0.15;
    ax_1.LineWidth = 0.8;
    ax_1.XLim = [min(h_Kinetic(1,:))-0.2 max(h_Kinetic(1,:))+0.2];
    ax_1.YLim = [min(h_Kinetic(2,:))-0.2 max(h_Kinetic(2,:))+0.2];

% Figure 2
axes('Position',[0.05 0.09 .44 .38]);
%% Colorbar


%% Desired Trajectory
    hd_plot2 = line(hd(1,:), hd(3,:));
    set(hd_plot2, 'LineStyle', '--', 'Color', C8, 'LineWidth', 1.3*lw)

    %% Real Trajectories
    hold on  % Esto mantiene el gráfico actual activo para que las trayectorias se superpongan

    
    
    % Trayectoria 1 (h_MiL) en Azul Cielo
    h_plot_Kinetic2 = line(h_Kinetic(1,:), h_Kinetic(3,:));
    set(h_plot_Kinetic2, 'LineStyle', '-', 'Color', C5, 'LineWidth', 1.3*lw)

    % Trayectoria 2 (h_HiL) en Verde Petróleo
    h_plot_Dinamic2 = line(h_Dinamic(1,:), h_Dinamic(3,:));
    set(h_plot_Dinamic2, 'LineStyle', '-', 'Color', C3, 'LineWidth', 1.3*lw)

    % Trayectoria 3 (h_Real) en Rosa Neón
    h_plot_MPC2 = line(h_MPC(1,:), h_MPC(3,:));
    set(h_plot_MPC2, 'LineStyle', '-', 'Color', C19, 'LineWidth', 1.3*lw)

    hold off  % Esto finaliza el modo de superposición de las trayectorias

%% Title of the image
hTitle_2 = title({'$\textrm{(b)}$'},'fontsize',14,'interpreter','latex','Color',C18);
hXLabel_2 = xlabel('$x~[m]$','fontsize',9,'interpreter','latex', 'Color',C18);
hYLabel_2 = ylabel('$z~[m]$','fontsize',9,'interpreter','latex', 'Color',C18);

%% Legend nomeclature
hLegend_2 = legend([hd_plot2, h_plot_Kinetic2, h_plot_Dinamic2, h_plot_MPC2],{'$\mathbf{\eta}_d$','$\mathbf{\eta}_{Kinetic}$','$\mathbf{\eta}_{Dinamic}$','$\mathbf{\eta}_{MPC}$'},'fontsize',12,'interpreter','latex','Color',[255 255 255]/255,'Location','best','NumColumns',1,'TextColor','black');
    set(gca,'ticklabelinterpreter','latex',...
            'fontsize',1.3*fontsizeTicks)
% Figure properties
% Figure properties
    ax_1 = gca;
    ax_1.Box = 'on';
    ax_1.BoxStyle = 'full';
    ax_1.TickLength = [0.005;0.005];
    ax_1.TickDirMode = 'auto';
    ax_1.YMinorTick = 'on';
    ax_1.XMinorTick = 'on';
    % ax_2.XTickLabel = [];
    ax_1.XMinorGrid = 'on';
    ax_1.YMinorGrid = 'on';
    %ax_2.MinorGridColor = '#8f8f8f';
    ax_1.MinorGridAlpha = 0.15;
    ax_1.LineWidth = 0.8;
    ax_1.XLim = [min(h_Kinetic(1,:))-0.2 max(h_Kinetic(1,:))+0.2];
    ax_1.YLim = [min(h_Kinetic(3,:))-0.4 max(h_Kinetic(3,:))+0.2];
    
%%     %%%%%%%%%%%%%%%%5
% axes('Position',[0.05 0.05 .44 .25]);  %axes('Position',[0.05 0.37 .35 .25]);
% %% Data generation
% % e_pose_plot_Real = line(t_1,norm_e_pose_Real(1,:));
% % set(e_pose_plot_Real, 'LineStyle', '-', 'Color', C5, 'LineWidth', 1.1*lw);
% 
% pose_Kinetic = line(t_1(1,1:length(h_error_Kinetic(1,:))),h_error_Kinetic(1,:));
% set(pose_Kinetic, 'LineStyle', '-', 'Color', C10, 'LineWidth', 1.1*lw);
% 
% pose_Dinamic = line(t_1(1,1:length(h_error_Dinamic(1,:))),h_error_Dinamic(1,:));
% set(pose_Dinamic, 'LineStyle', '-', 'Color', C4, 'LineWidth', 1.1*lw);
% 
% pose_MPC = line(t_1(1,1:length(h_error_MPC(1,:))),h_error_MPC(1,:));
% set(pose_MPC, 'LineStyle', '-', 'Color', C14, 'LineWidth', 1.1*lw);
% 
% % fig1_comps.p1 = ul_plot;
% %% Title of the image
% hTitle_3 = title({'$\textrm{(c)}$'},'fontsize',14,'interpreter','latex','Color',C18);
% xlabel('$\textrm{Time}[s]$','fontsize',10,'interpreter','latex','Color',C18);
% ylabel('$\textrm{Inertial Pose Error}[m]$','fontsize',10,'interpreter','latex', 'Color',C18);
% 
% %% Legend nomeclature
% hLegend_3 = legend([pose_Kinetic, pose_Dinamic, pose_MPC],{'$\|\tilde{\mathbf{\eta}}\|_{Kinetic}$','$\|\tilde{\mathbf{\eta}}\|_{Dinamic}$','$\|\tilde{\mathbf{\eta}}\|_{MPC}$'},'fontsize',12,'interpreter','latex','Color',[255 255 255]/255,'Location','best','NumColumns',1,'TextColor','black');
%  set(gca,'ticklabelinterpreter','latex',...
%          'fontsize',1.3*fontsizeTicks)
% %% Figure properties
% ax_3 = gca;
% ax_3.Box = 'on';
% ax_3.BoxStyle = 'full';
% ax_3.TickLength = [0.01;0.01];
% ax_3.TickDirMode = 'auto';
% % ax_3.XTickLabel = [];
% ax_3.YMinorTick = 'on';
% ax_3.XMinorTick = 'on';
% ax_3.XMinorGrid = 'on';
% ax_3.YMinorGrid = 'on';
% %ax_1.MinorGridColor = '#8f8f8f';
% ax_3.MinorGridAlpha = 0.15;
% ax_3.LineWidth = 0.8;
% ax_3.XLim = [0 t_1(end)];

%% GRAFICA 4
values_altura = 0.23;


axes('Position',[0.55 0.72 .44 values_altura]);  %axes('Position',[0.05 0.37 .35 .25]);

% Data generation

pose_error_Kinetic = line(t_1(1,1:length(h_error_Kinetic(1,:))),h_error_Kinetic(1,:));
set(pose_error_Kinetic, 'LineStyle', '-', 'Color', C5, 'LineWidth', 1.1*lw);

pose_error_Dinamic = line(t_1(1,1:length(h_error_Dinamic(1,:))),h_error_Dinamic(1,:));
set(pose_error_Dinamic, 'LineStyle', '-', 'Color', C3, 'LineWidth', 1.1*lw);

pose_error_MPC = line(t_1(1,1:length(h_error_MPC(1,:))),h_error_MPC(1,:));
set(pose_error_MPC, 'LineStyle', '-', 'Color', C19, 'LineWidth', 1.1*lw);

% Title of the image
hTitle_3 = title({'$\textrm{(c)}$'},'fontsize',14,'interpreter','latex','Color',C18);
%xlabel('$\textrm{Time}[s]$','fontsize',10,'interpreter','latex','Color',C18);
ylabel('$\textrm{Pose Error}[m]$','fontsize',10,'interpreter','latex', 'Color',C18);

% Legend nomeclature
hLegend_3 = legend([pose_error_Kinetic, pose_error_Dinamic, pose_error_MPC],{'$\tilde{\mathbf{\eta}}_{x_{Kinetic}}$','$\tilde{\mathbf{\eta}}_{x_{Dynamic}}$','$\tilde{\mathbf{\eta}}_{x_{MPC}}$'},'fontsize',12,'interpreter','latex','Color',[255 255 255]/255,'Location','best','NumColumns',1,'TextColor','black');
 set(gca,'ticklabelinterpreter','latex',...
         'fontsize',1.3*fontsizeTicks)
% Figure properties
ax_3 = gca;
ax_3.Box = 'on';
ax_3.BoxStyle = 'full';
ax_3.TickLength = [0.01;0.01];
ax_3.TickDirMode = 'auto';
% ax_3.XTickLabel = [];
ax_3.YMinorTick = 'on';
ax_3.XMinorTick = 'on';
ax_3.XMinorGrid = 'on';
ax_3.YMinorGrid = 'on';
%ax_1.MinorGridColor = '#8f8f8f';
ax_3.MinorGridAlpha = 0.15;
ax_3.LineWidth = 0.8;
ax_3.XLim = [0 t_1(end)];

%% GRAFICA 5

axes('Position',[0.55 0.405 .44 values_altura]);


pose_error_Kinetic = line(t_1(1,1:length(h_error_Kinetic(2,:))),h_error_Kinetic(2,:));
set(pose_error_Kinetic, 'LineStyle', '-', 'Color', C5, 'LineWidth', 1.1*lw);

pose_error_Dinamic = line(t_1(1,1:length(h_error_Dinamic(2,:))),h_error_Dinamic(2,:));
set(pose_error_Dinamic, 'LineStyle', '-', 'Color', C3, 'LineWidth', 1.1*lw);

pose_error_MPC = line(t_1(1,1:length(h_error_MPC(2,:))),h_error_MPC(2,:));
set(pose_error_MPC, 'LineStyle', '-', 'Color', C19, 'LineWidth', 1.1*lw);

% Title of the image
hTitle_3 = title({'$\textrm{(d)}$'},'fontsize',14,'interpreter','latex','Color',C18);
%xlabel('$\textrm{Time}[s]$','fontsize',10,'interpreter','latex','Color',C18);
ylabel('$\textrm{Pose Error}[m]$','fontsize',10,'interpreter','latex', 'Color',C18);

% Legend nomeclature
hLegend_3 = legend([pose_error_Kinetic, pose_error_Dinamic, pose_error_MPC],{'$\tilde{\mathbf{\eta}}_{y_{Kinetic}}$','$\tilde{\mathbf{\eta}}_{y_{Dynamic}}$','$\tilde{\mathbf{\eta}}_{y_{MPC}}$'},'fontsize',12,'interpreter','latex','Color',[255 255 255]/255,'Location','best','NumColumns',1,'TextColor','black');
 set(gca,'ticklabelinterpreter','latex',...
         'fontsize',1.3*fontsizeTicks)
% Figure properties
ax_3 = gca;
ax_3.Box = 'on';
ax_3.BoxStyle = 'full';
ax_3.TickLength = [0.01;0.01];
ax_3.TickDirMode = 'auto';
% ax_3.XTickLabel = [];
ax_3.YMinorTick = 'on';
ax_3.XMinorTick = 'on';
ax_3.XMinorGrid = 'on';
ax_3.YMinorGrid = 'on';
%ax_1.MinorGridColor = '#8f8f8f';
ax_3.MinorGridAlpha = 0.15;
ax_3.LineWidth = 0.8;
ax_3.XLim = [0 t_1(end)];


%% GRAFICA 6

axes('Position',[0.55 0.09 .44 values_altura]);
% 
pose_error_Kinetic = line(t_1(1,1:length(h_error_Kinetic(3,:))),h_error_Kinetic(3,:));
set(pose_error_Kinetic, 'LineStyle', '-', 'Color', C5, 'LineWidth', 1.1*lw);

pose_error_Dinamic = line(t_1(1,1:length(h_error_Dinamic(3,:))),h_error_Dinamic(3,:));
set(pose_error_Dinamic, 'LineStyle', '-', 'Color', C3, 'LineWidth', 1.1*lw);

pose_error_MPC = line(t_1(1,1:length(h_error_MPC(3,:))),h_error_MPC(3,:));
set(pose_error_MPC, 'LineStyle', '-', 'Color', C19, 'LineWidth', 1.1*lw);

% Title of the image
hTitle_3 = title({'$\textrm{(e)}$'},'fontsize',14,'interpreter','latex','Color',C18);
%xlabel('$\textrm{Time}[s]$','fontsize',10,'interpreter','latex','Color',C18);
ylabel('$\textrm{Pose Error}[m]$','fontsize',10,'interpreter','latex', 'Color',C18);

% Legend nomeclature
hLegend_3 = legend([pose_error_Kinetic, pose_error_Dinamic, pose_error_MPC],{'$\tilde{\mathbf{\eta}}_{z_{Kinetic}}$','$\tilde{\mathbf{\eta}}_{z_{Dynamic}}$','$\tilde{\mathbf{\eta}}_{z_{MPC}}$'},'fontsize',12,'interpreter','latex','Color',[255 255 255]/255,'Location','best','NumColumns',1,'TextColor','black');
 set(gca,'ticklabelinterpreter','latex',...
         'fontsize',1.3*fontsizeTicks)
% Figure properties
ax_3 = gca;
ax_3.Box = 'on';
ax_3.BoxStyle = 'full';
ax_3.TickLength = [0.01;0.01];
ax_3.TickDirMode = 'auto';
% ax_3.XTickLabel = [];
ax_3.YMinorTick = 'on';
ax_3.XMinorTick = 'on';
ax_3.XMinorGrid = 'on';
ax_3.YMinorGrid = 'on';
%ax_1.MinorGridColor = '#8f8f8f';
ax_3.MinorGridAlpha = 0.15;
ax_3.LineWidth = 0.8;
ax_3.XLim = [0 t_1(end)];



%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set(gcf, 'Color', 'w'); % Sets axes background
export_fig E_Comp_ALL_Real.pdf -q101

%% RMS dynamics


% save("Dynamic_real_rmse.mat","RMSE_x_dynamic", "RMSE_y_dynamic", "RMSE_z_dynamic", "error_dynamic");