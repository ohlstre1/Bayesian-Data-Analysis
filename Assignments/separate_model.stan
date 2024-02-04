data {
  int<lower=0> N_observations;
  int<lower=0> N_diets;
  array[N_observations] int diet_idx; // Pair observations to their diets.
  vector[N_observations] weight;
  real mean_prior;
  real sigma_prior;
}

parameters {
  // Average weight of chicks with a given diet.
  vector[N_diets] mean_diet;

  // Standard deviation of weights observed among chicks sharing a diet.
  vector<lower=0>[N_diets] sd_diet;
}

model {
  // Priors
  for (diet in 1:N_diets) {
    mean_diet[diet] ~ normal(mean_prior, sigma_prior);
    sd_diet[diet] ~ exponential(.02);
  }

  weight ~ normal(mean_diet[diet_idx], sd_diet[diet_idx]);
}

generated quantities {
  real weight_pred;
  real mean_five;
  real sd_diets = sd_diet[4];

  // Sample from the (posterior) predictive distribution of the fourth diet.
  weight_pred = normal_rng(mean_diet[4], sd_diet[4]);

  // Construct samples of the mean of the fifth diet.
  // We only have the prior...
  mean_five = normal_rng(mean_prior, sigma_prior);
}
