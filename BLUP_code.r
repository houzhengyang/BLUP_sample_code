####################################################################################################################################
# 20190809 BLUP code with a sample implementation
#
# Written by: 
# 
# Drs. Zhengyang Hou, Lauri Mehtatalo, Ronald E. McRoberts, Goran Stahl, Parvez Rana, Jouni Siipilehto, Timo Tokola, Qing Xu 
#
# NOTE: 
# 
# (1) This is a supplementary material for the paper: 
#     
#     << Remote sensing-assisted data assimilation and simultaneous inference for forest inventory >>
#     
#     published at the Remote Sensing of Environment, completed by the same group of authors.
# 
# (2) This snippet of sample code serves the purpose of replicating key steps using Best Linear Unbiased Predictor (BLUP) to calibrate predicted
#     values obtained with the Seemingly Unrealated Regressions (SUR) that simutaneously predicted multiple dependent variables.
# 
# (3) SUR model parameters can be fitted using the "systemfit" package, available here: https://cran.r-project.org/web/packages/systemfit/index.html
# 
# (4) Please feel free to use, revise and redistribute this sample.
# 
# (5) We will update and enrich this code as related manuscripts relying on using them are published. 
# 
# (6) If you need help for adaptations to your use, please contact us at "qing.xu.forester@gmail.com".
# 
# (7) Thank you for citing this paper, and look forward to collaborations.
#
####################################################################################################################################

rm(list = ls())

BLUP_sample_code <- function(){
  # Load data in matrix and vectors.
  load("BLUP_data.RData")
  
  # Defind a scalar version of the BLUP function, for simplicity;
  # Input to this function is output of the SUR model system fitted using "systemfit" package.
  BLUP <- function(target=1, kickout=c(1:8), r=real, p=pred, z=resid, cov=cov.matrix) {
    cal.pred          <- NA
    cal.pred.var      <- NA
    V.between         <- cov[target,   -kickout]
    V.within          <- cov[-kickout, -kickout]
    for(i in 1:40){
      cal.pred[i]     <- t(p[i,target]) + V.between %*% solve(V.within) %*% t(z[i,-kickout])
      cal.pred.var[i] <- cov[target,target] - V.between %*% solve(V.within) %*% V.between
    }
    return(RMSE( resid=(r[,target]-cal.pred), pred=cal.pred, real=r[,target] ))
  }
  
  # Justify the unbiasedness of BLUP calibration.
  BLUP.mu <- function(target=1, kickout=c(1:8), p=pred, z=resid.bt, cov=cov.matrix) {
    cal.pred          <- NA
    V.between         <- cov[target,   -kickout]
    V.within          <- cov[-kickout, -kickout]
    for(i in 1:40) cal.pred[i] <- t(p[i]) + V.between %*% solve(V.within) %*% z[i,-kickout]
    mu                <- mean(cal.pred)
    return(mu)
  }
  
  # Output  
  for (i in 1:8) cal.lower.RMSE[i,] <- BLUP(target=i, kickout = c(1:8))
  for (i in 1:8) cal.upper.RMSE[i,] <- BLUP(target=i, kickout = c(i))
  mu.real      <- sapply(real, mean)
  mu.pred      <- sapply(pred, mean)
  cal.lower.mu <- NA
  cal.upper.mu <- NA
  for (i in 1:8) cal.lower.mu[i]    <- BLUP.mu(target=i, kickout = c(1:8), p=pred[,i], z=as.matrix(resid), cov=cov.matrix)
  for (i in 1:8) cal.upper.mu[i]    <- BLUP.mu(target=i, kickout = c(i)  , p=pred[,i], z=as.matrix(resid), cov=cov.matrix)
  
  return(list(ori.RMSE, cal.lower.RMSE, cal.upper.RMSE, mu.real, mu.pred, cal.lower.mu, cal.upper.mu))
} 

sample <- BLUP_sample_code()
print(sample)
