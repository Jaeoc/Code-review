### Title:   Parallel Processing Example 4
### Author:  Kyle M. Lang
### Created: 2020-02-17
### Modifed: 2020-02-17

rm(list = ls(all = TRUE))

source("init2.R")
source("subroutines2.R")

nReps <- 50


###--------------------------------------------------------------------------###

## Run 'nReps' replications in a loop:
out1 <- list()
for(rp in 1 : nReps)
    out1[[rp]] <- doRep2(rp, conds = conds, parms = parms)

## Run 'nReps' repliations in serial using lapply():
out2 <- lapply(X = 1 : nReps, FUN = doRep2, conds = conds, parms = parms)

all.equal(out1, out2)

###--------------------------------------------------------------------------###

## Run 'nReps' replications in parallel using mclapply():
out3 <- mclapply(X        = 1 : nReps,
                 FUN      = doRep2,
                 conds    = conds,
                 parms    = parms,
                 mc.cores = 2)

all.equal(out2, out3)

###--------------------------------------------------------------------------###

out4.1 <- mclapply(X        = 1 : nReps,
                   FUN      = doRep2,
                   conds    = conds,
                   parms    = parms,
                   mc.cores = 2)

out4.2 <- mclapply(X        = 1 : nReps,
                   FUN      = doRep2,
                   conds    = conds,
                   parms    = parms,
                   mc.cores = 2)

all.equal(out4.1, out4.2)

###--------------------------------------------------------------------------###

out5.1 <- mclapply(X        = 1 : (nReps / 2),
                   FUN      = doRep2,
                   conds    = conds,
                   parms    = parms,
                   mc.cores = 2)

out5.2 <- mclapply(X        = ((nReps / 2) + 1) : nReps,
                   FUN      = doRep2,
                   conds    = conds,
                   parms    = parms,
                   mc.cores = 2)

all.equal(out5.1, out5.2)

out5.3 <- c(out5.1, out5.2)
all.equal(out5.3, out4.1)
