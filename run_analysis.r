
#Get data in our working directory
fname<-"data.zip"

if(!file.exists(fname)){
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",fname,method="curl")
    unzip(fname)
}

list.files(recursive = TRUE)

#first task 
#Merges the training and the test sets to create one data set
subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt")
X_train<-read.table("UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("UCI HAR Dataset/train/y_train.txt")
##
subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")
X_test<-read.table("UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("UCI HAR Dataset/test/y_test.txt")

#merging
sData<-rbind(subject_train,subject_test)
xData<-rbind(X_train,X_test)
yData<-rbind(y_train,y_test)

#second task
#Extract only the measurements on the mean and standard deviation for each measurement
features<-read.table("UCI HAR Dataset/features.txt")


head(features,n = 10)

#only with -mean() or -std() in the name
reqFeatures<-grep("-(mean|std)\\(\\)",features[,2])
reqFeatures

#
xData_1<-xData[,reqFeatures]
names(xData_1)<-features[reqFeatures,2]

head(xData_1,n=2)

#TASK 3
#Uses descriptive activity names to name the activities in the data set
activities<-read.table("UCI HAR Dataset/activity_labels.txt")
yData_1<-activities[yData[,1],2]
names(yData_1)<-"Activity"

#TASK 4
#Appropriately labels the data set with descriptive variable names
xColumns<-names(xData_1)
names(xColumns)<-gsub("^t","Time",names(xColumns))
names(xColumns)<-gsub("^f","Frequency",names(xColumns))
names(xColumns)<-gsub("Acc","Accelerometer",names(xColumns))
names(xColumns)<-gsub("Gyro","Gyroscope",names(xColumns))
names(xColumns)<-gsub("Mag","Magnitude",names(xColumns))
names(xColumns)<-gsub("mean","Mean",names(xColumns))
names(xColumns)<-gsub("std","StandardDeviation",names(xColumns))
names(xColumns)<-gsub("[\\(\\)-]","",names(xColumns))
xColumns

names(xData_1)<-xColumns
head(xData_1,n=1)

names(sData)<-"Subject"
allData<-cbind(xData_1,yData_1,sData)
names(allData)<-gsub("yData_1","Activity",names(allData))
head(allData,n=2)

dim(allData)

#TASK 5
#create a second, independent tidy data set with the average of each variable for each activity and each subject.
#lets group by subject and activity
library(dplyr)
allDataMeans<-allData %>%
    group_by(Subject,Activity) %>%
    summarise_each(funs(mean))
head(allDataMeans,n=10)

write.table(allDataMeans,"tidy_data.txt")
