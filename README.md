# BLUP_sample_code
Supplementary to "Remote sensing-assisted data assimilation and simultaneous inference for forest inventory"

20190809 BLUP code with a sample implementation

Written by: 
Drs. Zhengyang Hou, Lauri Mehtatalo, Ronald E. McRoberts, Goran Stahl, Parvez Rana, Jouni Siipilehto, Timo Tokola, Qing Xu 

NOTE: 
(1) This is a supplementary material for the paper: 
     << Remote sensing-assisted data assimilation and simultaneous inference for forest inventory >>
     published at the Remote Sensing of Environment, completed by the same group of authors.
(2) This snippet of sample code serves the purpose of replicating key steps using Best Linear Unbiased Predictor (BLUP) to calibrate predicted values obtained with the Seemingly Unrealated Regressions (SUR) that simutaneously predicted multiple dependent variables.
(3) SUR model parameters can be fitted using the "systemfit" package, available here: https://cran.r-project.org/web/packages/systemfit/index.html
(4) Please feel free to use, revise and redistribute this sample.
(5) We will update and enrich this code as related manuscripts relying on using them are published. 
(6) If you need help for adaptations to your use, please contact us at "qing.xu.forester@gmail.com".
(7) Thank you for citing this paper, and look forward to collaborations.
