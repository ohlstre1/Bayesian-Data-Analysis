data {
  int<lower=0> N;   // number of data points
  vector[N] x;  // data
  vector[2] mu;  // Mean vector
  cov_matrix[2] Sigma;  // Covariance matrix
}

parameters {
  vector[2] theta;  // The parameters we want to estimate
}

model {
  theta ~ multi_normal(mu, Sigma);  // Joint normal prior
}
