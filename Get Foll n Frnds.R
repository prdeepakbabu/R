install.packages("RJSONIO");
library(RJSONIO);
library('ROAuth');
library(RCurl);

# Set SSL certs globally
options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))

require(twitteR);
reqURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/access_token"
authURL <- "https://api.twitter.com/oauth/authorize"
apiKey <- "yourAPIkey"
apiSecret <- "yourAPIsecret"
apiKey <- "MhcNHeuTmsxDABQ5uLIykIxO9"
apiSecret <- "Pls Enter"
twitCred <- OAuthFactory$new(consumerKey=apiKey,consumerSecret=apiSecret,requestURL=reqURL,accessURL=accessURL,authURL=authURL)

#establish handhsake with twitter server, use the code provided by the URL and reenter here .
twitCred$handshake(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"));
registerTwitterOAuth(twitCred);              
#IMP NOTE: Enable read and write access to the user for twitter API

in_1 = getUser("inmobi")$getFriendIDs( retryOnRateLimit=9999999);
in_2 = getUser("inmobi")$getFollowerIDs( retryOnRateLimit=9999999);              
mm_1 = getUser("millennialmedia")$getFriendIDs( retryOnRateLimit=9999999);
mm_2 = getUser("millennialmedia")$getFollowerIDs( retryOnRateLimit=9999999);
mo_1 = getUser("mojiva")$getFriendIDs( retryOnRateLimit=9999999);
mo_2 = getUser("mojiva")$getFollowerIDs( retryOnRateLimit=9999999);
ta_1 = getUser("tapjoy")$getFriendIDs( retryOnRateLimit=9999999);
ta_2 = getUser("tapjoy")$getFollowerIDs( retryOnRateLimit=9999999);
fl_1 = getUser("flurrymobile")$getFriendIDs( retryOnRateLimit=9999999);
fl_2 = getUser("flurrymobile")$getFollowerIDs( retryOnRateLimit=9999999);
ai_1 = getUser("airpushads")$getFriendIDs( retryOnRateLimit=9999999);
ai_2 = getUser("airpushads")$getFollowerIDs( retryOnRateLimit=9999999);
am_1 = getUser("amobee")$getFriendIDs( retryOnRateLimit=9999999);
am_2 = getUser("amobee")$getFollowerIDs( retryOnRateLimit=9999999);      
go_1 = getUser("googlemobileads")$getFriendIDs( retryOnRateLimit=9999999);
go_2 = getUser("googlemobileads")$getFollowerIDs( retryOnRateLimit=9999999);

#to check length
length(go_2);

#company follows user
a = "";
for( i in 1:length(in_1))
{
  str = paste("INMOBI","FOLLOWS",in_1[i],sep=",")
  a = rbind(a,str);
}
for( i in 1:length(mm_1))
{
  str = paste("MILLENNIAL MEDIA","FOLLOWS",mm_1[i],sep=",")
  a = rbind(a,str);
}
for( i in 1:length(mo_1))
{
  str = paste("MOJIVA","FOLLOWS",mo_1[i],sep=",")
  a = rbind(a,str);
}
for( i in 1:length(ta_1))
{
  str = paste("TAPJOY","FOLLOWS",ta_1[i],sep=",")
  a = rbind(a,str);
}
for( i in 1:length(fl_1))
{
  str = paste("FLURRY","FOLLOWS",fl_1[i],sep=",")
  a = rbind(a,str);
}
for( i in 1:length(ai_1))
{
  str = paste("AIRPUSH","FOLLOWS",ai_1[i],sep=",")
  a = rbind(a,str);
}
for( i in 1:length(am_1))
{
  str = paste("AMOBEE","FOLLOWS",am_1[i],sep=",")
  a = rbind(a,str);
}
for( i in 1:length(go_1))
{
  str = paste("GOOGLE","FOLLOWS",go_1[i],sep=",")
  a = rbind(a,str);
}

write.csv(a,file="frnds.csv",row.names=FALSE);


#user follows company
b = "";
for( i in 1:length(in_2))
{
  str = paste(in_2[i],"FOLLOWS","INMOBI",sep=",")
  b = rbind(b,str);
}
for( i in 1:length(mm_2))
{
  str = paste(mm_2[i],"FOLLOWS","MILLENNIAL MEDIA",sep=",")
  b = rbind(b,str);
}
for( i in 1:length(mo_2))
{
  str = paste(mo_2[i],"FOLLOWS","MOJIVA",sep=",")
  b = rbind(b,str);
}
for( i in 1:length(ta_2))
{
  str = paste(ta_2[i],"FOLLOWS","TAPJOY",sep=",")
  b = rbind(b,str);
}
for( i in 1:length(fl_2))
{
  str = paste(fl_2[i],"FOLLOWS","FLURRY",sep=",")
  b = rbind(b,str);
}
for( i in 1:length(ai_2))
{
  str = paste(ai_2[i],"FOLLOWS","AIRPUSH",sep=",")
  b = rbind(b,str);
}
for( i in 1:length(am_2))
{
  str = paste(am_2[i],"FOLLOWS","AMOBEE",sep=",")
  b = rbind(b,str);
}
for( i in 1:length(go_2))
{
  str = paste(go_2[i],"FOLLOWS","GOOGLE",sep=",")
  b = rbind(b,str);
}

write.csv(b,file="folls.csv",row.names=FALSE);
