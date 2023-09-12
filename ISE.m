%% Code to show the results of the Inverse kinematic controller

% Clean variables
clc, clear all, close all;
 
% Load variables of the system
%load("Identification.mat");

load("Ident_WinDMD_test.mat");

t_iden = t;
%Vel Ref
u_ref = vref;
u = v; 
u_MiL = v_estimate;
u_HiL = v_estimate1;

% ERORES MIL
Err_MiL_x = u(1,:) - u_MiL(1,1:end-1);
Err_MiL_y = u(2,:) - u_MiL(2,1:end-1);
Err_MiL_z = u(3,:) - u_MiL(3,1:end-1);
Err_MiL_w = u(4,:) - u_MiL(4,1:end-1);

% ERORES MIL
Err_HiL_x = u(1,:) - u_HiL(1,1:end-1);
Err_HiL_y = u(2,:) - u_HiL(2,1:end-1);
Err_HiL_z = u(3,:) - u_HiL(3,1:end-1);
Err_HiL_w = u(4,:) - u_HiL(4,1:end-1);

% Definir el vector de tiempo correctamente
tiempo1 = 1:numel(Err_MiL_x);
tiempo2 = 1:numel(Err_HiL_x);

% Calcular el ISE para cada coordenada
ISE_MiL_x = trapz(tiempo1, Err_MiL_x.^2);
ISE_MiL_y = trapz(tiempo1, Err_MiL_y.^2);
ISE_MiL_z = trapz(tiempo1, Err_MiL_z.^2);
ISE_MiL_w = trapz(tiempo1, Err_MiL_w.^2);

% Calcular el ISE para cada coordenada
ISE_HiL_x = trapz(tiempo1, Err_HiL_x.^2);
ISE_HiL_y = trapz(tiempo1, Err_HiL_y.^2);
ISE_HiL_z = trapz(tiempo1, Err_HiL_z.^2);
ISE_HiL_w = trapz(tiempo1, Err_HiL_w.^2);

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

% Crear el primer sistema de ejes
ax1 = axes('Position', pos1);
plot(tiempo, Err_MiL_x.^2, 'r', 'LineWidth', linewidth_1)
hold on
plot(tiempo, Err_HiL_x.^2, 'b', 'LineWidth', linewidth_1)
ylabel('ECM')

title('~~~~~~~~~~~~~~~~~~~~~~~(a)', 'Interpreter', 'latex')
legend({'$\mu_{l_{MiL}}$', '$\mu_{l_{HiL}}$'}, 'Interpreter', 'latex')
grid on

%% GRAFICA 1.2
axa = axes('Position', posa);
x = [1];
valores = ERROR(1,:);
% Definir los datos

etiquetas_x = {'MiL', 'HiL'}; % Etiquetas para el eje x

% Crear la gráfica de barras
bar(valores);

% Obtener los límites de los ejes y
ylim = get(gca, 'YLim');

y_mid = mean(ylim);


text(3.6, y_mid, '$ISE_{\mu_l} $', 'Interpreter', 'latex', 'Rotation', -90, ...
     'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');

% Configurar etiquetas en el eje x
set(gca, 'XTickLabel', etiquetas_x);


%% GRAFICA 2

% Crear el segundo sistema de ejes
ax2 = axes('Position', pos2);
plot(tiempo, Err_MiL_y.^2, 'r', 'LineWidth', linewidth_1)
hold on
plot(tiempo, Err_HiL_y.^2, 'b', 'LineWidth', linewidth_1)

title('~~~~~~~~~~~~~~~~~~~~~~~(b)', 'Interpreter', 'latex')
ylabel('ECM')
legend({'$\mu_{m_{MiL}}$', '$\mu_{m_{HiL}}$'}, 'Interpreter', 'latex')
grid on

%% GRAFICA 2.2

axb = axes('Position', posb);
x = [1];
vals = ERROR(2,:);
b2 = bar(x, vals);

new_labels = {'ISE_y'}; % Cambia las etiquetas según tus necesidades
xticks(x);
xticklabels(new_labels);
grid on


 % Cambia las etiquetas de la leyenda según tus necesidades
% Agregar la leyenda y hacer la línea más fina
hLegend2 = legend(b2, 'MiL', 'HiL'); % Cambia las etiquetas de la leyenda según tus necesidades

% Agregar el ylabel en el lado derecho
% Obtener los límites de los ejes y
ylim = get(gca, 'YLim');
y_mid = mean(ylim);
text(x + 0.6, y_mid, 'ISE', 'Rotation', -90, ...
     'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');

%% Grafica 3.1

% Crear el tercer sistema de ejes
ax3 = axes('Position', pos3);
plot(tiempo, Err_MiL_z.^2, 'r', 'LineWidth', linewidth_1)
hold on
plot(tiempo, Err_HiL_z.^2, 'b', 'LineWidth', linewidth_1)

title('~~~~~~~~~~~~~~~~~~~~~~~(c)', 'Interpreter', 'latex')
ylabel('ECM')

legend({'$MiL$', '$HiL$'}, 'Interpreter', 'latex')
grid on

%%
%% GRAFICA 3.2

axc = axes('Position', posc);
x = [1];
vals = ERROR(3,:);
b3 = bar(x, vals);

new_labels = {'ISE_y'}; % Cambia las etiquetas según tus necesidades
xticks(x);
xticklabels(new_labels);

 % Cambia las etiquetas de la leyenda según tus necesidades
% Agregar la leyenda y hacer la línea más fina
hLegend3 = legend(b3, 'MiL', 'HiL'); % Cambia las etiquetas de la leyenda según tus necesidades
% Agregar el ylabel en el lado derecho
ylim = get(gca, 'YLim');
y_mid = mean(ylim);
text(x + 0.6, y_mid, 'ISE', 'Rotation', -90, ...
     'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');


%% Grafica 4.1

% Crear el cuarto sistema de ejes
ax4 = axes('Position', pos4);
plot(tiempo, Err_MiL_w.^2, 'r', 'LineWidth', linewidth_1)
hold on
plot(tiempo, Err_HiL_w.^2, 'b', 'LineWidth', linewidth_1)
title('~~~~~~~~~~~~~~~~~~~~~~~(d)', 'Interpreter', 'latex')
ylabel('ECM')
legend({'$MiL$', '$HiL$'}, 'Interpreter', 'latex')
grid on

%% GRAFICA 4.2

axd = axes('Position', posd);
x = [1];
vals = ERROR(4,:);
b4 = bar(x, vals);

new_labels = {'ISE_y'}; % Cambia las etiquetas según tus necesidades
xticks(x);
xticklabels(new_labels);

 % Cambia las etiquetas de la leyenda según tus necesidades
% Agregar la leyenda y hacer la línea más fina
hLegend4 = legend(b4, 'MiL', 'HiL'); % Cambia las etiquetas de la leyenda según tus necesidades

% Limites
ylim = get(gca, 'YLim');
y_mid = mean(ylim);
text(x + 0.6, y_mid, 'ISE', 'Rotation', -90, ...
     'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');


set(gcf, 'Color', 'w'); % Establece el fondo de los sistemas de ejes en blanco
export_fig ISE.pdf -q101