function plotData(X, y)
%PLOTDATA Plots the data points X and y into a new figure 
%   PLOTDATA(x,y) plots the data points with + for the positive examples
%   and o for the negative examples. X is assumed to be a Mx2 matrix.

% Create New Figure
figure; hold on;

% ====================== YOUR CODE HERE ======================
% Instructions: Plot the positive and negative examples on a
%               2D plot, using the option 'k+' for the positive
%               examples and 'ko' for the negative examples.
%

admt = find(y==1); % Find all rows of admitted students
nadmit = find(y==0); % Find all rows of non-admitted students


plot(X(admt,1), X(admt,2), 'b+', 'LineWidth',2,'MarkerSize',7);
plot(X(nadmit,1), X(nadmit,2), 'ko', 'LineWidth',1,'MarkerSize',7,'MarkerFaceColor', 'r');

% =========================================================================



hold off;

end
