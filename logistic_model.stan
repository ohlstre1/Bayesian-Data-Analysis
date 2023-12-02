data {
  int<lower=0> N; // Number of observations
  array[N] int<lower=0, upper=1> y; // Outcome variable (1 for improved, 0 for not improved)
  matrix[N, 2] X; // Predictor matrix (including baseline temp and ESR)
}

parameters {
  real alpha; // Intercept
  vector[2] beta; // Regression coefficients

}

model {
  // Priors
  alpha ~ normal(5, 20);
  beta ~ normal(5, 20);

  // Logistic regression
  y ~ bernoulli_logit(alpha + X * beta);
}

generated quantities {
  vector[N] y_prob = inv_logit(alpha + X * beta);
  
}
