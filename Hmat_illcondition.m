% ==== H 행렬 정의====

M = 2120;

H = [eye(5) zeros(5,7);
     zeros(1,6) -cos(0)/M -cos(0)/M -1/M -1/M -sin(0)/M 0;
     zeros(1,6) -sin(0)/M -sin(0)/M 0 0 cos(0)/M 1/M];

% ==== 조건수(cond) ====
cnum = cond(H);           % 조건수 (크면 클수록 ill-conditioned)
disp(['Condition number of H = ', num2str(cnum)]);

% ==== 특이값 분해 ====
S = svd(H);                % 특이값
sigma_min = min(S);        % 최소 특이값
sigma_max = max(S);        % 최대 특이값
disp(['sigma_min = ', num2str(sigma_min)]);
disp(['sigma_max = ', num2str(sigma_max)]);

% ==== 해석 ====
if sigma_min < 1e-3
    disp('H 행렬이 ill-conditioned: 특정 힘 방향 정보 거의 없음');
end
