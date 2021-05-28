## Installing Stan, `brms`, etc

Stan is a probabilistic programming language. Using the Stan language,
you can define arbitrary probabilistic models and then perform Bayesian
inference on them using
[MCMC](https://en.wikipedia.org/wiki/Markov_chain_Monte_Carlo),
specifically using [Hamiltonian Monte
Carlo](https://en.wikipedia.org/wiki/Hamiltonian_Monte_Carlo).

In general, Stan is a external program to R; it does not need to be used
with R. However, one of the most common ways of using Stan is by using
it through R and that is what we will be doing in this workshop.

To use Stan with R, you need to install an R package called
[rstan](http://mc-stan.org/users/interfaces/rstan). However, you also
need additional external tools installed in order for
[rstan](http://mc-stan.org/users/interfaces/rstan) to work.

Instructions for installing rstan on can be found here:

- <https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started>

Specific instructions for different platforms can be found by following links from this page.

## Installing brms

If the installation of R, Rstudio and Stan seemed to go fine, you can
get the [brms](https://github.com/paul-buerkner/brms) R package, which
makes using Stan with R particularly easy when using conventional
models.

To get [brms](https://github.com/paul-buerkner/brms), first start
Rstudio (whether on Windows, Macs, Linux) and then run

```r
install.packages('brms')
```

You can test that it worked by running the following code, which should take around 1 minute to complete.

```r
library(tidyverse)
library(brms)

data_df <- tibble(x = rnorm(10))

M <- brm(x ~ 1, data = data_df)
```

### Trouble getting `rstan` and `brms` working on Windows using R 4.0?

Here's what I did to get `rstan` and `brsm` working on Windows using R 4.0?

1. First, in R, install `rstan`.
```r
install.packages("rstan")
```

2. In Windows, download and run this [Rtools 4 installer](https://cran.r-project.org/bin/windows/Rtools/rtools40-x86_64.exe).

3. Back in R, type the following line.
```r
writeLines('PATH="${RTOOLS40_HOME}\\usr\\bin;${PATH}"', con = "~/.Renviron")
```

4. *Restart R*

5. Check that RTools is working.
```r
pkgbuild::has_build_tools(debug = TRUE)
```
This should simply return `TRUE`.

6. Install `brms`.
```r

install.packages('brms')
```

7. Test the `brms` code above, i.e. with the `M <- brm(x ~ 1, data = data_df)`.

### Another test installing Stan, `rstan`, `brms` on Windows

As as test, I installed Stan, `rstan`, and `brms` from scratch on Windows.

First, I did this: 

* Uninstall R and RStudio completely.
* Delete my Documents/R (default location of R packages) folder
* Reinstall R and RStudio from latest versions

Then, I installed `rstan`.
``` {.R}
install.packages("rstan", repos = "https://cloud.r-project.org/", dependencies = TRUE)
```

Then, I installed `rtools` using 64 bit installer here https://cran.r-project.org/bin/windows/Rtools/, i.e. https://cran.r-project.org/bin/windows/Rtools/rtools40-x86_64.exe

Then, I tested Stan/`rstan` with
```{.R}
library(rstan)
example(stan_model,run.dontrun = TRUE)
```
There was a lot of output, but it eventually (after about 3-5 minutes) finished with samples from a model.

Then, I installed `tidyverse` and `brms`.

```{.R}
install.packages("tidyverse")
install.packages("brms")
```


Then, tested the tiny `brms` model.
```{.R}
library(tidyverse)
library(brms)

data_df <- tibble(x = rnorm(10))

M <- brm(x ~ 1, data = data_df)
```

And all was well.


### If all else fails?

The following RStudio server project can be used for anyone having trouble with Stan installation.
[![Binder](https://notebooks.gesis.org/binder/badge_logo.svg)](https://notebooks.gesis.org/binder/v2/gh/mark-andrews/hellobinder-rstan/HEAD?urlpath=rstudio)


While this *does* work, the binder service may limit the RAM size of some models. As such, while the smaller models will work, the more RAM hungry ones might not work.
