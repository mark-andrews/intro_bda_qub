# Install priorexposure package
devtools::install_git("https://github.com/mark-andrews/intro_bda_qub", subdir = 'priorexposure')

library(priorexposure)

# Bernoulli likelihood
bernoulli_likelihood(50, 20)

# Beta plots
beta_plot(3, 5)
beta_plot(10, 3)
beta_plot(1, 5)
beta_plot(5, 2)
beta_plot(50, 20)
beta_plot(1, 1)
beta_plot(1.1, 1.1)
beta_plot(2, 2)
beta_plot(20, 20)
beta_plot(0.1, 0.1)

# Show posterior distribution
bernoulli_posterior_plot(250, 139, 1, 1, show_hpd = TRUE)

# Posterior summary
bernoulli_posterior_summary(250, 139, 1, 1)

# HPD interval
get_beta_hpd(139 + 1, 250 - 139 + 1)
