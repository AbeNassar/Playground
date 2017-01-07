Monte Carlo Simulation
================
Abraham Nassar
29 October 2016

This document will contain various examples of Monte Carlo simulation.

1) Monte Carlo Integration
==========================

The first example be to use Monte Carlo integration, which states that because of the law of large numbers, \[
  \int_{-\infty}^{\infty}h(x)\cdot f_{X}(x)dx 
    = \mathbb{E}\big( h(x) \big) 
    \approx {1 \over N}\sum_{i=1}^N h(x_i)
\] Where \(x_i\) are samples drawn for the distribution corresponding to the PDF, \(f_X(x)\) and \(N\) is the total number of samples drawn.

a) Approximating \(\int_0^1\left ( 1-x^2\right)^{3/2}dx\)
---------------------------------------------------------

Suppose we want to approximate the integral \[
  I = \int_0^1\left ( 1-x^2\right)^{3/2}dx
\] Since we want to integrate from 0 to 1 a convenient choice for \(f_X\) to be the pdf of the uniform distribution on \([0, 1]\) because then \(f_X(x)=1\) for each x between 0 and 1, which then leaves \(h(x) = ( 1-x^2)^{3/2}\). Let's define \(h(x)\) in R.

``` r
h <- function(x){
  if(x>1 | x<0){ # set h(x) to zero if x is not in [0,1]
    return(0)
  }else{ 
    return( (1-x^2)^{3/2} )
  }
}
```

Next let's choose to take \(N=100\) samples to approximate the integral. We can draw 100 samples from the uniform distribution.

``` r
N = 100
x <- runif(N, 0, 1)
```

Once we have our samples we need to plug them into \(h(x)\) and find the average.

``` r
h_i <- sapply(x, h)

I.100 = sum(h_i)/N
```

This return a value of \(I\approx\) 0.5407839. The true value of the integral is \(3\pi/16\approx\) 0.5890486, so we are close, but it's not great.

Lets try again with more simulations. Lets repeat the process with \(N=1000\).

``` r
N = 1000
x_i <- runif(N, 0, 1)
h_i <- sapply(x_i, h)

I.1k = sum(h_i)/N
```

This time we have \(I\approx\) 0.5928041.

Lets try again with more simulations. Lets repeat the process with \(N=10,000\).

``` r
N = 10000
x_i <- runif(N, 0, 1)
h_i <- sapply(x_i, h)

I.10k = sum(h_i)/N
```

Here we get \(I\approx\) 0.590772.

Note that since the \(x_i\)s are random it is possible to get a better approximate from \(N=100\) than \(N=10,000\), but generally you will have numbers distributed around the real value and the variance of those number should decrease as you increase \(N\), the number of simulations. I.e. Larger values of \(N\) give better approximations more often. To show this, lets do 100 approximations of \(I\) using \(N=100,1000,10000\). Then we can use a box plot to see the difference.

``` r
# This function will approximate I given a value for N1:number of iterations.
approximateI <- function(N1){
  x_n <- runif(N1, 0, 1)
  h_n <- sapply(x_n, h)
  I.N = sum(h_n)/N1
  
  return(I.N)
}

# 100 approximations for I with N=100
I_100 = sapply(rep(100,100), approximateI)

# 1,000 approximations for I with N=1000
I_1k = sapply(rep(1000,100), approximateI)

# 10,000 approximations for I with N=10,000
I_10K = sapply(rep(10000,100), approximateI)

# Creating Data Frame with all the data. 
df = data.frame(I_100,I_1k,I_10K)
colnames(df)<- c("N=100", "N=1000", "N=10,000")

# Creating Box Plot
boxplot(df, xlab="Number of Iterations", 
        ylab="Value of Approximation",
        main="Box Plots of Approximation of the Integral")

# Adding red line to represent the correct value of I
abline(h = 3*pi/16, col="red",lwd=2)

# Adding legend
legend('topright', "True value", col="red", lwd=2, bg="white")
```

![](MonteCarlo_Simulations_files/figure-markdown_github/unnamed-chunk-7-1.png)

So each box represents 100 simulations of \(I\) for a given \(N\). The red line is at \(3\pi/16\), corresponds true value of the integral. Notice all the boxplots are centered at the correct value, however as we increase the number of itereations \(N\), we get less varaiance in the sample. i.e. As \(N\) increases, the varaince of the sample decreases.

b) Approximating \(\int_0^\infty {x(1+x^2)^{-2}} dx\)
-----------------------------------------------------

