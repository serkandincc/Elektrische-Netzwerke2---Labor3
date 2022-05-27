clc
clear
close all
format longE

R1 = 82000;
R2 = 33000;
C1 = 82 * 10^-12;
C2 = 82 * 10^-12;

fall = 1:60000;

Z1 = Zc(C1, fall);
Z2 = Zc(C2, fall);

A = 1 ./ (Z2.*(1./Z2 + 1/R1) + (Z2.*Z1)/R2 .* (1./Z2 + 1/R1) - Z1./R2 + Z1.*(1./Z2 + 1/R1) - Z1./Z2);
An = zeros(1,60000);
for i=1:60000
    [theta, rho] = cart2pol(real(A(i)), imag(A(i)));
    An(i) = rho;
end

fc = interp1(An,1:length(An),1/sqrt(2),'nearest')

hFig = figure(WindowState="maximized");
sgtitle("AKTIVE HOCHPASSFILTER", "fontweight", "bold");
plot(fall, An, "LineWidth", 3)
xlabel("Frequenz [Hz]");
ylabel("Av");
ylim([0 1]);

function Zc = Zc(C, f)
   Zc = 1 ./ (2*pi*f*C*1i); 
end