clear all;
close all;

%%%% Load datasets %%%
data_path = append(pwd,'\B0005.mat');
dataset = load(data_path);

battery = dataset.B0005.cycle;
battery = struct2cell(battery);
%data = battery(4,  6)
%plot(data{1}.Time, data{1}.Voltage_load)
%hist(data{1}.Voltage_load)
%hist(data{1}.Voltage_load)

discharge_count = 0;
for i = 1 : length(battery) 
    
    if ismember(battery(1,  i), {'discharge'}) == 1
        data = battery(4,  i);

        measured_v{discharge_count+1} = data{1}.Voltage_measured;
%         measured_v{discharge_count+1} = normalize(measured_v{discharge_count+1}, 'range');

        measured_c{discharge_count+1} = data{1}.Current_measured;

        load_v{discharge_count+1} = data{1}.Voltage_load;
%         load_v{discharge_count+1} = normalize(load_v{discharge_count+1}, 'range');

        load_c{discharge_count+1} = data{1}.Current_load;
%         load_c{discharge_count+1} = normalize(load_c{discharge_count+1}, 'range');

        temperature{discharge_count+1} = data{1}.Temperature_measured;
%         temperature{discharge_count+1} = normalize(temperature{discharge_count+1}, 'range');

        time{discharge_count+1} = data{1}.Time;

        capacity{discharge_count+1} = data{1}.Capacity;
        discharge_count = discharge_count + 1;

    end
end 

%%%%% histogram of the voltage, current , temperature, .... 
%%%%% Also finds the most ly appeared element in the specific cell array
%%%%% Actually I tried this method as a sampling, we can try other sampling
%%%%% methods which converst a N dim cell array to a single double 

%% first 2 of them should be done quickly
%% Todo : Try Gaussian outlier method rather than PCA

% We are using 2 Std
cleaned_combined_load_c = [];
for i = 1:length(load_c)
%     cleaned_combined_load_c = rmoutliers(load_c{i},'percentiles',[10 90]);
    cleaned_combined_load_c = [cleaned_combined_load_c mean(load_c{i})];
end

cleaned_combined_load_v = [];
for i = 1:length(load_v)
%     cleaned_combined_load_v = rmoutliers(load_c{i},'percentiles',[10 90]);
    cleaned_combined_load_v = [cleaned_combined_load_v mean(load_v{i})];
end

cleaned_combined_measured_c = [];
for i = 1:length(measured_c)
%     cleaned_combined_measured_c = rmoutliers(load_c{i},'percentiles',[10 90]);
    cleaned_combined_measured_c = [cleaned_combined_measured_c mean(measured_c{i})];
end

cleaned_combined_measured_v = [];
for i = 1:length(measured_v)
%     cleaned_combined_measured_v = rmoutliers(load_c{i},'percentiles',[10 90]);
    cleaned_combined_measured_v = [cleaned_combined_measured_v mean(measured_v{i})];
end

cleaned_combined_temperature = [];
for i = 1:length(temperature)
%     cleaned_combined_temperature = rmoutliers(load_c{i},'percentiles',[10 90]);
    cleaned_combined_temperature = [cleaned_combined_temperature mean(temperature{i})];
end


%% Plot measured volt vs time 
h = histogram(cleaned_combined_temperature);



%% Todo : we can try other sampling methods. (Gibb's)


% h = histogram(load_c{168});
% % Retrieve some properties from the histogram
% V = h.Values
% E = h.BinEdges
% L = zeros(1, length(V))
% [x, y] = max(V)
% L (1, y) = 1
% L = logical(L)
% % Find the centers of the bins that identified as peaks
% left = E(L)
% right = E([false L])
% center = (left + right)/2 % the whole cell array might be replaced by this value ? 
% % Plot markers on those bins
% hold on
% plot(center, V(L), 'o')


%%%% SoC persentage %%%%

% charge_per = normalize([capacity{:}], 'range');
% figure;
% hold on;
% plot(1:168, charge_per); 


%% Todo : train test split should be done (70% training data) for cross validation.




%%%% tried simple regression tree, looks like it works if the input and
%%%% labes cell array is the size.
%% Todo :  try random forest (ensemble of trees) regression. %%%%%

x = temperature{1}';
x1 = measured_v{1}';
x2 = measured_c{1}';

x3 = temperature{2}';
x4 = measured_v{2}';
x5 = measured_c{2}';

y = capacity{1} + 3*randn(size(capacity{1})) ;
x = [temperature{1}']
(load_c{1}) %gets the temperature values of 168.cell
temperature(168) %gets 168. cell of temperature

plot(1:length([capacity{:}]), [capacity{:}])
xlabel('index')
ylabel('Charge')
title('State Of Charge')



%x = [1;30;45;61;177;2;33;4;44;234;356;4;2;3;42;2;3;59;68;81;1;30;45;59;68;81]
% 
% x1 = [177;2;33;4;177;2;33;4;44;234;356;4;2;3;42;2;3;44;234;356;4;2;3;42;2;3];
% x2 = [157;2;353;4;157;2;53;4;44;534;356;4;2;53;52;2;3;44;235;556;4;252;53;42;2;3];
% y = [22,44,61,80,120,22,44,61,80,120,133,145,44,61,44,61,133,145,133,145,44,61,44,61,133,145];
% 
% tree = fitrtree([x x1 x2],y ,...
%                 'CategoricalPredictors',3,'MinParentSize',5,...
%                 'PredictorNames',{'x','x1', 'x2'});
% Ynew = predict(tree, [x3 x4 x5])

%view(tree,'Mode','graph');