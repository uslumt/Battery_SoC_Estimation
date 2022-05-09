%% Regression Tree Implementation %%

tree = fitrtree(train_features, train_labels, 'CategoricalPredictors', 6 ,...
    'PredictorNames',["Measured Voltage", "Measured Current", "Load Voltage", "Load Current", "Temperature", "time"] ...
    , 'ResponseName','Capacity(State of Charge)');

predicted = predict(tree, test_features);

view(tree, 'Mode', 'graph');
rmse =  sqrt(mean((test_labels - pred).^2))

L = loss(tree, test_features, 'Capacity(State of Charge)' )

% t = templateTree('Surrogate','on');
% Mdl1 = fitrensemble(Data_train,'Capacity(State of Charge)', ...
%     'OptimizeHyperparameters',{'NumLearningCycles','LearnRate','MaxNumSplits'})
% pMPG = predict(Mdl1,[Data_test]);
% V1 = pMPG;
% V2 = Data_test.("Capacity(State of Charge)");
% 
% RMSE = sqrt(mean((V1-V2).^2))

% mse1 = resubLoss(Mdl1)

