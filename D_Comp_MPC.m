%% Code to show the results of the Inverse kinematic controller

% Clean variables
clc, clear all, close all;
 %%
% Load variables of the system
value = 1250-31;
%% CARGA MIL
load('MPC_MiL.mat');

h_MiL = x_states(1:4,1:end-value);
u_MiL = x_states(5:8,1:end-value);

%% CARGA HIL
load('MPC_HiL.mat');

h_HiL = x_states(1:4,1:end-value);
u_HiL = x_states(5:8,1:end-value);


%% CARGA REAL
load('MPC_Real.mat');

h_Real = x_states(1:4,1:end-value);
u_Real = x_states(5:8,1:end-value);

%% Tarea deseada
hd = ref(1:4,1:end-value);
hd_p = ref(5:8,1:end-value);

t = t_time(1,1:end-31-value);
t_1 = t;
% Error definition
for k = 1:length(t_1)
    
    %ERROR DE POSICION ABSOLUTA
    h_error_MiL(:,k) = norm(hd(1:3, k)-h_MiL(1:3, k));
    h_error_HiL(:,k) = norm(hd(1:3, k)-h_HiL(1:3, k));
    h_error_Real(:,k) = norm(hd(1:3, k)-h_Real(1:3, k));
    
    %Posiciones
    error_pose_MiL(:,k) = h_Real(1:3, k)-h_MiL(1:3, k);
    error_pose_HiL(:,k) = h_Real(1:3, k)-h_HiL(1:3, k);
    
    norm_e_pose_MiL(k) = norm(error_pose_MiL(:,k),2);
    norm_e_pose_HiL(k) = norm(error_pose_HiL(:,k),2);
    
    % VELOCIDADES
    error_u_MiL(:,k) = u_Real(1:4, k)-u_MiL(1:4, k);
    error_u_HiL(:,k) = u_Real(1:4, k)-u_HiL(1:4, k);
    
    norm_error_u_MiL(k) = norm(error_u_MiL(:,k),2);
    norm_error_u_HiL(k) = norm(error_u_HiL(:,k),2);
    
end

%Vel Ref




% Figure propert%% Figures
lw = 1.2; % linewidth 1
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

%% New color slection

figure('Position', [500 500 sizeX sizeY])
set(gcf, 'Position', [500 500 sizeX sizeY]);
fig1_comps.fig = gcf;

% Figure 1
axes('Position',[0.05 0.70 .45 .25]);
%% MIL TRAYECTORIA

    %% Desired Trajectory
    hd_plot = line(hd(1,:), hd(2,:));
    set(hd_plot, 'LineStyle', '--', 'Color', C8, 'LineWidth', 1.2*lw)

    %% Real Trajectories
    hold on  % Esto mantiene el gráfico actual activo para que las trayectorias se superpongan
    
    % Trayectoria 3 (h_Real) en Rosa Neón
    h_plot_Real = line(h_Real(1,:), h_Real(2,:));
    set(h_plot_Real, 'LineStyle', '-', 'Color', C14, 'LineWidth', 1.2*lw)

    % Trayectoria 1 (h_MiL) en Azul Cielo
    h_plot_MiL = line(h_MiL(1,:), h_MiL(2,:));
    set(h_plot_MiL, 'LineStyle', '-', 'Color', C10, 'LineWidth', 1.2*lw)

    % Trayectoria 2 (h_HiL) en Verde Petróleo
    h_plot_HiL = line(h_HiL(1,:), h_HiL(2,:));
    set(h_plot_HiL, 'LineStyle', '-', 'Color', C4, 'LineWidth', 1.2*lw)

    hold off  % Esto finaliza el modo de superposición de las trayectorias

    %% Title of the image
    hTitle_1 = title({'$\textrm{(a)}$'},'fontsize',14,'interpreter','latex','Color',C18);
    %hXLabel_1 = xlabel('$x~[m]$','fontsize',9,'interpreter','latex', 'Color',C18);
    hYLabel_1 = ylabel('$y~[m]$','fontsize',9,'interpreter','latex', 'Color',C18);

    %% Legend nomeclature
    hLegend_1 = legend([hd_plot, h_plot_Real, h_plot_MiL, h_plot_HiL ],{'$\mathbf{\eta}_d$','$\mathbf{\eta}$','$\mathbf{\eta}_{MiL}$','$\mathbf{\eta}_{HiL}$'},'fontsize',12,'interpreter','latex','Color',[255 255 255]/255,'Location','best','NumColumns',1,'TextColor','black');
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
    ax_1.XLim = [min(h_HiL(1,:))-0.2 max(h_HiL(1,:))+0.2];
    ax_1.YLim = [min(h_Real(2,:))-0.2 max(h_Real(2,:))+0.2];

