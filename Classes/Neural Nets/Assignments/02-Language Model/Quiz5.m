clear all; close all; clc;
load('data.mat')

[train_x, train_t, valid_x, valid_t, test_x, test_t, vocab] = load_data(100);

%% Question 2
% Leave all default values train for 10 epochs

model = train(10, 0.1);

%% Question 3
% Change learning rate to 100.

model = train(10, 100);


%%


%% Question 5
ModelA = train(1, 0.001);
% Finished Training.
% Final Training CE 4.431
% 
% Running validation ...
% Final Validation CE 4.386
% 
% Running test ...
% Final Test CE 4.393
% Training took 19.42 seconds

ModelB = train(1, 0.1);
% Finished Training.
% Final Training CE 3.964
% 
% Running validation ...
% Final Validation CE 3.310
% 
% Running test ...
% Final Test CE 3.311
% Training took 21.39 seconds

ModelC = train(1, 10.0);
% Finished Training.
% Final Training CE 4.704
% 
% Running validation ...
% Final Validation CE 4.662
% 
% Running test ...
% Final Test CE 4.668
% Training took 21.70 seconds

ModelA = train(10, 0.001);
% Finished Training.
% Final Training CE 4.378
% 
% Running validation ...
% Final Validation CE 4.380
% 
% Running test ...
% Final Test CE 4.386
% Training took 219.94 seconds

ModelB = train(10, 0.1);
% Finished Training.
% Final Training CE 2.538
% 
% Running validation ...
% Final Validation CE 2.605
% 
% Running test ...
% Final Test CE 2.618
% Training took 224.04 seconds

ModelC = train(10, 10.0);
% Finished Training.
% Final Training CE 4.665
% 
% Running validation ...
% Final Validation CE 4.662
% 
% Running test ...
% Final Test CE 4.668
% Training took 227.51 seconds

%% Question 6, 7 & 8
% Model A: 5 dimensional embedding, 100 dimensional hidden layer
% Model B: 50 dimensional embedding, 10 dimensional hidden layer
% Model C: 50 dimensional embedding, 200 dimensional hidden layer
% Model D: 100 dimensional embedding, 5 dimensional hidden layer 

ModelA = train(10, 0.1, 5, 100);
% Finished Training.
% Final Training CE 2.809
% 
% Running validation ...
% Final Validation CE 2.830
% 
% Running test ...
% Final Test CE 2.838
% Training took 157.19 seconds

%%
ModelB = train(10, 0.1, 50, 10);
% Finished Training.
% Final Training CE 3.006
% 
% Running validation ...
% Final Validation CE 3.019
% 
% Running test ...
% Final Test CE 3.021
% Training took 141.23 seconds


%%
ModelC = train(10, 0.1, 50, 200);
% Finished Training.
% Final Training CE 2.533
% 
% Running validation ...
% Final Validation CE 2.599
% 
% Running test ...
% Final Test CE 2.612
% Training took 232.47 seconds

%%
ModelD = train(10, 0.1, 100, 5);
% Final Training CE 3.227
% 
% Running validation ...
% Final Validation CE 3.237
% 
% Running test ...
% Final Test CE 3.233
% Training took 166.55 seconds

%% Question 09
Model9A = train(5, 0.1, 50, 200, 0.0);
% Finished Training.
% Final Training CE 4.074
% 
% Running validation ...
% Final Validation CE 4.057
% 
% Running test ...
% Final Test CE 4.060
% Training took 75.55 seconds

%%
Model9B = train(5, 0.1, 50, 200, 0.5);
% Finished Training.
% Final Training CE 3.790
% 
% Running validation ...
% Final Validation CE 3.728
% 
% Running test ...
% Final Test CE 3.731
% Training took 79.91 seconds

%%
Model9C = train(5, 0.1, 50, 200, 0.9);
% Finished Training.
% Final Training CE 3.274
% 
% Running validation ...
% Final Validation CE 3.271
% 
% Running test ...
% Final Test CE 3.268
% Training took 75.92 seconds

%% Question 10
Model10 = train(10, 0.1, 50, 200, 0.9);
% Finished Training.
% Final Training CE 2.537
% 
% Running validation ...
% Final Validation CE 2.607
% 
% Running test ...
% Final Test CE 2.619
% Training took 232.19 seconds

display_nearest_words('could', Model10, 10)

%%
% senLen = 50;
% sent = cell(1,senLen);
% sent(1:3) = {'john','might', 'be'};
% 
% for i = 0:senLen-1,
%   next_word = predict_next_word(sent{i+1}, sent{i+2}, sent{i+3}, model, 50);
%   sent{4+i} = next_word;
% end
% 
% sent
% 
% %%
% senLen = 50;
% sent = cell(1,senLen);
% sent(1:3) = {'you','like', 'it'};
% 
% for i = 0:senLen-1,
%   next_word = predict_next_word(sent{i+1}, sent{i+2}, sent{i+3}, model, 50);
%   sent{4+i} = next_word;
% end
% 
% sent