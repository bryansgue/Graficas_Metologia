%% Code to show the results of the Inverse kinematic controller
% Clean variables
clc, clear all, close all;
 %%
% Load variables of the system
%% CARGA MIL
load("x_MiL_MPC.mat")
load("xref_MiL_MPC.mat")
load("t_MiL_MPC.mat")

h_MiL = states_MPC(1:4,:);
u_MiL = states_MPC(5:8,:);

%% CARGA HIL
load("x_HiL_MPC.mat")
load("xref_HiL_MPC.mat")
load("t_HiL_MPC.mat")

h_HiL = states_MPC(1:4,:);
u_HiL = states_MPC(5:8,:);

%%Tarea deseada
hd = ref_MPC(1:4,:);
hd_p = ref_MPC(5:8,:);

%% CARGA REAL
load("x_Real_MPC.mat")
load("xref_Real_MPC.mat")
load("t_Real_MPC.mat")

h_Real = states_MPC(1:4,:);
u_Real = states_MPC(5:8,:);

t = t_MPC(1,1:end-31);
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



%% Colorbar

axes('Position',[0.05 0.67 .54 .20]);
%% Data generation
% e_pose_plot_Real = line(t_1,norm_e_pose_Real(1,:));
% set(e_pose_plot_Real, 'LineStyle', '-', 'Color', C5, 'LineWidth', 1.1*lw);

e_pose_plot_MiL = line(t_1,norm_e_pose_MiL(1,:));
set(e_pose_plot_MiL, 'LineStyle', '-', 'Color', C1, 'LineWidth', 1.1*lw);

e_pose_plot_HiL = line(t_1,norm_e_pose_HiL(1,:));
set(e_pose_plot_HiL, 'LineStyle', '-', 'Color', C2, 'LineWidth', 1.1*lw);

% fig1_comps.p1 = ul_plot;
%% Title of the image
hTitle_3 = title({'$\textrm{(a)}$'},'fontsize',14,'interpreter','latex','Color',C18);
%xlabel('$\textrm{Time}[s]$','fontsize',10,'interpreter','latex','Color',C18);
ylabel('$\textrm{ENU Pose Error}~||\tilde{\mathbf{\eta}}||$','fontsize',10,'interpreter','latex', 'Color',C18);

%% Legend nomeclature
hLegend_3 = legend([e_pose_plot_MiL, e_pose_plot_HiL],{'$MiL~||\tilde{\mathbf{\eta}}||$','$HiL~||\tilde{\mathbf{\eta}}||$'},'fontsize',12,'interpreter','latex','Color',[255 255 255]/255,'Location','best','NumColumns',1,'TextColor','black');
 set(gca,'ticklabelinterpreter','latex',...
         'fontsize',1.3*fontsizeTicks)
%% Figure properties
ax_3 = gca;
ax_3.Box = 'on';
ax_3.BoxStyle = 'full';
ax_3.TickLength = [0.01;0.01];
ax_3.TickDirMode = 'auto';
ax_3.YMinorTick = 'on';
ax_3.XMinorTick = 'on';
ax_3.XMinorGrid = 'on';
ax_3.YMinorGrid = 'on';
%ax_1.MinorGridColor = '#8f8f8f';
ax_3.MinorGridAlpha = 0.15;
ax_3.LineWidth = 0.8;
ax_3.XLim = [0 t_1(end)];



%%

axes('Position',[0.05 0.39 .54 .20]);

%% Data generation
error_vx_plot = line(t,norm_error_u_MiL);
set(error_vx_plot, 'LineStyle', '-', 'Color', C7, 'LineWidth', 1.3*lw);
error_vy_plot = line(t,norm_error_u_HiL);
set(error_vy_plot, 'LineStyle', '-', 'Color', C14, 'LineWidth', 1.3*lw);

% fig1_comps.p1 = ul_plot;
%% Title of the image
hTitle_4 = title({'$\textrm{(b)}$'},'fontsize',14,'interpreter','latex','Color',C18);

ylabel('$\textrm{FLU Velocity Error}~||\tilde{\mathbf{\mu}}||$','fontsize',10,'interpreter','latex', 'Color',C18);

%% Legend nomeclature
hLegend_4 = legend([error_vx_plot,error_vy_plot],{'$MiL~||\tilde{\mathbf{\mu}}||$','$HiL~||\tilde{\mathbf{\mu}}||$'},'fontsize',12,'interpreter','latex','Color',[255 255 255]/255,'Location','best','NumColumns',1,'TextColor','black');
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
% 

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%

axes('Position',[0.05 0.11 .54 .20]);

%% Data generation
h_error_MiL_plot = line(t,h_error_MiL);
set(h_error_MiL_plot, 'LineStyle', '-', 'Color', C7, 'LineWidth', 1.3*lw);

h_error_HiL_plot = line(t,h_error_HiL);
set(h_error_HiL_plot, 'LineStyle', '-', 'Color', C14, 'LineWidth', 1.3*lw);

h_error_Real_plot = line(t,h_error_Real);
set(h_error_Real_plot, 'LineStyle', '-', 'Color', C14, 'LineWidth', 1.3*lw);


% fig1_comps.p1 = ul_plot;
%% Title of the image
hTitle_4 = title({'$\textrm{(c)}$'},'fontsize',14,'interpreter','latex','Color',C18);
xlabel('$\textrm{Time}[s]$','fontsize',10,'interpreter','latex','Color',C18);
ylabel('$\textrm{FLU Velocity Error}~||\tilde{\mathbf{\mu}}||$','fontsize',10,'interpreter','latex', 'Color',C18);

%% Legend nomeclature
hLegend_4 = legend([h_error_MiL_plot,h_error_HiL_plot,h_error_Real_plot],{'$MiL~||\tilde{\mathbf{\mu}}||$','$HiL~||\tilde{\mathbf{\mu}}||$'},'fontsize',12,'interpreter','latex','Color',[255 255 255]/255,'Location','best','NumColumns',1,'TextColor','black');
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
export_fig Controller_results_Vision.pdf -q101

%% RMS dynamics
RMSE_x_dynamic = sqrt(mean((error_pose_MiL(1,:)).^2));
RMSE_y_dynamic = sqrt(mean((error_pose_MiL(2,:)).^2));
RMSE_z_dynamic = sqrt(mean((error_pose_MiL(3,:)).^2));

% save("Dynamic_real_rmse.mat","RMSE_x_dynamic", "RMSE_y_dynamic", "RMSE_z_dynamic", "error_dynamic");