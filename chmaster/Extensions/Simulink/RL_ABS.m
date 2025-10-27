clc; clear;
mdl = 'abs_CS9_rlnonmoon';
observationInfo = rlNumericSpec([4 1],'LowerLimit',[0 0 0 -inf]','UpperLimit',[1 1 inf inf]');
observationInfo.Name = 'observations'
actionInfo = rlFiniteSetSpec([2 2]);
actionInfo.Name = 'W/C pressure'
env = rlSimulinkEnv('abs_CS9_rlnonmoon','abs_CS9_rlnonmoon/RL Agent',observationInfo,actionInfo);
Ts = 0.025; Tf = 10;
rng(0)
dnn = [featureInputLayer(4,'Normalization','none','Name','state');
       fullyConnectedLayer(32,'Name','FC1');
       tanhLayer('Name','tanh')
       fullyConnectedLayer(32,'Name','FC2');
       sigmoidLayer('Name','sigmoid');
       fullyConnectedLayer(2,'Name','output')];
dnn = dlnetwork(dnn);
criticOpts = rlOptimizerOptions('LearnRate',0.001,'GradientThreshold',1);
critic = rlVectorQValueFunction(dnn,observationInfo,actionInfo);
agentOptions = rlDQNAgentOptions('SampleTime',Ts,'CriticOptimizerOptions',criticOpts,'UseDoubleDQN',false);
agent = rlDQNAgent(critic,agentOptions);
trainingOptions = rlTrainingOptions("MaxEpisodes",1000,"MaxStepsPerEpisode",400,'ScoreAveragingWindowLength',5, ...
    'Verbose',false,'Plots','training-progress')
%% training
doTraining = true;

if doTraining
    trainingStats = train(agent,env,trainingOptions);
else
    load('abs_CS9_rlnonmoonDQN.mat','agent');
end