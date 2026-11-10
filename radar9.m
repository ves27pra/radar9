
%% Experiment 9: Noise, C/N, and G/T
clc; clear; close all

% Given
k = 1.38e-23;
C_dBW = -100;
B = 1e6;
Ts = 150;
G_dBi = 35;

% Calculations
k_dB = 10 * log10(k);
B_dB = 10 * log10(B);
Ts_dB = 10 * log10(Ts);

N_W = k * Ts * B;
N_dBW = 10 * log10(N_W);
CN_dB = C_dBW - N_dBW;
CN_lin = 10^(CN_dB / 10);
GT_dB = G_dBi - Ts_dB;
CN_check = (C_dBW - G_dBi) + GT_dB - k_dB - B_dB;

% Display
fprintf('k = %.2f dBW/K/Hz\nB = %.2f dBHz\nTs = %.2f dBK\n', k_dB, B_dB, Ts_dB);
fprintf('N = %.4e W (%.2f dBW)\n', N_W, N_dBW);
fprintf('C/N = %.2f dB (%.2f linear)\n', CN_dB, CN_lin);
fprintf('G/T = %.2f dB/K\nC/N check = %.2f dB\n', GT_dB, CN_check);

% Ranges
T = 50:10:1000;
G = 10:60;

N_T = 10 * log10(k * T * B);
CN_T = C_dBW - N_T;
GT_G = G - Ts_dB;
GT_T = G_dBi - 10 * log10(T);

% Plot 1
figure(1)
plot(T, N_T, 'b', 'LineWidth', 2); hold on
plot(Ts, N_dBW, 'ro', 'MarkerFaceColor', 'r')
grid on
xlabel('System Noise Temperature (K)')
ylabel('Noise Power (dBW)')
title('Noise Temperature vs Noise Power')
legend('N = kTB', 'Given point', 'Location', 'southeast')

% Plot 2
figure(2)
plot(T, CN_T, 'm', 'LineWidth', 2); hold on
plot(Ts, CN_dB, 'ro', 'MarkerFaceColor', 'r')
grid on
xlabel('System Noise Temperature (K)')
ylabel('C/N Ratio (dB)')
title('Noise Temperature vs C/N Ratio')
legend('C/N', 'Given point', 'Location', 'northeast')

% Plot 3
figure(3)
plot(G, GT_G, 'g', 'LineWidth', 2); hold on
plot(G_dBi, GT_dB, 'ro', 'MarkerFaceColor', 'r')
grid on
xlabel('Antenna Gain (dBi)')
ylabel('G/T Ratio (dB/K)')
title(sprintf('Antenna Gain vs G/T Ratio (T_s = %d K)', Ts))
legend('G/T', 'Given point', 'Location', 'southeast')

% Plot 4
figure(4)
plot(T, GT_T, 'k', 'LineWidth', 2); hold on
plot(Ts, GT_dB, 'ro', 'MarkerFaceColor', 'r')
grid on
xlabel('System Noise Temperature (K)')
ylabel('G/T Ratio (dB/K)')
title(sprintf('System Noise Temperature vs G/T Ratio (G = %d dBi)', G_dBi))
legend('G/T', 'Given point', 'Location', 'northeast')