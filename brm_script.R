## ------------------------------------------------------------------------------------------------------------------------
library(tidyverse)
library(brms)

# ------- Data setup --------
set.seed(10101) # Omit or change this if you like

N <- 25

x_1 <- rnorm(N)
x_2 <- rnorm(N)

beta_0 <- 1.25
beta_1 <- 1.75
beta_2 <- 2.25

mu <- beta_0 + beta_1 * x_1 + beta_2 * x_2

y <- mu + rnorm(N, mean=0, sd=1.75)

Df <- tibble(x_1, x_2, y)

# ------ Standard, non-Bayesian, linear regression -------
M_lm <- lm(y ~ x_1 + x_2, data=Df)

# ------ Bayesian linear regression ----------

# Set-up and sample from Bayesian linear model
# using defaults for more or less everything
M_bayes <- brm(y ~ x_1 + x_2, data = Df)

# Overriding defaults
M_bayes <- brm(y ~ x_1 + x_2, 
               data = Df,
               #cores = 2, # default is 1, increase if you have spare cores
               chains = 4, # 4 chains is typical, and default
               iter = 2500,
               warmup = 1000, # these are initilization etc iterations
               prior = set_prior('normal(0, 100)'), # flat prior on coefs
               seed = 101011, # for reproducibility
)

# We can view the priors of this model like this:
prior_summary(M_bayes)

# Get the model summary
summary(M_bayes)

# Plot the posteriors etc
plot(M_bayes)

# predictions with new data, with new predictors
predict(M_bayes, newdata = data.frame(x_1 = c(0, 1, 2), 
                                      x_2 = c(-1, 1, 2))
)

# We can view the stan code of this model like so:
stancode(M_bayes)

# ------ Model comparison ----------
M_bayes <- brm(y ~ x_1 + x_2, 
               data = Df,
               cores = 1, # I have a dual-core
               chains = 4, # 4 chains is typical
               iter = 2500,
               warmup = 1000, # these are initilization etc iterations
               prior = set_prior('normal(0, 100)'), # flat prior on coefs
               seed = 101011)

# Set up a null model
M_bayes_null <- brm(y ~ x_1, 
                    data=Df,
                    cores = 1, # I have a dual-core
                    chains = 4, # 4 chains is typical
                    iter = 2500,
                    warmup = 1000, # these are initilization etc iterations
                    prior = set_prior('normal(0, 100)'), # flat prior on coefs
                    seed = 101013)

# Calculate and compare WAIC scores
loo_compare(waic(M_bayes_null), waic(M_bayes))

# Calculate and compare LOO-CV IC scores
loo_compare(loo(M_bayes_null), loo(M_bayes))

library(lme4) ## Install if necessary

Df <- sleepstudy # rename the data frame

# Visualize it
ggplot(Df,
       aes(x=Days, y=Reaction, col=Subject)
) + geom_point() +
  stat_smooth(method='lm', se=F, size=0.5) +
  facet_wrap(~Subject) +
  theme_classic()


# Random intercepts and random slopes model
M_lmer <- lmer(Reaction ~ Days + (Days|Subject),
               data = Df)

M <- brm(Reaction ~ Days + (Days|Subject),
         cores = 2,               
         prior = set_prior('normal(0, 100)'), # flat prior on coefs
         save_all_pars = T,
         data = Df)

# Random intercepts model
M_lmer_ri <- lmer(Reaction ~ Days + (1|Subject),
                  data = Df)

M_ri <- brm(Reaction ~ Days + (1|Subject),
            cores = 2,               
            prior = set_prior('normal(0, 100)'), # flat prior on coefs
            save_all_pars = T,
            data = Df)

# Model comparison
waic(M_ri)
waic(M)
loo_compare(waic(M_ri), waic(M))
