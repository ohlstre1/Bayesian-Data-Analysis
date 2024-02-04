data {
  int<lower=0> N_observations;
  int<lower=0> N_diets;
  array[N_observations] int diet_idx; // Pair observations to their diets.
  vector[N_observations] weight;
  real mean_prior;
  real sigma_prior;
}

parameters {
  real mu_0;
  vector<lower=0>[N_diets] sigma_0;

  
  vector[N_diets] mean_diet;
  real<lower=0> sd_diet;

}

model {
  mu_0 ~ normal(mean_prior, sigma_prior);
  sigma_0 ~  exponential(0.02);
  
  mean_diet ~ normal(mu_0, sigma_0);
  sd_diet ~ exponential(0.02);

  weight ~ normal(mean_diet[diet_idx], sd_diet);
}

generated quantities {
  real weight_pred;
  real mean_five;
  real sd_diets = sd_diet;

  weight_pred = normal_rng(mean_diet[4], sd_diet);

  mean_five = normal_rng(mu_0, sd_diet);
}
