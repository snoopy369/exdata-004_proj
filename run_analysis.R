#Set working directory and call libraries that will be used
setwd("/Users/snoopy369/git/exdata-004_proj")

library(plyr)
library(reshape)
fet_label <- read.table("UCI HAR Dataset/features.txt")
#Remove parens and convert dashes to dots - a good compromise on names
fet_label_gs <- gsub(pattern="[[:punct:]]",".",gsub(pattern="\\(|\\)",replacement="",fet_label[,2]))


#Read in the training dataset
X_train <- read.table("UCI HAR Dataset/train/X_train.txt",col.names=fet_label_gs)
Y_train <- read.table("UCI HAR Dataset/train/Y_train.txt",col.names="activityCode")
S_train <- read.table("UCI HAR Dataset/train/subject_train.txt",col.names="subject")
dset_train <- cbind(S_train,Y_train,X_train)

#Read in the test dataset
X_test <- read.table("UCI HAR Dataset/test/X_test.txt",col.names=fet_label_gs)
Y_test <- read.table("UCI HAR Dataset/test/Y_test.txt",col.names="activityCode")
S_test <- read.table("UCI HAR Dataset/test/subject_test.txt",col.names="subject")
dset_test <- cbind(S_test,Y_test,X_test)

#Read in the activity labels
act_label <- read.table("UCI HAR Dataset/activity_labels.txt")
names(act_label)<-c("activityCode","activityType")


#Merge on the activity labels
dset_train_merge <- merge(dset_train,act_label,by="activityCode")
dset_test_merge <- merge(dset_test,act_label,by="activityCode")

df_UCIHAR = as.data.frame(rbind(dset_train_merge,dset_test_merge))


#The ID variables we want to keep while transforming this
c_ids <- c("subject","activityCode","activityType")

n_df <- names(df_UCIHAR)
#Mean is a bit complicated to find as it has two possibilities, (mean.X) and (mean), but also has "meanfreq" which we are not keeping
n_mean <- n_df[grepl("\\.mean(\\..*)?$",n_df,ignore.case=TRUE,perl=TRUE)]
#STD is easier to keep.
n_std <- n_df[grepl("\\.std",n_df,ignore.case=TRUE)]
#Both vectors should have 33 members in them if this was done correctly.

#Create mean and std data frames
df_mean  = df_UCIHAR[,c(c_ids,n_mean)]
df_std  = df_UCIHAR[,c(c_ids,n_std)]

#Melt to long form and combine the two
df_long = cbind(melt(df_mean,id=c("subject","activityCode","activityType")),
                melt(df_std,id=c("subject","activityCode","activityType"))[,5])

#define names of the value variables ("variable" seems like a good one so I keep it)
names(df_long)[5:6] <- c("mean","std.dev")
df_long$variable <- gsub(pattern="\\.mean",replacement="",x=df_long$variable)
df_long$variable <- gsub("^f","frequency.",df_long$variable)
df_long$variable <- gsub("^t","time.",df_long$variable)
#sort it neatly by subject then activity then variable
df_long <- df_long[order(df_long[,1],df_long[,2],df_long[,4]),]

#now calculate means (For step 5) using ddply
means_df_long <- ddply(df_long,.(subject,activityCode,activityType,variable),numcolwise(mean))
#give better variable names, as they are no longer truly mean/stddev
names(means_df_long)[5:6] <- c("mean.means","mean.std_devs")

#write out to disk
write.table(means_df_long,"UCIHAR_means_of_means_stds.txt",row.names=FALSE)
write.table(df_long,"UCIHAR_means_stds.txt",row.names=FALSE)

