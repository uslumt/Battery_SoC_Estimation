%% Regression Tree Implementation %%

tree = fitrtree(train_features, train_labels, 'ResponseName','Y', ...
    'PredictorNames',{'m_vol', 'm_cur', 'l_vol', 'l_cur', 'temp', 'time'})
Tree_predicted = predict(tree, [test_features]);
Tree_re_sub_error = resubLoss(tree)

view(tree, 'Mode', 'graph'); % illustration of binary tree splits
TreeFeatureImportanceScores = predictorImportance(tree)

Tree_root_mean_squared_error = sqrt(immse(test_labels, Tree_predicted)) % root mean square error

figure;
plot(1:length([test_labels]), [test_labels], '.'); 
hold on;
plot(1:length([test_labels]), [Tree_predicted], '.');
title(sprintf("Binary Tree Regression (RMSE : %f) ", Tree_root_mean_squared_error) );
xlabel("Index");
ylabel("test labels");
legend('Test Lables', 'Predicted Labels')
hold off;


% There is a bug while using the loss funtion for Mean Squared error calculation
% L = loss(tree, test_features, 'Capacity(State of Charge)')

%% Enseble of regression Trees(Random forest)

t = templateTree('Surrogate','on');
RF = fitrensemble(T,'Capacity(State of Charge)', ...
    'OptimizeHyperparameters',{'NumLearningCycles','LearnRate','MaxNumSplits'});
RF_predicted = predict(RF, [Data_test]);
RF_root_mean_squared_error = sqrt(immse(RF_predicted, Data_test.("Capacity(State of Charge)")));
RF_re_sub_error = resubLoss(RF);
RandomForestFeatureImportanceScores = predictorImportance(RF)

figure;
plot(1:length(Data_test.("Capacity(State of Charge)")), [Data_test.("Capacity(State of Charge)")], '.');
hold on;
plot(1:length([RF_predicted]), [RF_predicted], '.');
xlabel("Index")
ylabel("test labels")
title( sprintf("Random Rorest Regression (RMSE : %f)", RF_root_mean_squared_error))
legend('Test Lables', 'Predicted Labels')
hold off;
