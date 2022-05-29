clc
clear
close all
format longE

FONT_SIZE = 10;

% Variablen
R = 1000;
C = 2.2 * 10^-6;
Vi = -10i;
rhoVi = 10;

% Grenzfrequenz
fgrenz = fc(R, C);

% Frequenzen für Messungspunkten
fall = [fgrenz 5 10 20 40 80 160 320 640];
fall = sort(fall);

% Berechnung von Ausgangsspannung
Vo = Vout(Vi, R, C, fall);

% Umwandlung in Phasor-Form
[thetaVo, rhoVo] = cart2pol(real(Vo), imag(Vo));
thetaVo = rad2deg(thetaVo);

% Spannungsverstärkung
Avwert = Av(rhoVi, rhoVo);

% Spannungsverstärkung im Dezibel-Bereich
Avwert_db = Av_db(rhoVi, rhoVo);

x = 1:length(fall);

% Graphen
hFig = figure(WindowState="maximized");
subplot(2, 2, 1);
bar(rhoVo);
xticklabels(fall);
title("V_{OUT}")
xlabel("Frequenz [Hz]");
ylabel("Spannung [V]");
ylim([0, max(rhoVo) + 1]);
text(x,rhoVo,num2str((rhoVo)', 5),'HorizontalAlignment','center','VerticalAlignment','bottom', 'FontSize', FONT_SIZE);
set(gca,'FontSize',FONT_SIZE);

subplot(2, 2, 2);
bar(Avwert);
xticklabels(fall);
title("A_{V}")
xlabel("Frequenz [Hz]");
ylabel("Spannungsverstärkung");
ylim([0, max(Avwert) + 0.1]);
text(x,Avwert,num2str((Avwert)', 5),'HorizontalAlignment','center','VerticalAlignment','bottom', 'FontSize', FONT_SIZE);
set(gca,'FontSize', FONT_SIZE);

subplot(2, 2, 3.5);
bar(Avwert_db);
xticklabels(fall);
title("A_{V(dB)}")
xlabel("Frequenz [Hz]");
ylabel("Spannungsverstärkung [dB]");
ylim([min(Avwert_db)-2, 0]);
text(x, Avwert_db, num2str((Avwert_db)', 3),'HorizontalAlignment','center','VerticalAlignment','top', 'FontSize', FONT_SIZE);
set(gca,'FontSize', FONT_SIZE);

% Funktion für Berechnung von Kondensator-Impedanz
function Zc = Zc(C, f)
   Zc = 1 ./ (2*pi*f*C*1i); 
end

% Funktion für Grenzfrequenz
function fc = fc(R, C)
    fc = 1 / (2*pi*R*C);
end

% Funktion für Ausgangsspannung
function Vout = Vout(Vin, R, C, f)
    Z = Zc(C, f);
    Vout = Vin * (R ./ (Z + R));
end

% Funktion für Spannungsverstärkung
function Av = Av(Vin, Vout)
    Av = Vout ./ Vin;
end

% Funktion für Spannungsverstärkung im Dezibel
function Av_db = Av_db(Vin, Vout)
    Av_db = 20 * log10(Vout ./ Vin);
end