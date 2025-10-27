% parameter의 초기 설정 값

% 불편함에 의한 학습에 필요한 변수
SMWU_acclrn_threshold = 8.5; % acc 개입 학습 pressure 기준
SMWU_brklrn_threshold = 8.0; % brk 개입 학습 pressure 기준
SMWU_spdlrn_threshold = 30; % 속도 오차 학습 기준
SMWU_deadband_threshold = 0.01; % pedal, 가속도 값의 최소값

% nsafe값 보정에 필요한 변수
SMWU_nsafe_parameter = 0.1; % nsafe 학습 값
SMWU_nsafe_max = 1.2; % nsafe 학습 상한가
SMWU_nsafe_min = 0.8; % nsafe 학습 하한가

% 개발한 알고리즘의 sampling time
SMWU_sampling_time = 0.001;

% Minimum Jerk Profiling Constraint 고려에 필요한 변수
SMWU_acc_min = -3;
SMWU_time_margin = 0.1;