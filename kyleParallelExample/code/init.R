### Title:   Setup Environment for Parallel Processing Examples
### Author:  Kyle M. Lang
### Created: 2020-02-17
### Modifed: 2020-02-17

library(parallel) # We'll need this for parallel processing

## Define simulation conditions:
n <- seq(50, 500, length.out = 10)
m <- s <- 1 : 10

conds <- as.matrix(expand.grid(n = n, m = m, s = s))
