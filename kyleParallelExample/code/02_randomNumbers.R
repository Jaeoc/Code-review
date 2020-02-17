### Title:   Parallel Processing Example 3
### Author:  Kyle M. Lang
### Created: 2020-02-17
### Modifed: 2020-02-17

rm(list = ls(all = TRUE))

source("init.R")
source("subroutines.R")

nReps <- 50


###--------------------------------------------------------------------------###

set.seed(235711)
out1 <- list()
for(rp in 1 : nReps)
    out1[[rp]] <- doRep(rp, conds = conds)

set.seed(235711)
out2 <- lapply(X = 1 : nReps, FUN = doRep, conds = conds)

all.equal(out1, out2)

###--------------------------------------------------------------------------###

set.seed(235711)
out3 <- mclapply(X        = 1 : nReps,
                 FUN      = doRep,
                 conds    = conds,
                 mc.cores = 2)

all.equal(out2, out3)

###--------------------------------------------------------------------------###

set.seed(235711)
out4.1 <- mclapply(X        = 1 : nReps,
                   FUN      = doRep,
                   conds    = conds,
                   mc.cores = 2)

set.seed(235711)
out4.2 <- mclapply(X        = 1 : nReps,
                   FUN      = doRep,
                   conds    = conds,
                   mc.cores = 2)

all.equal(out4.1, out4.2)

###--------------------------------------------------------------------------###

set.seed(235711)
out5.1 <- mclapply(X           = 1 : nReps,
                   FUN         = doRep,
                   conds       = conds,
                   mc.cores    = 2,
                   mc.set.seed = FALSE)

set.seed(235711)
out5.2 <- mclapply(X           = 1 : nReps,
                   FUN         = doRep,
                   conds       = conds,
                   mc.cores    = 2,
                   mc.set.seed = FALSE)

all.equal(out5.1, out5.2)
all.equal(out5.1, out2)

###--------------------------------------------------------------------------###

set.seed(235711)
out6.1 <- mclapply(X           = 1 : 20,
                   FUN         = doRep,
                   conds       = conds,
                   mc.cores    = 2,
                   mc.set.seed = FALSE)

set.seed(235711)
out6.2 <- mclapply(X           = 21 : 40,
                   FUN         = doRep,
                   conds       = conds,
                   mc.cores    = 2,
                   mc.set.seed = FALSE)

all.equal(out6.1, out6.2)