% Figure 2
axes('Position',[0.05 0.37 .45 .25]);
%% Colorbar


%% Desired Trajectory
    hd_plot2 = line(hd(1,:), hd(3,:));
    set(hd_plot2, 'LineStyle', '--', 'Color', C8, 'LineWidth', 1.2*lw)

    %% Real Trajectories
    hold on  % Esto mantiene el gráfico actual activo para que las trayectorias se superpongan

    % Trayectoria 3 (h_Real) en Rosa Neón
    h_plot_Real2 = line(h_Real(1,:), h_Real(3,:));
    set(h_plot_Real2, 'LineStyle', '-', 'Color', C14, 'LineWidth', 1.2*lw)
    
    % Trayectoria 1 (h_MiL) en Azul Cielo
    h_plot_MiL2 = line(h_MiL(1,:), h_MiL(3,:));
    set(h_plot_MiL2, 'LineStyle', '-', 'Color', C10, 'LineWidth', 1.2*lw)

    % Trayectoria 2 (h_HiL) en Verde Petróleo
    h_plot_HiL2 = line(h_HiL(1,:), h_HiL(3,:));
    set(h_plot_HiL2, 'LineStyle', '-', 'Color', C4, 'LineWidth', 1.2*lw)

    

    hold off  % Esto finaliza el modo de superposición de las trayectorias

%% Title of the image
hTitle_2 = title({'$\textrm{(b)}$'},'fontsize',14,'interpreter','latex','Color',C18);
hXLabel_2 = xlabel('$x~[m]$','fontsize',9,'interpreter','latex', 'Color',C18);
hYLabel_2 = ylabel('$z~[m]$','fontsize',9,'interpreter','latex', 'Color',C18);

%% Legend nomeclature
hLegend_2 = legend([hd_plot2, h_plot_Real2, h_plot_MiL2, h_plot_HiL2],{'$\mathbf{\eta}_d$', '$\mathbf{\eta}$','$\mathbf{\eta}_{MiL}$','$\mathbf{\eta}_{HiL}$'},'fontsize',12,'interpreter','latex','Color',[255 255 255]/255,'Location','best','NumColumns',1,'TextColor','black');
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
    ax_1.XLim = [min(h_HiL(1,:))-0.2 max(h_HiL(1,:))+0.2];
    ax_1.YLim = [min(h_Real(3,:))-0.2 max(h_Real(3,:))+0.2];


%%

axes('Position',[0.05 0.1 .45 .15]);

%% Data generation
h_error_MiL_plot = line(t,h_error_MiL);
set(h_error_MiL_plot, 'LineStyle', '-', 'Color', C10, 'LineWidth', 1.3*lw);

h_error_HiL_plot = line(t,h_error_HiL);
set(h_error_HiL_plot, 'LineStyle', '-', 'Color', C4, 'LineWidth', 1.3*lw);

h_error_Real_plot = line(t,h_error_Real);
set(h_error_Real_plot, 'LineStyle', '-', 'Color', C14, 'LineWidth', 1.3*lw);


% fig1_comps.p1 = ul_plot;
%% Title of the image
hTitle_4 = title({'$\textrm{(d)}$'},'fontsize',14,'interpreter','latex','Color',C18);
xlabel('$\textrm{Time}[s]$','fontsize',10,'interpreter','latex','Color',C18);
ylabel('$\textrm{FLU Velocity Error}~||\tilde{\mathbf{\mu}}||$','fontsize',10,'interpreter','latex', 'Color',C18);

%% Legend nomeclature
hLegend_4 = legend([h_error_MiL_plot,h_error_HiL_plot,h_error_Real_plot],{'$\|\tilde{\mathbf{\eta}}_{MiL}\|$','$\|\tilde{\mathbf{\eta}}_{HiL}\|$','$\|\tilde{\mathbf{\eta}}\|$'},'fontsize',12,'interpreter','latex','Color',[255 255 255]/255,'Location','best','NumColumns',1,'TextColor','black');
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
ax_4.XLim = [0 t_1(end)];

set(gcf, 'Color', 'w'); % Sets axes background
export_fig MPC_control_pose_comp.pdf -q101

%% RMS dynamics
RMSE_x_dynamic = sqrt(mean((error_pose_MiL(1,:)).^2));
RMSE_y_dynamic = sqrt(mean((error_pose_MiL(2,:)).^2));
RMSE_z_dynamic = sqrt(mean((error_pose_MiL(3,:)).^2));

% save("Dynamic_real_rmse.mat","RMSE_x_dynamic", "RMSE_y_dynamic", "RMSE_z_dynamic", "error_dynamic");