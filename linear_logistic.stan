//  Linear Logistic regression model 
data {
  int<lower=0> N; // Number of observations
  array[N] int<lower=0, upper=1> y; // Outcome variable (1 for improved, 0 for not improved)
  matrix[N, 2] X; // Predictor matrix (including baseline temp and ESR)
  real beta1_prior_mean;
  real beta2_prior_mean;
  real beta1_prior_sd;
  real beta2_prior_sd;
}

parameters {
  real alpha; // Intercept
  real beta1; // Tempeture
  real beta2; // ESR
}

model {
  // Priors
  beta1 ~ normal(beta1_prior_mean, beta1_prior_sd); // Own prior for beta[1] temp
  beta2 ~ normal(beta2_prior_mean, beta2_prior_sd);  // Own prior for beta[2] esr

  // Logistic regression
  y ~ bernoulli_logit(alpha + X * to_vector({beta1, beta2}));
}

generated quantities {
  vector[N] y_prob = inv_logit(alpha + X * to_vector({beta1, beta2}));
}



