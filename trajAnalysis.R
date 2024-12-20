#
# trajAnalysis.R 
#
# This script is distributed 'as is'. There's no guarantee that it will work with your data or for your application.
#
# J. Alfredo Freites
# jfreites@uci.edu
#
# 12/18/24:
# First wide distribution version based on TAMSD.R and featureCalcs6.R
# compiling all the trajectory analysis function used in Ly et al. in a single source file
#
#
# input trajectory always coded as matrix with instantaneous position vectors as rows (and position vector components as columns)
# 
# if the trajectory sampling is specified by the sequence {x1,x2,...,x_i,x_i+1,...} then the sampled displacements (called "steps" in Ly et al.) are {x2-x1,...,x_i+1 - x_i,...} 

#trajectory radius of gyration
getRg<-function(xy) {
  avg<-colMeans(xy,na.rm=T)
  avg2<-colMeans(xy^2,na.rm=T)
  rg<-sqrt(sum(avg2-avg^2))
  return(rg)
}


#step vectors scaled by their RMS
getStepsNorm<-function(xy){
  stepe<-apply(xy,2,diff)
  stepeMean<-apply(stepe,2,function(z){sqrt(mean(z^2,na.rm=T))})
  return(scale(stepe,center=F,scale=stepeMean))
}


#mean step length
getMeanStepLength<-function(xy){
  stepe<-apply(xy,2,diff)
  slen<-mean(apply(stepe,1,function(z){sqrt(sum(z^2,na.rm=T))}))
  return(slen)
}


#Golan and Sherman "scaled" Rg (sRg)
#cf. Nat. Commun. 8:1–15 2017
getsRg<-function(xy) {
        Rg<-getRg(xy)
        meanS<-getMeanStepLength(xy)
        sRg<-sqrt(pi/2)*Rg/meanS
        return(sRg)
}

#step lengths vector at a given lag, input is the "n" in lag = n*deltaT
#i(variable delta, defaults to 1)
getStepLenDelta<-function(xy,delta=1) {
	if(nrow(xy)>delta-1) {
	stepe<-apply(xy,2,diff,lag=delta)
  slen<-apply(stepe,1,function(z){sqrt(sum(z^2))})
	}
  return(slen)
}

#Compute TAMSD from lag=1 up to maxlag (maxlag defaults to 1)
getMSD <- function(xy,maxlag=1)
{
    xy<-as.matrix(xy)
    msd   <- vector(mode='double',length= maxlag)
    len<-nrow(xy)
    if(maxlag<1) {
		stop('maxlag should be >= 1')
	}
    maxlag <- as.integer(maxlag)
    for (delta in 1:maxlag)
    {
        dxy<-xy[(1+delta):len,]-xy[1:(len-delta),]
                msd[delta]<-sum(colMeans(dxy^2,na.rm = T))

    }
    return(msd)
}


#fit  TAMSD(lag)  to a power-law using linear regression: logTAMSD(lag) = logKalpha * alpha * lag
#MSDs coded as a vector
#lags specified as vector defaulting to a sequence from 1 to the length of the MSD vector
#returns c(Kalpha,alpha) 
#option to return the object returned by .lm.fit (defaults to FALSE)
#
getAlphaD<-function(msd,lags=integer(),model=FALSE){
    if(length(lags)==0) 
        lags<-seq(1,length(msd))
    mylm<- .lm.fit(cbind(1,log(lags)),log(msd))
    params<-c(exp(mylm$coefficients[1]),mylm$coefficients[2])
    if(model)
        return(params=params,model=mylm)
    else
        return(params)
}


