library(ISLR)
summary(Default)
##  default    student       balance         income     
##  No :9667   No :7056   Min.   :   0   Min.   :  772  
##  Yes: 333   Yes:2944   1st Qu.: 482   1st Qu.:21340  
##                        Median : 824   Median :34553  
##                        Mean   : 835   Mean   :33517  
##                        3rd Qu.:1166   3rd Qu.:43808  
##                        Max.   :2654   Max.   :73554
attach(Default)
# a
set.seed(1)
glm.fit = glm(default ~ income + balance, data = Default, family = binomial)
summary(glm.fit)
## 
## Call:
## glm(formula = default ~ income + balance, family = binomial, 
##     data = Default)
## 
## Deviance Residuals: 
##    Min      1Q  Median      3Q     Max  
## -2.473  -0.144  -0.057  -0.021   3.724  
## 
## Coefficients:
##              Estimate Std. Error z value Pr(>|z|)    
## (Intercept) -1.15e+01   4.35e-01  -26.54   <2e-16 ***
## income       2.08e-05   4.99e-06    4.17    3e-05 ***
## balance      5.65e-03   2.27e-04   24.84   <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 2920.6  on 9999  degrees of freedom
## Residual deviance: 1579.0  on 9997  degrees of freedom
## AIC: 1585
## 
## Number of Fisher Scoring iterations: 8
# b
boot.fn = function(data, index) {
    return(
        coef(glm(default ~ income + balance, 
                data = data, family = binomial, subset = index))
           )
}
# c
library(boot)
boot(Default, boot.fn, 50)
## 
## ORDINARY NONPARAMETRIC BOOTSTRAP
## 
## 
## Call:
## boot(data = Default, statistic = boot.fn, R = 50)
## 
## 
## Bootstrap Statistics :
##       original     bias    std. error
## t1* -1.154e+01  1.181e-01   4.202e-01
## t2*  2.081e-05 -5.467e-08   4.542e-06
## t3*  5.647e-03 -6.975e-05   2.283e-04

# d
# t2 t3 差不多精确