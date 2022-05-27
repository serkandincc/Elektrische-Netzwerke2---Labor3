clc
clear
close all
format longE

FONT_SIZE = 10;

R = 1000;
C = 2.2 * 10^-6;
Vi = -10i;
rhoVi = 10;

fgrenz = fc(R, C);
fall = [fgrenz 5 10 20 40 80 160 320 640];
fall = sort(fall);

Vo = Vout(Vi, R, C, fall);
[thetaVo, rhoVo] = cart2pol(real(Vo), imag(Vo));
thetaVo = rad2deg(thetaVo);

Avwert = Av(rhoVi, rhoVo);

Avwert_db = Av_db(rhoVi, rhoVo);

x = 1:length(fall);

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

function Zc = Zc(C, f)
   Zc = 1 ./ (2*pi*f*C*1i); 
end

function fc = fc(R, C)
    fc = 1 / (2*pi*R*C);
end

function Vout = Vout(Vin, R, C, f)
    Z = Zc(C, f);
    Vout = Vin * (R ./ (Z + R));
end

function Av = Av(Vin, Vout)
    Av = Vout ./ Vin;
end

function Av_db = Av_db(Vin, Vout)
    Av_db = 20 * log10(Vout ./ Vin);
end