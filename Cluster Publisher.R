setwd("C:/Documents and Settings/deepak.babu");
pub<-read.csv(file="pub.csv",sep=",",na.strings="-99");
pub1 <- pub[which(pub$burn > 10),];
pub1$fr <- as.numeric(as.character(pub1$fr))
pub1$ecpm <- as.numeric(as.character(pub1$ecpm))
pub1$ctr <- as.numeric(as.character(pub1$ctr))


#EDA
hist(as.numeric(as.character(pub1$ctr)), breaks=1000, col="red",xlim=c(0,5)) ;
hist(pub1$ctr,breaks=1000,col="black",xlim=c(0,5))
hist(as.numeric(as.character(pub1$ecpm)), breaks=1000, col="red",xlim=c(0,4)) ;
hist(pub1$fr,breaks=100,col="black")
hist(pub1$burn,breaks=1000,col="black",xlim=c(10,1000))
hist(as.numeric(as.character(pub1$fr)), breaks=100, col="red",xlim=c(0,100)) ;
hist(pub$type, breaks=2, col="red") ;
# Basic Scatterplot Matrix
pairs(~days+burn+adreq+ctr+ecpm+fr+type,data=pub1,main="Simple Scatterplot Matrix");
cor(pub1)
cor(as.numeric(as.character(pub1$ecpm)),as.numeric(as.character(pub1$ctr)))
#0.85
#quite strong correlation & nice pattern between ecpm and ctr

#standardize data
pub1<- pub1[c(-1,-2)]
pubstd <- scale(pub1)
as.numeric(as.character(pub1$ctr))
as.numeric(as.character(pub1$ecpm))      
as.numeric(as.character(pub1$fr))
mydata <- pubstd;


# Determine number of clusters
wss <- (nrow(mydata)-1)*sum(apply(mydata,2,var))
for (i in 2:15) wss[i] <- sum(kmeans(mydata,centers=i)$withinss)
plot(1:15, wss, type="b", xlab="Number of Clusters", ylab="Within groups sum of squares") 


# K-Means Cluster Analysis
fit <- kmeans(mydata, 6) # 6 cluster solution
# get cluster means
aggregate(mydata,by=list(fit$cluster),FUN=mean)
# append cluster assignment
mydata <- data.frame(mydata, fit$cluster) 
library(sqldf)
sqldf("select fit_cluster,count(*) from mydata group by fit_cluster");


# vary parameters for most readable graphm
library(cluster)
clusplot(mydata, fit$cluster, color=TRUE, shade=TRUE,
         labels=2, lines=0)


#final result set
pub2<- pub1[c(-1,-2),]
final <- c(mydata,pub2)
write.csv(final,"pub_clus.csv")


#fit a tree
res<-rpart(final$fit.cluster~final$days+final$fr+final$burn+final$type,method="class");
plot(res)
text(res)


#creating metadata for cluster
pub1$days1 <- scale(pub1$days);
pub1$fr1 <- scale(pub1$fr);
pub1$burn1 <- scale(pub1$burn);

master<-sqldf("select a.*,b.fit_cluster from pub1 a,mydata b where a.days1 = b.days and a.burn1 = b.burn and a.fr1 = b.fr");
res<-rpart(master$fit_cluster~master$days+master$fr+master$burn+master$type,method="class");
plot(res)
text(res)