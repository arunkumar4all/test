# setting working directory just in case program doesn't compile in coursera
# also - I store all R files in a separate directory

setwd("C:/Users/Arunkumar/Desktop/R-folder/GetClean/UCI HAR Dataset")

# reading all the test and training files

library(data.table)

xtrain = read.table("train/X_train.txt", sep="",header=FALSE)
ytrain = read.table("train/Y_train.txt", sep="",header=FALSE)
subtrain = read.table("train/subject_train.txt", sep="",header=FALSE)
xtest = read.table("test/X_test.txt", sep="",header=FALSE)
ytest = read.table("test/y_test.txt", sep="",header=FALSE)
subtest = read.table("test/subject_test.txt", sep="",header=FALSE)

datacolname = read.table("features.txt", header=FALSE)
labelfile = read.table("activity_labels.txt", sep="",header=FALSE)



#1. Merges the training and the test sets to create one data set.


trainall = cbind(xtrain, ytrain, subtrain)
testall = cbind(xtest, ytest, subtest)

dataall = rbind(trainall, testall)

#4. Appropriately labels the data set with descriptive variable names. 

colnames(dataall) = datacolname$V2

colnames(dataall)[562] = "Activity"
colnames(dataall)[563] = "Subject"


#3. Uses descriptive activity names to name the activities in the data set

for(i in labelfile$v2) {
  datall$Activity =  gsub(num,i,datall$Activity)
  num = num + 1
}

#2. Extracts only the measurements on the mean and standard deviation for each measurement. 

meancols = grep ("mean",colnames(dataall), fixed=TRUE)
stdcols = grep ("std",colnames(dataall), fixed=TRUE)

c(meancols,stdcols,562,563)
colnum = c(meancols,stdcols,562,563)

datatidy = dataall[,colnum]

# 5. From the data set in step 4, creates a second, independent tidy data 
# set with the average of each variable for each activity and each subject.

tidydata = aggregate(datatidy, by=list(Activity = datatidy$Activity, Subject=datatidy$Subject), mean)

write.table(tidydata, file="./tidydata.txt", sep="\t", row.names=FALSE)
