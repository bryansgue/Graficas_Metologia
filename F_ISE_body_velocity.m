%% Code to show the results of the Inverse kinematic controller

% Clean variables
clc, clear all, close all;
 
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
load(strcat('Ident_simple_Real_',int2str(n),'.mat'))

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


% ERORES MIL
Err_MiL_x = u_Real(1,:) - u_MiL(1,1:end);
Err_MiL_y = u_Real(2,:) - u_MiL(2,1:end);
Err_MiL_z = u_Real(3,:) - u_MiL(3,1:end);
Err_MiL_w = u_Real(4,:) - u_MiL(4,1:end);

% ERORES MIL
Err_HiL_x = u_Real(1,:) - u_HiL(1,1:end);
Err_HiL_y = u_Real(2,:) - u_HiL(2,1:end);
Err_HiL_z = u_Real(3,:) - u_HiL(3,1:end);
Err_HiL_w = u_Real(4,:) - u_HiL(4,1:end);

% Definir el vector de tiempo correctamente
tiempo1 = 1:numel(Err_MiL_x);
tiempo2 = 1:numel(Err_HiL_x);

% Calcular el ISE para cada coordenada
ISE_MiL_x = trapz(tiempo1, Err_MiL_x.^2);
ISE_MiL_y = trapz(tiempo1, Err_MiL_y.^2);
ISE_MiL_z = trapz(tiempo1, Err_MiL_z.^2);
ISE_MiL_w = trapz(tiempo1, Err_MiL_w.^2);

% Calcular el ISE para cada coordenada
ISE_HiL_x = trapz(tiempo2, Err_HiL_x.^2);
ISE_HiL_y = trapz(tiempo2, Err_HiL_y.^2);
ISE_HiL_z = trapz(tiempo2, Err_HiL_z.^2);
ISE_HiL_w = trapz(tiempo2, Err_HiL_w.^2);

ERROR = [ISE_MiL_x,ISE_HiL_x;
        ISE_MiL_y,ISE_HiL_y;
        ISE_MiL_z,ISE_HiL_z;
        ISE_MiL_w,ISE_HiL_w];
    
%%

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

% Crear un vector de tiempo adecuado (puedes utilizar t_iden si es relevante)
tiempo = t_iden;

% Definir las posiciones de los sistemas de ejes
pos1 = [0.05 0.70 0.28 0.25];
posa = [0.05+0.3 0.70 0.08 0.25];

pos2 = [0.5 0.70 0.28 0.25];
posb = [0.5+0.3 0.70 0.08 0.25];

pos3 = [0.05 0.35 0.28 0.25];
posc = [0.05+0.3 0.35 0.08 0.25];

pos4 = [0.5 0.35 0.28 0.25];
posd = [0.5+0.3 0.35 0.08 0.25];

% Crear la figura
figure('Position', [500 500 sizeX sizeY])

%% FIGURA 1.1 Crear el primer sistema de ejes
ax1 = axes('Position', pos1);
plot(tiempo, sqrt(Err_MiL_x.^2), 'r', 'LineWidth', linewidth_1)
hold on
plot(tiempo, sqrt(Err_HiL_x.^2), 'b', 'LineWidth', linewidth_1)
ylabel('$RMSE~\mu_l$', 'Interpreter', 'latex')

title('~~~~~~~~~~~~~~~~~~~~~~~(a)', 'Interpreter', 'latex')
legend({'$MiL$', '$HiL$'}, 'Interpreter', 'latex')
grid on

%% Figure properties
ax_1 = gca;
ax_1.Box = 'on';
ax_1.BoxStyle = 'full';
ax_1.TickLength = [0.01;0.01];
ax_1.TickDirMode = 'auto';
% ax_1.XTickLabel = [];
ax_1.YMinorTick = 'on';
ax_1.XMinorTick = 'on';
ax_1.XMinorGrid = 'on';
ax_1.YMinorGrid = 'on';
%ax_1.MinorGridColor = '#8f8f8f';
ax_1.MinorGridAlpha = 0.15;
ax_1.LineWidth = 0.8;
ax_1.XLim = [0 t_iden(end)];


%% GRAFICA 1.2
axa = axes('Position', posa);

valores = ERROR(1,:);
% Definir los datos
etiquetas_x = {'MiL', 'HiL'}; % Etiquetas para el eje x

