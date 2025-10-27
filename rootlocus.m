% Root locus for L(s) = num/den with unity feedback
num = [1 6];              % 예: 14
den = [1 14 40 0];          % 예: s^2 + 9s + 14

sys = tf(num, den);      % 열린루프 L(s)
rlocus(sys)              % 근궤적
grid on; title('Root Locus');