For this example, we can't use \(f_X(x)\) as the uniform distribution because the integral limits are between 0 and infinity. We can choose \(f_X\) to be the exponential distribution's PDF with \(\lambda =1\), which means \(f_X(x) = e^{-x}\). Now we can write the integral as
\begin{align*}
  I &= \int_0^\infty {x(1+x^2)^{-2}} dx\\
    &= \int_0^\infty {x(1+x^2)^{-2}} {e^{-x}\over e^{-x}}dx\\
    &= \int_0^\infty {x(1+x^2)^{-2}\over e^{-x}} \cdot {e^{-x}}dx\\
    &= \int_0^\infty {x(1+x^2)^{-2}\over e^{-x}}\cdot  f_X(x) dx
\end{align*}
This implies that \(h(x)={x(1+x^2)^{-2}/ e^{-x}}\). So lets define this in R.

``` r
h <- function(x){
  if(x<0){
    return(0)
  }else{
    return(x*(1+x^2)^(-2)/exp(-x))
  }
}
```

Now we can sun some simulations.

``` r
N = 100
x_i <- rexp(N, rate=1)
h_i <- sapply(x_i, h)
I.100 = sum(h_i)/N

N = 1000
x_i <- rexp(N, rate=1)
h_i <- sapply(x_i, h)
I.1k = sum(h_i)/N

N = 10000
x_i <- rexp(N, rate=1)
h_i <- sapply(x_i, h)
I.10k = sum(h_i)/N
```

This gives \(I\approx\) 0.506985 for \(N=100\), \(I\approx\) 0.4997667 for \(N=1000\) and \(I\approx\) 0.4932682 for \(N=10,000\). In fact, the true value of \(I\) is \(1/2\), so these values are pretty good. Let's look at box plots of 100 Simulations with \(N=100\), \(N=1,000\) and \(N=10,000\).

``` r
approximateI <- function(N1){
  x_1 <- rexp(N1, rate=1)
  h_1 <- sapply(x_1, h)
  I.1 <- sum(h_1)/N1

  return(I.1)
}

# Running simulations
I_100 = sapply(rep(100,100), approximateI)
I_1k = sapply(rep(1000,100), approximateI)
I_10k = sapply(rep(10000,100), approximateI)

# Creating Data Frame with all the data. 
df = data.frame(I_100,I_1k,I_10k)
colnames(df)<- c("N=100", "N=1000", "N=10,000")

# Creating Box Plot
boxplot(df, xlab="Number of Iterations",
        ylab="Value of Approximation",
        main="Box Plots of Approximation of the Integral",
        ylim=c(0.4,0.6))

# Adding red line to represent the correct value of I
abline(h = 1/2, col="red",lwd=2)

# Adding legend
legend('topright', "True value", col="red", lwd=2, bg="white")
```

![](MonteCarlo_Simulations_files/figure-markdown_github/unnamed-chunk-11-1.png)

Again, as expected, we can see that as \(N\) increases, we get better approximations.

c) Approximating \(\int_{-\infty}^{\infty}e^{-x^2}dx\)
------------------------------------------------------

For this integral, we want to find a probability distribution that is defined on all of \(\mathbb R\) since the integral is between negative infinity and positive infinity. Also notice that we have a \(e^{-x^2}\) term, which hints that the normal PDF might be a good choice for \(f_X(x)\) since it also has a \(e^{-x^2}\) term. Recall that \[
  f_X(x|\mu,\sigma^2)
    ={1\over\sqrt{2\sigma^2\pi}}e^{-{(x-\mu)^2\over 2\sigma^2}}
\] So if we choose \(\mu=0\) and \(\sigma^2 = 1/2\), we get \[
  f_X(x|0,1/2)
    ={1\over\sqrt{\pi}}e^{-{x^2}}
\]

\begin{align*}
   I &= \int_{-\infty}^{\infty}e^{-x^2}dx \\
     &= \int_{-\infty}^{\infty}e^{-x^2}{{1\over\sqrt{\pi}}e^{-{x^2}}\over {1\over\sqrt{\pi}}e^{-{x^2}}}dx \\
     &= \int_{-\infty}^{\infty}{e^{-x^2}\over {1\over\sqrt{\pi}}e^{-{x^2}}}f_X(x)dx \\
     &= \int_{-\infty}^{\infty}\sqrt\pi f_X(x)dx
