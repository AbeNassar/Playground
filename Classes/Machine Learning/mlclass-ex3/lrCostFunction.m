function [J, grad] = lrCostFunction(theta, X, y, lambda)
%LRCOSTFUNCTION Compute cost and gradient for logistic regression with 
%regularization
%   J = LRCOSTFUNCTION(theta, X, y, lambda) computes the cost of using
%   theta as the parameter for regularized logistic regression and the
%   gradient of the cost w.r.t. to the parameters. 

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));

h = sigmoid(X*theta);

J = sum(  (y-1).*log(1-h) - y.*log(h) )/m ...    % unregularized cost
    + lambda/(2*m)*(theta(2:end)'*theta(2:end)); % regulatization term

grad = X'*(h-y)/m + [0; lambda/m*theta(2:end)];

% =============================================================

grad = grad(:);

end
