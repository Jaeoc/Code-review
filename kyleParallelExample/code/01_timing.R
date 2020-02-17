### Title:   Parallel Processing Example 2
### Author:  Kyle M. Lang
### Created: 2020-02-17
### Modifed: 2020-02-17

rm(list = ls(all = TRUE))

source("init.R")
source("subroutines.R")

nReps <- 50


###--Serial Processing-------------------------------------------------------###


## Run 'nReps' replications in a loop:
t1 <- system.time(
{
    out1 <- list()
    for(rp in 1 : nReps)
        out1[[rp]] <- doRep(1, conds = conds)
}
)

## Run 'nReps' repliations in serial using lapply():
t2 <- system.time(
    out2 <- lapply(X = 1 : nReps, FUN = doRep, conds = conds)
)

###--Parallel Processing 1---------------------------------------------------###

## Run 'nReps' replications in parallel using mclapply():
t3 <- system.time(
    out3 <- mclapply(X        = 1 : nReps,
                     FUN      = doRep,
                     conds    = conds,
                     mc.cores = 2)
)


###--Parallel Processing 2---------------------------------------------------###

## Create a cluster object:
clus <- makeCluster(2)

## Source the 'subroutines.R' script on the worker nodes:
clusterCall(cl = clus, fun = source, file = "subroutines.R")

## Run the computations in parallel on the 'clus' object:
t4 <- system.time(
    out4 <- parLapply(cl = clus, X = 1 : nReps, fun = doRep, conds = conds)
)

## Kill the cluster:
stopCluster(clus)


###--Compare Timings---------------------------------------------------------###

t1
t2
t3
t4

t2[3] / t3[3]

