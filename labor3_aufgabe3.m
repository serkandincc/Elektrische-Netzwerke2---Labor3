clc
clear
close all
format longE

% Variablen
R1 = 10000;
R2 = 18000;
C1 = 10^-9;
C2 = 2.2 * 10^-9;

% Frequenzwerten
fall = 1:20000;

% Impedanzen von Kondensatoren
Z1 = Zc(C1, fall);
Z2 = Zc(C2, fall);

% Zusammenhang für Spannungsverstärkung
A = 1 ./ (R2.*(1./Z2 + 1/R2) + R1./Z1 .* R2.*(1./Z2 + 1/R2) - R1./Z1 + R1.*(1./Z2 + 1/R2) - R1/R2);

% Spannungsverstärkungen
An = zeros(1,20000);

for i=1:20000
    % Umwandlung von Spannungsverstärkung im Phasor
    [theta, rho] = cart2pol(real(A(i)), imag(A(i)));

    % Amplituden von Spannungsverstärkungen
    An(i) = rho;
end

% Grenzfrequenz
fc = interp1(An,1:length(An),1/sqrt(2),'nearest')

% Graph
hFig = figure(WindowState="maximized");
sgtitle("AKTIVE TIEFPASSFILTER", "fontweight", "bold");
plot(fall, An, "LineWidth", 3);
xlabel("Frequenz [Hz]");
ylabel("Av");

% Funktion für Kondensator-Impedanz
function Zc = Zc(C, f)
   Zc = 1 ./ (2*pi*f*C*1i); 
end