\end{align*}
Therefore, \(h(x)=\sqrt\pi\). We can define h in R as a function (`h <- function(x) sqrt(pi)`) but no matter what \(x_i\) we plug into \(h(x)\) it will always be \(h(x_i)=\sqrt\pi\). Therefore \(N\) simulations will just give back \(N\) values of \(\sqrt\pi\) and the average with then be is \(\sqrt\pi\). Thus, we don't even need to run code, we have an exact answer. But for completeness here is some code:

``` r
N = 100

h = function(x) return(sqrt(pi))
  
x_i = rnorm(N, mean=0, sd=sqrt(1/2))
h_i = sapply(x_i, h)

I = sum(h_i)/N
```

This gives us a value of \(I\approx\) 1.7724539. The true value is \(\sqrt\pi\approx\) 1.7724539, which as we can see is a perfect match.

2) Importance Sampling
======================

We want to sample \(\mathbb P(X>25)\) for \(X\sim{\chi_3}^2\). So we want to calculate \(\mathbb P(X>25) = \int_{25}^\infty f_X(x) dx\), where \(f_X\) is the pdf for \(X\). Using the Monte Carlo approximation, we have \[
  \mathbb P(X>25) = \int_{25}^\infty f_X(x) dx 
            \approx {1\over n} \sum_{i=1}^n f_X(x>25)
\] Assuming we can't sample from the cdf directly, we can instead sample from the exponential distributions translated by 25.

``` r
approximateChiSqr = function(nSimulations, df=3, valGreaterThan=25){
  X = rexp(nSimulations,rate=1)+25
  return(mean(dchisq(X, df=df)/dexp(X-valGreaterThan)))
}
```

To see how accurate this simulation is, lets calculate a large number of approximates and look at the box plots

``` r
# Running simulations
chiSq_100 = sapply(rep(100,100), approximateChiSqr)
chiSq_1k = sapply(rep(1000,100), approximateChiSqr)
chiSq_10k = sapply(rep(10000,100), approximateChiSqr)

chiSqSims = data.frame(chiSq_100, chiSq_1k, chiSq_10k)
colnames(chiSqSims)<- c("N=100", "N=1000", "N=10,000")

# Creating Box Plot
boxplot(chiSqSims, xlab="Number of Iterations",
        ylab="Approximation of P(X>25)",
        main="Box Plots of Approximation of P(X>25)",
        ylim=c(0.75*10^(-5), 2.5*10^(-5)))

# Adding red line to represent the correct value of I
abline(h = pchisq(25, df=3, lower.tail = F), col="red",lwd=2)

# Adding legend
legend('topright', "True value", col="red", lwd=2, bg="white")
```

![](MonteCarlo_Simulations_files/figure-markdown_github/unnamed-chunk-15-1.png)

3) Rejection Sampling
=====================

``` r
nSims = 1000

X = c()
while(length(X) < nSims){
  u = runif(1, min=0 ,max=1)
  y1 = rexp(1, rate=1)
  y2 = rexp(1, rate=1)
  
  if(y2 >= (y1-1)^2/2){
    if(u<0.5) y = -y1 else y = y1 
    X = append(X, y)
  }
}
hist(X, probability=T, breaks=80, col="lightblue", 
     main="Histogram of X~N(0,1)",
     xlim=c(-3.5, 3.5), ylim=c(0,0.5))
lines(seq(-3.5, 3.5, by=0.1), dnorm(seq(-3.5, 3.5, by=0.1)), 
      col="red", lwd=3, xlim=c(-3.5, 3.5))
```

![](MonteCarlo_Simulations_files/figure-markdown_github/sampling%20exponential-1.png)

We can see the histogram looks good, hoever we can also check this with a Q-Q plot

``` r
library(car)

qqPlot(X)
```

![](MonteCarlo_Simulations_files/figure-markdown_github/unnamed-chunk-17-1.png)

The qqPlot shows that most, if not all points lie within the confidence bands, hence the sampling is normally distributed.

``` r
nSims = 10000

X = c()
while(length(X) < nSims){
  u = runif(1, min=0 ,max=1)
  y1 = rexp(1, rate=1)
  y2 = rexp(1, rate=1)
  
  if(y2 >= (y1-1)^2/2){
    if(u<0.5) y = -y1 else y = y1 
    X = append(X, y)
  }
}
hist(X, probability=T, breaks=100, col="lightblue", 
     main="Histogram of X~N(0,1)",
     xlim=c(-3.5, 3.5), ylim=c(0,0.5))
lines(seq(-3.5, 3.5, by=0.1), dnorm(seq(-3.5, 3.5, by=0.1)), 
      col="red", lwd=3, xlim=c(-3.5, 3.5))
```

