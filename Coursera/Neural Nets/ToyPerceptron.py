# -*- coding: utf-8 -*-
"""
Toy Example of a Perceptron

Created on Sat Dec 31 18:42:21 2016

@author: Abe
"""
import matplotlib.pyplot as plt
import numpy as np
import numpy.random as r

# Assigning number of features and training examples.
nTrainingExamples = 10**6
nTestExamples = 10**3
nFeatures = 2

# Assigning random weights to be the true weights
trueWeights = r.uniform(-10, 10, [nFeatures,1])

# Creating Random Test and Training Data 
X_train = r.uniform(-10, 10, [nTrainingExamples, nFeatures])
y_train = (X_train.dot(trueWeights) >= 0).astype(int)

X_test = r.uniform(-10, 10, [nTestExamples, nFeatures])
y_test = (X_test.dot(trueWeights) >= 0).astype(int)


# Initializing Weights
w = np.zeros([nFeatures,1])

# Training Perceptron
for i in range(nTrainingExamples):
  yi_hat = X_train[i,:].dot(w)
  if yi_hat >=0 and y_train[i]==0:
    w = w - X_train[i,:].reshape([nFeatures,1])
  elif yi_hat < 0 and y_train[i]==1:
    w = w + X_train[i,:].reshape([nFeatures,1])

# Calculating test outputs
y_hat = (X_test.dot(w) >= 0).astype(int)

# Accuracy of the test set.
np.mean(y_hat == y_test)

# Plotting the Data
plt.scatter(X_test[:,0], X_test[:,1], c=y_hat.T)
plt.plot([-10, -10*w[1,0]+w[1,0]], [10, 10*w[0,0]+w[1,0]], 'r-')
plt.show()