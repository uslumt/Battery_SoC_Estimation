%% Assuming all independent variable are highly correlated to use Ridge Regression.

% a1 = load_c{1}
% b1 = load_v{1}
% c1 = measured_c{1}
% d1 = temperature{1}
% e1 = time{1}
% 
% X = [a1' b1' c1' d1'];
% y = transpose(cell2mat(capacity)); % Ahr
% 
% n = length(y);
% rng('default') % For reproducibility
% c = cvpartition(n,'HoldOut',0.3);
% idxTrain = training(c,1);
% idxTest = ~idxTrain;
% 
% k=10;
% 
% b = ridge(y(idxTrain),X(idxTrain,:),k,0);
% hold on
% yhat = b(1) + X(idxTest,:)*b(2:end);
% 
% scatter(y(idxTest),yhat)
% 
% % plot(y(idxTest),yhat,'b-')
% 
% plot(y(idxTest),y(idxTest),'r--')% reference line
% xlabel('Actual Capacity (Ahr)')
% ylabel('Predicted Capacity (Ahr)')
% legend("Actual","Predicted")
% hold on

%% Predict discharge time using Ridge Regression

% a1 = load_c{1}
% b1 = load_v{1}
% c1 = measured_c{1}
% d1 = temperature{1}
% e1 = time{1}
% g1 = transpose(cell2mat(capacity))
% X = [e1'];
% y = g1;
% 
% n = length(y);
% rng('default') % For reproducibility
% c = cvpartition(n,'HoldOut',0.3);
% idxTrain = training(c,1);
% idxTest = ~idxTrain;
% 
% k=1;
% 
% b = ridge(y(idxTrain),X(idxTrain,:),k,0);
% hold on
% yhat = b(1) + X(idxTest,:)*b(2:end);
% 
% plot(X(idxTest),yhat,'r')
% 
% plot(X(idxTest),y(idxTest),'b')% reference line
% xlabel('Time (sec)')
% ylabel('Predicted Capacity (Ahr)')
% hold on
% title("Predicted vs Actual Battery Remaining Useful Time")
% legend("Predicted","Actual")

%% Predicted Useful Time after 1000 Seconds with single variable linearity


% a1 = load_c{1}
% b1 = load_v{1}
% c1 = measured_c{1}
% d1 = temperature{1}
% e1 = time{1}
% g1 = transpose(cell2mat(capacity))
% X = [nonzeros((e1<1000)'.*e1')];
% y = g1(1:54);
% X1 = [e1'];
% y1 = g1;
% % n = length(y);
% % rng('default') % For reproducibility
% % c = cvpartition(n,'HoldOut',0.3);
% % idxTrain = training(c,1);
% % idxTest = ~idxTrain;
% 
% k=1;
% 
% b = ridge(y,X,k,0);
% hold on
% yhat = b(1) + X*b(2:end);
% MSE = mean((y-yhat).^2);
% text(200,1.72,["MSE: ", num2str(MSE)])
% coefarray = [];
% meanyhat = [];
% for i=1:length(yhat)-1
%    
%     coef = yhat(i)/yhat(i+1);
%     coefarray = [coefarray coef];
% %     coefarray = reshape(transpose(coefarray),[53,5])
%     meanyhat = mean(coefarray);
%    
% end
% 
% 
% plot(X,y,'b-')% reference line
% 
% yhat = b(1) + X1*b(2:end);
% for i = 54:length(yhat)
%    
%     yhat(i) = yhat(i-1)/meanyhat;
%     
% end
% plot(X1,yhat,'r--*')
% 
% xline(1000,'-',{'Known Battery','Capacity till', '1000 seconds'})
% yline(1.736,'-',{' Wasted 6.54% (SOC)','is prior knowledge'})
% 
% xline(3690)
% xlabel('Time (sec)')
% ylabel('Predicted Capacity (Ahr)')
% hold on
% title("Prediction of SOC Given Scarce Prior Knowledge")
% legend("Actual","Predicted")

%% Predicted Useful Time after 1000 Seconds with multi-colinearity Ridge Regression with lambda 1
a1 = load_c{1};
b1 = load_v{1};
c1 = measured_c{1};
d1 = temperature{1};
e1 = time{1};
f1 = measured_v{1};
g1 = transpose(cell2mat(capacity));
X = [a1(1:54)' b1(1:54)' c1(1:54)' d1(1:54)' nonzeros((e1<1000)'.*e1') f1(1:54)'];
y = g1(1:54); %1000 seconds
X1 = [a1' b1' c1' d1' e1' f1'];
y1 = g1;
% n = length(y);
% rng('default') % For reproducibility
% c = cvpartition(n,'HoldOut',0.3);
% idxTrain = training(c,1);
% idxTest = ~idxTrain;
subplot(2,1,1);
k=1;

b = ridge(y,X,k,0);
hold on;
yhat = b(1) + X*b(2:end);
MSE = mean((y-yhat).^2);
text(400,1.70,["MSE: ", num2str(MSE)])
dim = [0.1 .74 .25 .15];
% annotation('ellipse',dim, 'Color','red')
coefarray = [];
meanyhat = [];
for i=1:length(yhat)-1 % Unsupervised part
   for j=1:1
    coef = yhat(i,j)/yhat(i+1,j);
    coefarray(i,j) = coef;
%     coefarray = reshape(transpose(coefarray),[53,5])
    meanyhat = mean(coefarray);
   end
end

yhat = b(1) + X1*b(2:end);

for i = 54:length(yhat)
    for j=1:1
    yhat(i,j) = yhat(i-1,j)/meanyhat(j);
    end
end
X_true = [e1(1:168)'];
y_true = g1(1:168);

plot(X,y,'b-', X1,yhat,'r--',X_true(54:end),y_true(54:end),'b--')

MSE = mean((g1-yhat(1:168)).^2);
text(3050,1.70,["MSE: ", num2str(MSE)])
dim = [0.1 .74 .35 .15];

xline(1000,'-',{'Known Battery','Capacity till', '1000 seconds'})
yline(1.736,'-',{' Wasted 6.54% (SOC)','is prior knowledge'})
xline(3690)
legend("Actual","Predicted")
xlabel('Time (sec)')
ylabel('Predicted Capacity (Ahr)')
title("Prediction of State-of-charge Given Scarce Prior Knowledge")


%% Predicted Useful Time after 1500 Seconds with multi-colinearity Ridge Regression with lambda 1

a1 = load_c{1};
b1 = load_v{1};
c1 = measured_c{1};
d1 = temperature{1};
e1 = time{1};
f1 = measured_v{1};
g1 = transpose(cell2mat(capacity));
X = [a1(1:82)' b1(1:82)' c1(1:82)' d1(1:82)' nonzeros((e1<1500)'.*e1') f1(1:82)'];
y = g1(1:82);
X1 = [a1' b1' c1' d1' e1' f1'];
y1 = g1;
% n = length(y);
% rng('default') % For reproducibility
% c = cvpartition(n,'HoldOut',0.3);
% idxTrain = training(c,1);
% idxTest = ~idxTrain;
subplot(2,1,2);
k=1;
b = ridge(y,X,k,0);
hold on;
yhat = b(1) + X*b(2:end);
MSE = mean((y-yhat).^2);
text(650,1.5,["MSE: ", num2str(MSE)])
dim = [0.12 .21 .3 .2];
% annotation('ellipse',dim, 'Color','red')
coefarray = [];
meanyhat = [];
for i=1:length(yhat)-1
   for j=1:1
    coef = yhat(i,j)/yhat(i+1,j);
    coefarray(i,j) = coef;
%     coefarray = reshape(transpose(coefarray),[53,5])
    meanyhat = mean(coefarray);
   end
end

yhat = b(1) + X1*b(2:end);
for i = 82:length(yhat)
    for j=1:1
    yhat(i,j) = yhat(i-1,j)/meanyhat(j);
    end
end
X_true = [e1(1:168)'];
y_true = g1(1:168);

plot(X,y,'b-', X1,yhat,'r--',X_true(82:end),y_true(82:end),'b--')
MSE = mean((g1-yhat(1:168)).^2);
text(3050,1.5,["MSE: ", num2str(MSE)])
dim = [0.12 .21 .35 .2];
hold on
xline(1500,'-',{'Known Battery','Capacity till', '1500 seconds'})
yline([1.55948156681842],'-',{' Wasted 19.05% (SOC)','is prior knowledge'})
xline(3690)
legend("Actual","Predicted")
xlabel('Time (sec)')
ylabel('Predicted Capacity (Ahr)')
hold on
title("Prediction of State-of-charge Given Scarce Prior Knowledge")

%% For General Usage
% Run regression learner toolbox, use X1y1 for reproducing the results. y1
% is the response, x1 is the predictors, use cross validation as 5 because
% of relatively small dataset with sample for around 170, train all
% regression without PCA

a1 = load_c{1};
b1 = load_v{1};
c1 = measured_c{1};
d1 = temperature{1};
e1 = time{1};
f1 = measured_v{1};

X1y1 = [a1(3:168)' b1(3:168)' c1(3:168)' d1(3:168)' e1(3:168)' f1(3:168)' g1(3:end)]; %For the regression learner toolbox, includes predictiors and response
X1 = [a1(3:168)' b1(3:168)' c1(3:168)' d1(3:168)' e1(3:168)' f1(3:168)'];
y1 = g1(3:end);




