// Logistic regression model, joint
data {
  int<lower=0> N; // Number of observations
  array[N] int<lower=0, upper=1> y; // Outcome variable (1 for improved, 0 for not improved)
  matrix[N, 2] X; // Predictor matrix (including baseline temp and ESR)
}

parameters {
  real alpha; // Intercept
  real beta1; // First regression coefficient
  real beta2; // Second regression coefficient
}

model {
  // Priors
  alpha ~ normal(5, 20);
  beta1 ~ normal(0, 10); // Own prior for beta[1]
  beta2 ~ normal(0, 5);  // Own prior for beta[2]

  // Logistic regression
  y ~ bernoulli_logit(alpha + X * to_vector({beta1, beta2}));
}

generated quantities {
  vector[N] y_prob = inv_logit(alpha + X * to_vector({beta1, beta2}));
}
