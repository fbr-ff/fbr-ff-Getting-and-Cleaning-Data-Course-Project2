
#Setting directory
setwd("DataScience/3GD_Week4")
#loading required packages
require(tidyverse)

#loading supplementary data and labels
supp.loc<-list.files("UCI HAR Dataset",pattern = ".txt",full.names = TRUE)
supp.list<-lapply(supp.loc,function(x) read_table(x,col_names = FALSE))

#naming supplementary data list
names(supp.list)<-list.files("UCI HAR Dataset",pattern = ".txt")

#loading training and testing data
train.loc<-list.files("UCI HAR Dataset/train",recursive = TRUE,pattern = ".txt",full.names = TRUE)
test.loc<-list.files("UCI HAR Dataset/test",recursive = TRUE,pattern = ".txt",full.names = TRUE)
train.list<-lapply(train.loc,function(x) read_table(x,col_names = FALSE))
test.list<-lapply(test.loc,function(x) read_table(x,col_names = FALSE))

#checking if the number of rows is the same in all given files
row.counts<-lapply(train.list,nrow) 
all(sapply(row.counts, FUN = identical, row.counts[[1]]))


# 1. Task 1. Merges the training and the test sets to create one data set.

#merging test and training set
df<-as.data.frame(rbind(train.list[[11]],test.list[[11]])) 
#adding temporary labels
colnames(df)<-supp.list[[3]]$X1

# 3. Task 3. Uses descriptive activity names to name the activities in the data set
#adding training/test labels
df2<-cbind(df,rbind(train.list[[12]],test.list[[12]]))%>%
  left_join(supp.list[[1]],"X1")%>%
  mutate(subject=rbind(train.list[[10]],test.list[[10]])[[1]])

# 2. Task 4. Appropriately labels the data set with descriptive variable names.
colnames(df2)<-c(sub("^[0-9]{1,3} ",supp.list[[3]]$X1,replacement = ""),
                 "activity_index","activity_description","subject")

# 4. Task 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

meanvals<-grep("mean\\(",colnames(df2),value = FALSE)
stdvals<-grep("std",colnames(df2),value = FALSE)

df.tidy.final<-cbind(df2[,meanvals],df2[,stdvals],
                  activity_index=df2$activity_index,
                  activity_description=df2$activity_description,
                  subject=df2$subject)%>%
  gather("measurement_type","value",1:66)

head(df.tidy.final)

#Task 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
df.tidy2<-df.tidy.final%>%
  group_by(activity_description,subject)%>%
  summarize(act.mean=mean(value))

head(df.tidy2)

#Export

write.csv(df.tidy.final,"tidy_dataset_1.csv")
write.csv(df.tidy2,"tidy_dataset_2_means.csv")