![](MonteCarlo_Simulations_files/figure-markdown_github/unnamed-chunk-18-1.png)

Comparing this historgram to the previous one, we see that with more samples, the distribution is a better looking sampling of the standard normal distribution.

Example: Drawing Randomly From \(f(x) = 20x(1-x)^3\)
----------------------------------------------------

The idea behind rejection sampling is that we want to draw randomly for a distribution, with PDF \(f\) that is difficult to draw from. So what we do is we find a distribution with PDF \(g\) that we can easily draw from that bounds \(f\) from above. If we can't find such a distribution, we can look at a scalar multiple of a \(g\) that bounds it from above. In other words we want to find a distribution with PDF \(g(x)\) such that \[
  f(x) \leq M\cdot g(x) 
  \quad \text{ or }
  \quad {f(x)\over g(x)} \leq M,
  \quad \text{for some } M > 0
\]

Once we have this \(g\), we will uniformly sample values for \(x_i\) on the domain of \(f\) and we draw a random sample, \(y_i\), from the distribution corresponding to \(g(x)\). We then take that \(x_i\) and if \(f(x_i)\geq y_i\cdot M\), then we accept it as a random sample. Otherwise we discard it and repeat the process until we draw a \(x_i\) and \(y_i\) that satisfies \(f(x_i)\geq y_i\cdot M\).

4) Rejection Sampling
=====================

Example: Drawing Randomly From \(f(x)=30(x^2-2x^3+x^4)\)
--------------------------------------------------------

Assume we want to draw random samples from \(f(x)=30(x^2-2x^3+x^4)\), where \(x\in[0,1]\). Since the domain is \([0,1]\), the uniform distribution would be a good choice to sample from since it has the same support. However, if we plot \(f(x)\), we can see that it goes above the value of 1, so we need to scale the uniform distribution so that it is always above \(f(x)\).

``` r
f = function(x){
  if(x<0 | x>1){
    return(0)
  }else{
    return(30*(x^2 - 2*x^3 + x^4))
  }
}
x = 1:100/100
y = sapply(x,f)

# plotting f(x)
plot(y~x, type="l", col="blue", lwd=3)

# plotting uniform PDF
abline(h=1, lwd=3, col="red")

# Adding legend
legend('topright', c("f(x)", "Unif[0,1] PDF"), col=c("blue","red"), lwd=2, bg="white")
```

![](MonteCarlo_Simulations_files/figure-markdown_github/Plotting%20Function-1.png)

Just by looking at the plot above we can choose \(M=2\) as an upper bound but the larger we make \(M\), the more often we will have to reject the random draw and start over. So to get \(M\) as small as possible we want \(M=\max_{x\in [0,1]f(x)}\).
\begin{align*}
  0 &= {d\over dx}f(x) \\
  0 &= 30(2x - 6x^2 + 4x^3)\\
  0 &= 60x(1 - 3x + 2x^2) &\text{divide 60}\\
  0 &= x(1 - 3x + 2x^2)\\
  0 &= x(2x-1)(x-1)\\
\end{align*}
So our critical values are \(x=0, 1/2, 1\). you can verify by looking at the plot above or by plugging the values in that the maximum occurs when \(x=1/2\). That means \(M=f(1/2)=\) 1.875. Now we can do the simulation

``` r
library(ggplot2) # for better scatter plots

N = 10000  #number of samples
M = f(1/2) # Scaling factor for random draws.

X_i = c() # the draws of x_i
Y_i = c() # the draws of y_i
accepted = c() # TRUE if sample is accepted, FALSE otherwise

# to keep track of how many samples we accepted
numAccepted = 0

# We need to repeat draws until we have N draws
while( numAccepted < N ){
  # drawing simulations
  x_i = runif(1, 0, 1)
  y_i = runif(1, 0, M)
  accept = (y_i <= f(x_i))
  
  # storing simulations
  X_i = append(x_i, X_i)
  Y_i = append(y_i, Y_i)
  accepted = append(accept, accepted)
  
  numAccepted = numAccepted + as.numeric(accept)
}

# Store data in data in data frame for convinience
df=data.frame(X_i,Y_i,accepted)

# creating scatter plot of all draws with color denoting if it was accepted
rs.scatter <- qplot(X_i, Y_i, colour = accepted, data = head(df,1000))
rs.scatter + stat_function(fun=f, colour = "black", size=2) 
```

![](MonteCarlo_Simulations_files/figure-markdown_github/plotting%20draws-1.png)

