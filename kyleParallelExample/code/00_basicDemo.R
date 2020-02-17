### Title:   Parallel Processing Example 1
### Author:  Kyle M. Lang
### Created: 2020-02-17
### Modifed: 2020-02-17

rm(list = ls(all = TRUE))

source("init.R")
source("subroutines.R")

nReps <- 50


###--Serial Processing-------------------------------------------------------###

## Run one replication:
out <- doRep(1, conds = conds)

## Run 'nReps' replications in a loop:
out1 <- list()
for(rp in 1 : nReps)
    out1[[rp]] <- doRep(1, conds = conds)

## Run 'nReps' repliations in serial using lapply():
out2 <- lapply(X = 1 : nReps, FUN = doRep, conds = conds)


###--Parallel Processing 1---------------------------------------------------###

## Run 'nReps' replications in parallel using mclapply():
out3 <- mclapply(X        = 1 : nReps,
                 FUN      = doRep,
                 conds    = conds,
                 mc.cores = 2)

### NOTE: mclapply() only works on *nix-style operating systems. On Windows, it
###       will fall back to serial processing.


###--Parallel Processing 2---------------------------------------------------###

## Create a cluster object:
clus <- makeCluster(2)

## Two different ways to source a script on the worker nodes:
clusterEvalQ(cl = clus, expr = source("subroutines.R"))
clusterCall(cl = clus, fun = source, file = "subroutines.R")

## Use clusterExport() to initialize variables on worker nodes:
?clusterExport

## Run the computations in parallel on the 'clus' object:
out4 <- parLapply(cl = clus, X = 1 : nReps, fun = doRep, conds = conds)

## Kill the cluster:
stopCluster(clus)

### NOTE: We need to use this approach on Windows since we can't using forking
###       to create clusters.


###--Analysis----------------------------------------------------------------###

## Aggregate the results:
res <- poolResults(out4)

## Visualize:
with(res, boxplot(prb ~ n))
with(res, boxplot(prb ~ m))
with(res, boxplot(prb ~ s))
