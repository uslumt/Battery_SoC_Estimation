%% Regression Tree Implementation %%

tree = fitrtree(train_features, train_labels, 'ResponseName','Y')

Tree_predicted = predict(tree, [test_features]);
Tree_re_sub_error = resubLoss(tree)

% view(tree, 'Mode', 'graph'); % illustration of binary tree splits
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

% There is a bug while using the loss funtion for Mean Squared error
% calculation
% L = loss(tree, test_features, 'Capacity(State of Charge)')

%% Enseble of regression Trees(Random forest)

t = templateTree('Surrogate','on');
RF = fitrensemble(Data_train,'Capacity(State of Charge)', ...
    'OptimizeHyperparameters',{'NumLearningCycles','LearnRate','MaxNumSplits'})
RF_predicted = predict(RF, [Data_test]);

V1 = RF_predicted;
V2 = Data_test.("Capacity(State of Charge)");

RF_root_mean_squared_error = sqrt(mean((V1-V2).^2))

RF_re_sub_error = resubLoss(RF)
