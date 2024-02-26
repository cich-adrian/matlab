clear all; close all; clc
%% Parametry wzmacniacza
tic
R1 = 100; % rezystor na wejściu odwracającym [Ohm]
R2 = 1000; % rezystor w pętli sprzężenia zwrotnego [Ohm]
C1 = 1e-6; % kondensator na wejściu odwracającym [F]

%Obliczenie wzmocnienia WO
ku=-R2/R1

% Tworzenie sygnału wejściowego
a = 0;        % Początek przedziału 
b = 0.05;   % krok
c = 3;        % koniec przedziału
t = a:b:c;
Uwe = sin(2*pi*t); % sygnał wejściowy

% Sygnał wyjściowy
Uwy = ku*Uwe; 

% Wykres wzmocnienia
figure
plot(t,Uwe, 'Color', 'g','LineWidth', 1.5)
hold on
grid on
plot(t,Uwy, 'Color', 'r', 'LineWidth', 2)
xlabel('Czas (s)')
ylabel('Napięcie [V]')
legend('Sygnał wejściowy', 'Sygnał wyjściowy', 'Location', 'NorthWest', 'FontSize', 12, 'Box', 'on')

%Pole pod wykresem sygnałów WE/WY
area_Uwe = trapz(t,Uwe);
area1_Uwe = trapz(t(t>=a & t<=c/2),Uwe(t>=a & t<=c/2));
area2_Uwe = trapz(t(t>=c/2 & t<=c),Uwe(t>=c/2 & t<=c));

area_Uwy = trapz(t,Uwy);
area1_Uwy = trapz(t(t>=a & t<=c/2),Uwy(t>=a & t<=c/2));
area2_Uwy = trapz(t(t>=c/2 & t<=c),Uwy(t>=c/2 & t<=c));
%Zapisanie wyników do macierzy wektorowej
Sum_area_Uwe = [area_Uwe, area1_Uwe, area2_Uwe]
Sum_area_Uwy = [area_Uwy, area1_Uwy, area2_Uwy]

%% Transmitancje: 
% Funkcja transferu wzmacniacza
s = tf('s');
H = -R1/(R1+(1/(s*C1)));

% Odpowiedź układu na impuls jednostkowy
figure;
subplot(2,1,1);
[y_impulse, t_impulse] = impulse(H);
plot(t_impulse, y_impulse, 'Color', 'm');
xlabel('Czas (s)');
ylabel('Amplituda');
title('Odpowiedź układu na impuls jednostkowy');
%Odpowiedź układu na skok jednostkowy
subplot(2,1,2); 
[y_step, t_step] = step(H);
plot(t_step, y_step, 'Color', 'm');
xlabel('Czas (s)');
ylabel('Amplituda');
title('Odpowiedź układu na skok jednostkowy');

% Charakterystyka Bodego
figure;
bode(H);
grid on

% Charakterystyka Nyquista
figure;
nyquist(H);
grid on

toc