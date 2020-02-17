### Title:   Subroutines for Parallel Processing Example
### Author:  Kyle M. Lang
### Created: 2020-02-17
### Modifed: 2020-02-17

## Run one replication of the simulation:
doRep <- function(rp, conds) {
    prb <- rep(NA, nrow(conds))
    for(i in 1 : nrow(conds)) prb[i] <- runCell(conds[i, ])
    
    cbind(conds, prb)
}

## Run the calculations for one set of crossed conditions:
runCell <- function(x) {
    ## Simulate a normal sample:
    dat <- rnorm(n = x["n"], mean = x["m"], sd = x["s"])
    
    ## Compute the proportional error in the mean estimate:
    (mean(dat) - x["m"]) / x["m"]
}

## Aggregate the results:
poolResults <- function(out) {
    tmp <- do.call(rbind.data.frame, out)
    aggregate(tmp[4], by = tmp[-4], FUN = mean)
}
