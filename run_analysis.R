#Reading training table
training <- read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE, stringsAsFactor=FALSE)
#Extracting feature names and joining with training data
trainingcolnames = read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE,stringsAsFactors=FALSE)[,2]
trainingcolnames = gsub('-mean', 'Mean', trainingcolnames)
trainingcolnames = gsub('-std', 'Std', features[,2])
trainingcolnames = gsub('[-()]', '', features[,2])
colnames(training) <- trainingcolnames

#Reading test table
test <- read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE, stringsAsFactor=FALSE)
#Extracting feature names and joining with test data
testcolnames = read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE,stringsAsFactors=FALSE)[,2]
testcolnames = gsub('-mean', 'Mean', testcolnames)
testcolnames = gsub('-std', 'Std', testcolnames)
testcolnames = gsub('[-()]', '', testcolnames)
colnames(test) <- testcolnames


#Verifing the colnemes between the subsets are equal
Identical <- identical(colnames(training), colnames(test))
names(training)
names(test)
#Defining Row names associated with each test subject
fulldata <- rbind(training, test)

#Reading Subject and Training label Train
YtrainingTrain = read.csv("UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE)
SubjtrainingTrain = read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)
#Reading Subject and Training label Test
YtrainingTest = read.csv("UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE)
SubjtrainingTest = read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)
#Joining Columns
YTraining <- rbind(YtrainingTrain, YtrainingTest)
Subject <- rbind(SubjtrainingTrain, SubjtrainingTest)
#Adding Columns to Full set
FullData <- cbind(fulldata, Subject, YTraining)
colnames(FullData) <- c(testcolnames, "Subject", "YTraining")
colsSel <- grep(".*Mean.*|.*Std.*", testcolnames)
# And subset the selected data
FullData2 <- FullData[,c(colsSel, 562,563)]
#Replacing Activity number by its Label
activityLabels = read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)
currentActivity = 1
for (currentActivityLabel in activityLabels$V2) {
        FullData2$YTraining <- gsub(currentActivity, currentActivityLabel, FullData2$YTraining)
        currentActivity <- currentActivity + 1
}
FullData2$YTraining <- as.factor(FullData2$YTraining)
FullData2$Subject <- as.factor(FullData2$Subject)
tidy = aggregate(FullData2, by=list(Activity = FullData2$YTraining, Subject=FullData2$Subject), mean)
# Remove the subject and activity column because the information has been aggregated based in those 2 parameters
tidy[,90] = NULL
tidy[,89] = NULL
write.table(tidy, "tidy.txt", sep="\t")