% Crear la gráfica de barras
bar(valores);

% Obtener los límites de los ejes y
ylim = get(gca, 'YLim');
y_mid = mean(ylim);

text(3.6, y_mid, '$ISE~\mu_l $', 'Interpreter', 'latex', 'Rotation', -90, ...
     'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');

% Configurar etiquetas en el eje x
set(gca, 'XTickLabel', etiquetas_x);
grid on

ax_1 = gca;
ax_1.Box = 'on';
ax_1.BoxStyle = 'full';
ax_1.TickLength = [0.01;0.01];
ax_1.TickDirMode = 'auto';
% ax_1.XTickLabel = [];
ax_1.YMinorTick = 'on';
ax_1.XMinorTick = 'on';
ax_1.XMinorGrid = 'on';
ax_1.YMinorGrid = 'on';
%ax_1.MinorGridColor = '#8f8f8f';
ax_1.MinorGridAlpha = 0.15;
ax_1.LineWidth = 0.8;


%% GRAFICA 2

% Crear el segundo sistema de ejes
ax2 = axes('Position', pos2);
plot(tiempo,sqrt(Err_MiL_y.^2), 'r', 'LineWidth', linewidth_1)
hold on
plot(tiempo,sqrt(Err_HiL_y.^2), 'b', 'LineWidth', linewidth_1)

title('~~~~~~~~~~~~~~~~~~~~~~~(b)', 'Interpreter', 'latex')
ylabel('$RMSE~\mu_m$', 'Interpreter', 'latex')
legend({'$MiL$', '$HiL$'}, 'Interpreter', 'latex')
grid on

% Figure properties
ax_1 = gca;
ax_1.Box = 'on';
ax_1.BoxStyle = 'full';
ax_1.TickLength = [0.01;0.01];
ax_1.TickDirMode = 'auto';
% ax_1.XTickLabel = [];
ax_1.YMinorTick = 'on';
ax_1.XMinorTick = 'on';
ax_1.XMinorGrid = 'on';
ax_1.YMinorGrid = 'on';
%ax_1.MinorGridColor = '#8f8f8f';
ax_1.MinorGridAlpha = 0.15;
ax_1.LineWidth = 0.8;
ax_1.XLim = [0 t_iden(end)];

%% GRAFICA 2.2
axb = axes('Position', posb);
valores = ERROR(2,:);
% Definir los datos
etiquetas_x = {'MiL', 'HiL'}; % Etiquetas para el eje x

% Crear la gráfica de barras
bar(valores);

% Obtener los límites de los ejes y
ylim = get(gca, 'YLim');
y_mid = mean(ylim);

text(3.6, y_mid, '$ISE~\mu_m$', 'Interpreter', 'latex', 'Rotation', -90, ...
     'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');

% Configurar etiquetas en el eje x
set(gca, 'XTickLabel', etiquetas_x);
grid on

ax_1 = gca;
ax_1.Box = 'on';
ax_1.BoxStyle = 'full';
ax_1.TickLength = [0.01;0.01];
ax_1.TickDirMode = 'auto';
% ax_1.XTickLabel = [];
ax_1.YMinorTick = 'on';
ax_1.XMinorTick = 'on';
ax_1.XMinorGrid = 'on';
ax_1.YMinorGrid = 'on';
%ax_1.MinorGridColor = '#8f8f8f';
ax_1.MinorGridAlpha = 0.15;
ax_1.LineWidth = 0.8;

%% Grafica 3.1

% Crear el tercer sistema de ejes
ax3 = axes('Position', pos3);
plot(tiempo, sqrt(Err_MiL_z.^2), 'r', 'LineWidth', linewidth_1)
hold on
plot(tiempo, sqrt(Err_HiL_z.^2), 'b', 'LineWidth', linewidth_1)

title('~~~~~~~~~~~~~~~~~~~~~~~(c)', 'Interpreter', 'latex')
ylabel('$RMSE~\mu_n$', 'Interpreter', 'latex')

legend({'$MiL$', '$HiL$'}, 'Interpreter', 'latex')
grid on

