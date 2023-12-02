data {
  int<lower=0> N; // Number of observations
  int<lower=0> G; // Number of groups
  int<lower=1, upper=G> group[N]; // Group identifier for each observation
  array[N] int<lower=0, upper=1> y; // Outcome variable (1 for improved, 0 for not improved)
  matrix[N, 2] X; // Predictor matrix (including baseline temp and ESR)
}

parameters {
  real alpha; // Global Intercept
  vector[2] beta; // Regression coefficients
  vector[G] alpha_g; // Group-specific intercepts
  real<lower=0> sigma_alpha; // Standard deviation of group intercepts

}

model {
  // Priors
  alpha ~ normal(0, 10);
  beta ~ normal(0, 10);
  alpha_g ~ normal(0, sigma_alpha);
  sigma_alpha ~ cauchy(0, 5);


  for (n in 1:N)
    y[n] ~ bernoulli_logit(alpha + alpha_g[group[n]] + X[n] * beta);
}

generated quantities {
  vector[N] y_prob;

  for (n in 1:N)
    y_prob[n] = inv_logit(alpha + alpha_g[group[n]] + X[n] * beta);
}
