%% 데이터 resampling 및 filtering %%
time = time_100ms;

% resampling 진행
% time_10ms : slope, accel, speed, SrsCfc_dsDmd_10ms
% time_20ms : reartorque
% time_IEB_01_10ms : brake pedal
% time_SAS_01_10ms : steering
% time_IMU_01_10ms : yaw rate
% time_VCU_01_10ms : accel pedal
% time_100ms : curve, distance, road
interpolated_slope = interp1(time_10ms, VseSlp_pcSlope_10ms, time);
interpolated_accel = interp1(time_10ms, VseSpd_dsEstLongAcclFil_10ms, time);
interpolated_speed = interp1(time_10ms, VseSpd_sEstSpdFilt_10ms, time);
interpolated_cfc = interp1(time_10ms, SrsCfc_dsDmd_10ms, time);
interpolated_rtorq = interp1(time_20ms, VmcRgn_tqRgnBrkDmdRear_20ms, time);
interpolated_brake = interp1(time_IEB_01_10ms, IEB_StrkDpthPcVal_IEB_01_10ms, time);
interpolated_steer = interp1(time_SAS_01_10ms, SAS_AnglVal_SAS_01_10ms, time);
interpolated_yaw = interp1(time_IMU_01_10ms, IMU_YawRtVal_IMU_01_10ms, time);
interpolated_accelped = interp1(time_VCU_01_10ms, VCU_AccPedDepVal_VCU_01_10ms, time);
interpolated_curve = interp1(time_100ms, EnvMap_dCurveRadiusCur_100ms, time);
interpolated_distance = interp1(time_100ms, EnvMap_dCurveUnitNext_100ms, time); 
interpolated_road = interp1(time_100ms, EnvMap_stRoadClassCur_100ms, time);
interpolated_next_curve = interp1(time_100ms, EnvMap_dCurveRadiusNext_100ms, time);

% SRS 변수
interpolated_SrsMaxSpd = interp1(time_20ms, Tp_SrsMbc_sMaxCurveDes_20ms, time);
interpolated_SrsSharpSpd = interp1(time_20ms, Tp_SrsMbc_sSharpCurveDes_20ms, time);
interpolated_MaxDmd = interp1(time_20ms, Tp_SrsMbc_dsDmdMaxCurve_20ms, time);
interpolated_SrsDmd = interp1(time_10ms, SrsMbc_dsDmd_10ms, time);
interpolated_SrsSpdLmt = interp1(time_10ms, Tp_SrsMbc_dsDmdSpdLmt_10ms, time);
interpolated_MaxCurveRadius = interp1(time_100ms, EnvMap_dCurveRadiusMaxNext_100ms, time);
interpolated_SharpCurveRadius = interp1(time_100ms, EnvMap_dCurveSharpNext_100ms, time);
interpolated_NextCurveRadius = interp1(time_100ms, EnvMap_stRoadClassCur_100ms, time);

% cfc ~= 0 제외
mbc = find(interpolated_cfc == 0);

% freeway 0x1 추출
road = find(EnvMap_stRoadClassCur_100ms == 1);
srs = intersect(mbc, road);

% % slope < 4 추출
% flat1 = find(interpolated_slope < 4);
% flat2 = find(interpolated_slope > -4);
% flat = intersect(flat1, flat2);

% slope 제약 제거
% flat1 = find(interpolated_slope);
% flat2 = find(interpolated_slope);
% flat = intersect(flat1, flat2);

% 필요 index
index = srs;


% filtering
filtered_slope = interpolated_slope(index);
filtered_accel = interpolated_accel(index);
filtered_speed = interpolated_speed(index);
filtered_cfc = interpolated_cfc(index);
filtered_rtorq = interpolated_rtorq(index);
filtered_brake = interpolated_brake(index);
filtered_steer = interpolated_steer(index);
filtered_yawrate = interpolated_yaw(index);
filtered_curve = EnvMap_dCurveRadiusCur_100ms(index);
filtered_distance = EnvMap_dCurveUnitNext_100ms(index);
filtered_road = EnvMap_stRoadClassCur_100ms(index);
filtered_time = time(index);

% timeseires for 'from Workspace' block
SrsCfc_dsDmd = timeseries(interpolated_cfc,time);
R_min = timeseries(interpolated_MaxCurveRadius, time);
EnvMap_dCurveUnitNext = timeseries(interpolated_distance, time);
EnvMap_dCurveRadiusNext = timeseries(interpolated_next_curve, time);

EnvMap_dCurveRadiusCur = timeseries(interpolated_curve, time);
VseSpd_sEstSpdFilt = timeseries(interpolated_speed, time);
VseSpd_dsEstLongAcclFil = timeseries(interpolated_accel, time);

VCU_AccPedDepVal_VCU_01 = timeseries(interpolated_accelped, time);
IEB_StrkDpthPcVal_IEB_01 = timeseries(interpolated_brake, time);
SrsMbc_dsDmd = timeseries(interpolated_MaxDmd, time);
SrsMbc_sMaxCurveDes = timeseries(interpolated_SrsMaxSpd, time);

simulink_time = time/1000;

%% 그래프 %%
tmin = 680;
tmax = 720;
figure;
%subplot(2,1,1), plot(time,interpolated_next_curve,'-g','LineWidth',2), xlim([tmin tmax]), xlabel('time (s)'), ylabel('CurveRadiusNext');
subplot(2,1,1), plot(time,interpolated_MaxCurveRadius,'-g','LineWidth',2), xlim([tmin tmax]), xlabel('time (s)'), ylabel('CurveRadiusNext');
hold on;
plot(time,interpolated_curve,'-r','LineWidth',2), xlim([tmin tmax]), xlabel('time (s)'), ylabel('CurveRadius');