% Figure properties
ax_1 = gca;
ax_1.Box = 'on';
ax_1.BoxStyle = 'full';
ax_1.TickLength = [0.01;0.01];
ax_1.TickDirMode = 'auto';
% ax_1.XTickLabel = [];
ax_1.YMinorTick = 'on';
ax_1.XMinorTick = 'on';
ax_1.XMinorGrid = 'on';
ax_1.YMinorGrid = 'on';
%ax_1.MinorGridColor = '#8f8f8f';
ax_1.MinorGridAlpha = 0.15;
ax_1.LineWidth = 0.8;
ax_1.XLim = [0 t_iden(end)];

%%
%% GRAFICA 3.2

axc = axes('Position', posc);
valores = ERROR(3,:);
% Definir los datos
etiquetas_x = {'MiL', 'HiL'}; % Etiquetas para el eje x

% Crear la gráfica de barras
bar(valores);

% Obtener los límites de los ejes y
ylim = get(gca, 'YLim');
y_mid = mean(ylim);

text(3.6, y_mid, '$ISE~\mu_n$', 'Interpreter', 'latex', 'Rotation', -90, ...
     'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');

% Configurar etiquetas en el eje x
set(gca, 'XTickLabel', etiquetas_x);
grid on

ax_1 = gca;
ax_1.Box = 'on';
ax_1.BoxStyle = 'full';
ax_1.TickLength = [0.01;0.01];
ax_1.TickDirMode = 'auto';
% ax_1.XTickLabel = [];
ax_1.YMinorTick = 'on';
ax_1.XMinorTick = 'on';
ax_1.XMinorGrid = 'on';
ax_1.YMinorGrid = 'on';
%ax_1.MinorGridColor = '#8f8f8f';
ax_1.MinorGridAlpha = 0.15;
ax_1.LineWidth = 0.8;


%% Grafica 4.1

% Crear el cuarto sistema de ejes
ax4 = axes('Position', pos4);
plot(tiempo,sqrt(Err_MiL_w.^2), 'r', 'LineWidth', linewidth_1)
hold on
plot(tiempo,sqrt(Err_HiL_w.^2), 'b', 'LineWidth', linewidth_1)
title('~~~~~~~~~~~~~~~~~~~~~~~(d)', 'Interpreter', 'latex')
ylabel('$RMSE~\omega$', 'Interpreter', 'latex')
legend({'$MiL$', '$HiL$'}, 'Interpreter', 'latex')
grid on

% Figure properties
ax_1 = gca;
ax_1.Box = 'on';
ax_1.BoxStyle = 'full';
ax_1.TickLength = [0.01;0.01];
ax_1.TickDirMode = 'auto';
% ax_1.XTickLabel = [];
ax_1.YMinorTick = 'on';
ax_1.XMinorTick = 'on';
ax_1.XMinorGrid = 'on';
ax_1.YMinorGrid = 'on';
%ax_1.MinorGridColor = '#8f8f8f';
ax_1.MinorGridAlpha = 0.15;
ax_1.LineWidth = 0.8;
ax_1.XLim = [0 t_iden(end)];

%% GRAFICA 4.2

axd = axes('Position', posd);
valores = ERROR(4,:);
% Definir los datos
etiquetas_x = {'MiL', 'HiL'}; % Etiquetas para el eje x

% Crear la gráfica de barras
bar(valores);

% Obtener los límites de los ejes y
ylim = get(gca, 'YLim');
y_mid = mean(ylim);

text(3.6, y_mid, '$ISE~\omega$', 'Interpreter', 'latex', 'Rotation', -90, ...
     'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');

% Configurar etiquetas en el eje x
set(gca, 'XTickLabel', etiquetas_x);
grid on

ax_1 = gca;
ax_1.Box = 'on';
ax_1.BoxStyle = 'full';
ax_1.TickLength = [0.01;0.01];
ax_1.TickDirMode = 'auto';
% ax_1.XTickLabel = [];
ax_1.YMinorTick = 'on';
ax_1.XMinorTick = 'on';
ax_1.XMinorGrid = 'on';
ax_1.YMinorGrid = 'on';
%ax_1.MinorGridColor = '#8f8f8f';
ax_1.MinorGridAlpha = 0.15;
ax_1.LineWidth = 0.8;


set(gcf, 'Color', 'w'); % Establece el fondo de los sistemas de ejes en blanco
export_fig ISE.pdf -q101