data {
  int<lower=0> N;   // number of data points
  vector[N] x;  // data
  vector[2] mu;  // Mean vector
  array[N] int<lower=0> n;
  array[N] int<lower=0> y;
  matrix[2,2] Sigma;  // Covariance matrix
}

parameters {
  vector[2] theta;  // The parameters we want to estimate
}

model {
  theta ~ multi_normal(mu, Sigma);  // Joint normal prior
  for (i in 1:N) {
    y[i] ~ binomial_logit(n[i],theta[1] + theta[2]*x[i]);
  }
}
