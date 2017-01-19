clear all; close all; clc;

PATH = '/Users/Abe/Documents/MATLAB/Neural Nets/Assignments/01-The perceptron learning algorithm';
cd(PATH)

load dataset1

w = learn_perceptron(neg_examples_nobias,pos_examples_nobias,w_init,w_gen_feas);
% This example is linearly seperable. It took 5 iterations to complete.

%%
clear all; close all; clc;

load dataset2

w = learn_perceptron(neg_examples_nobias,pos_examples_nobias,w_init,w_gen_feas);
% not seperable.

%%
clear all; close all; clc;

load dataset3

w = learn_perceptron(neg_examples_nobias,pos_examples_nobias,w_init,w_gen_feas);
% Is linearly seperable. It took 9 iterations to complete.

%%
clear all; close all; clc;

load dataset4

w = learn_perceptron(neg_examples_nobias,pos_examples_nobias,w_init,w_gen_feas);
% Not linearly seperable