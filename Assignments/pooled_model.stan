data {
  int<lower=0> N_observations;    // Number of observations
  vector[N_observations] weight;  // Observed weights
}

parameters {
  real mean_weight;               // Common mean weight for all chicks
  real<lower=0> sd_weight;        // Common standard deviation of weights for all chicks
}

model {
  // Priors
  mean_weight ~ normal(750, 83);  // Here, you would adjust the prior to your problem's specifics
  sd_weight ~ exponential(.02);   // Weakly informative prior for the common standard deviation

  // Likelihood
  weight ~ normal(mean_weight, sd_weight);
}

generated quantities {
  real weight_pred;       // A predicted weight from the posterior predictive distribution
  real mean_pred;         // A predicted mean weight (for illustrative purposes)

  // Sample from the (posterior) predictive distribution for a new observation
  weight_pred = normal_rng(mean_weight, sd_weight);

  // Construct samples of the predicted mean weight
  mean_pred = normal_rng(mean_weight, sd_weight);
}
