setwd("C:/Documents and Settings/deepak.babu");
dat<-read.csv(file="sales.csv",sep=",");
burn<-ts(dat,frequency=12,start=c(2010,1));
plot.ts(burn);

#breaks into observed,trend,seasonal & random
#burncomp$x $trend $seasonal $random additive model.
library("TTR");
burncomp<-decompose(burn);
plot(burncomp);
grid( col = "black", lty = "dotted",
     lwd = par("lwd"), equilogs = TRUE);


#fit exponential into the trend
#a exponenetial on applying log on both sides converts to a number
# http://www.physics.pomona.edu/sixideas/labs/LRM/LR13.pdf
y <- log(burncomp$trend);
y <- as.numeric(y);
y<-y[complete.cases(y)]
x<-c(1,  2,  3,	4,	5,	6,	7,	8,	9,	10,	11,	12,	13,	14,	15,	16,	17,	18,	19,	20,	21,	22,	23,	24,	25,	26,	27,	28)
fit<-lm(log(y)~log(x))


#some nice plots
plot(burncomp$trend + burncomp$seasonal)
lines(burncomp$x,col="blue")

#curve fitting on trend
plot(burncomp$trend)
grid( col = "black", lty = "dotted",
      lwd = par("lwd"), equilogs = TRUE);
x<-c(1,  2,	3,	4,	5,	6,	7,	8,	9,	10,	11,	12,	13,	14,	15,	16,	17,	18,	19,	20,	21,	22,	23,	24,	25,	26,	27,	28,	29,	30,	31,	32,	33,	34,	35,	36,	37,	38,	39,	40,	41,	42,	43,	44,	45,	46,	47,	48,	49,	50,	51,	52,	53,	54,	55,	56,	57,	58,	59,	60,	61,	62,	63,	64,	65,	66,	67,	68,	69,	70,	71,	72,	73,	74,	75,	76,	77,	78,	79,	80)
lines(1134043*2.718^(0.06*x));
plot(log(burncomp$trend));
fit <- lm(log(burn$trend)~log(x));
trendfit <-