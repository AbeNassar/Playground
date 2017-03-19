clear all; close all; clc;
%% Generating Random Data
nSamples = 10^6;
nFeatures = 5;

realWeights = unifrnd(-1, 1, nFeatures, 1);

X = [ones(nSamples,1), randi([-10, 10], nSamples, nFeatures-1)];
y = X*realWeights >= 0;

%% Training Perceptron
w = zeros(nFeatures,1);

y_hat = X*w >= 0;
startAcc = sum(y==y_hat)/nSamples;
for i = 1:nSamples
  if (X(i,:)*w>=0 && y(i)==0)
    w = (w - X(i,:)');
  elseif (X(i,:)*w<0 && y(i)==1)
    w = (w + X(i,:)');   
  end
end

y_hat = X*w >= 0;
accuracy = sum(y==y_hat)/nSamples;

%%
% Accuracy
display(sprintf('Accuracy with no training: %0.2f', startAcc))
display(sprintf('Accuracy after training:   %0.2f\n', accuracy))


% normalized wights
display('Normalized Aprroximated Weights:')
strtrim(sprintf('%0.3f  ', w/norm(w)))

display('Normalized Real Weights:')
strtrim(sprintf('%0.3f  ', realWeights/norm(realWeights)))