In the figure above we can see all of the draws with the rejected samples in red and the accepted samples in blue. The target distribution, \(f(x)=30(x^2-2x^3+x^4)\), is also shown in black. We can see that a lot of draws were rejected. In fact for this example, 18741 draws were taken to get 10,000 accepted samples, or 46.64% of draws were rejected.

To show the accuracy of the sampling, lets look at the histagram

``` r
hist(X_i[accepted==TRUE], 
     col="lightblue", 
     breaks=50, 
     probability = TRUE,
     xlab="X_i",
     main = "Histogram of Accepted Draws") 
lines(y~x, col="red", lwd=5)

legend('topright', "f(x)", col="red", lwd=2, bg="white")
```

![](MonteCarlo_Simulations_files/figure-markdown_github/plotting%20hist-1.png)

Finally to emphasize the role of \(M\), let's look at what happens when \(M\) is too small. e.g. \(M=1\):

![](MonteCarlo_Simulations_files/figure-markdown_github/unnamed-chunk-20-1.png)

From this plot above, we can see that, if \(M\) is too small, we don't obtain enough samples to cover the distribution, thus we do not get an accurate sampling since it under-samples the portions with the highest probability.

Now let's look at when \(M\) is too large.

![](MonteCarlo_Simulations_files/figure-markdown_github/unnamed-chunk-21-1.png)

Here we used \(M=3\) and we can see that a larger number of samples are rejected. As a matter of fact, for this example 66.98% of the samples were rejected, which is significantly more than when we used the optimial value of \(M\).

5) Discrete Sampling Using The Inverse CDF
==========================================

We want to simulate sample size \(m=1000\) from \(X\) with pmf \(p(1)=0.4\), \(p(2)=0.4\) and \(p(3)=0.2\). First we define the pmf \(p\) in R.

``` r
nSamples = 1000

# Defining pmf
p = function(x){
  if(x==1){return(0.4)}
  else if(x==2){return(0.4)}
  else if(x==3){return(0.2)}
  else return(0)
}
```

Next we need to find the inverse CDF. In the case of a finite discrete function it is a simple task.

``` r
# Defining the CDF
cumulat = cumsum(sapply(1:3,p))

# Defining the invese of the CDF
inv_cdf <- function(x){
  if(x<0 | x>1){return(0)}
  else if(x<=cumulat[1]){return(1)}
  else if(x<=cumulat[2]){return(2)}
  else if(x<=cumulat[3]){return(3)}
}
```

With the inverse CDF, we can randomly sample from \(Unif[0,1]\) and apply the inverse CDF to get a sample of \(X\)

``` r
# Sampling uniform distribution
U = runif(nSamples)

# Applying inverse cdf to the sample
X = sapply(U, inv_cdf)

# Creating a Histogram
sampleSummary <- summary(as.factor(X))
barplot(sampleSummary/nSamples, col="lightblue", main="Histogram of X", 
        xlab="X", ylab="Frequency as Percent", ylim = c(0,0.5))
```

<img src="MonteCarlo_Simulations_files/figure-markdown_github/unnamed-chunk-24-1.png" style="display: block; margin: auto;" />

We can see that this gives us a distribution that we expected since 1 appears 40% of the times, 2 appears close to 40% of the time and 3 appears close to 20% of the time. The exact proportions are given in the following output:

``` r
print(sampleSummary/nSamples)
```

    ##     1     2     3 
    ## 0.403 0.400 0.197

6) Gibbs Sampling
=================

Let \(X_i\) be an exponential distribution with parameter \(\lambda = i\) for \(i=1,2,3,4,5\). We want to sample \(S = \sum_iX_i\)

``` r
nSims = 1000
burnin = 10

C=5; n=5; lambda=c(1,2,3,4,5)
X = c(2,2,2,2,2)

S = c(); # Will store the draws
nIter = 0 # counts the iterations
for(i in 1:(nSims+burnin)){
  # Choose a random index
  I = sample(1:n, 1)
  
  y_i = rexp(1,rate=lambda[I])
  a.plus = max(C - sum(X[-I]), 0) 
  
  # Replace the I-th R.V.
  X[I] = y_i + a.plus
  
  # Check to see if burn in is complete
  if(nIter >= burnin){
    S = append(S, sum(X))
  }

  nIter = nIter + 1
}

hist(S,breaks=50, probability=T, col="lightblue")
```

![](MonteCarlo_Simulations_files/figure-markdown_github/Gibbs%20sampling-1.png)