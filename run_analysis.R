tidydata <- function(workingdir) {
	x_train <- read.table(paste(workingdir, "/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", sep =""))
	y_train <- read.table(paste(workingdir, "/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt", sep =""))
	subject_train <- read.table(paste(workingdir, "/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", sep =""))
	train <- cbind(y_train, x_train)
	train <- cbind(subject_train, train)

	x_test <- read.table(paste(workingdir, "/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt",sep=""))
	y_test <- read.table(paste(workingdir, "/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt",sep=""))
	subject_test <- read.table(paste(workingdir, "/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt",sep=""))
	test <- cbind(y_test, x_test)
	test <- cbind(subject_test, test)

	alldata <- rbind(train, test)
	valid_column_names <- make.names(name=names(alldata),unique=TRUE)
	names(alldata) <- valid_column_names
	library(dplyr)
	alldata_df <- tbl_df(alldata)
	meanstd <- select(alldata_df, 1:8, 43:48, 83:88, 123:128, 163:168, 203:204, 216:217, 229:230, 242:243, 255:256, 268:273, 347:352, 426:431, 505:506, 518:519, 531:532, 544:545)

	activitynames <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
	meanstd$V1.1 <- activitynames[meanstd$V1.1]

	names(meanstd) <- c("subject","activity","timeBodyAccMeanX","timeBodyAccMeanY","timeBodyAccMeanZ","timeBodyAccStdX","timeBodyAccStdY","timeBodyAccStdZ","timeGravityAccMeanX","timeGravityAccMeanY","timeGravityAccMeanZ","timeGravityAccStdX","timeGravityAccStdY","timeGravityAccStdZ","timeBodyAccJerkMeanX","timeBodyAccJerkMeanY","timeBodyAccJerkMeanZ","timeBodyAccJerkStdX","timeBodyAccJerkStdY","timeBodyAccJerkStdZ","timeBodyGyroMeanX","timeBodyGyroMeanY","timeBodyGyroMeanZ","timeBodyGyroStdX","timeBodyGyroStdY","timeBodyGyroStdZ","timeBodyGyroJerkMeanX","timeBodyGyroJerkMeanY","timeBodyGyroJerkMeanZ","timeBodyGyroJerkStdX","timeBodyGyroJerkStdY","timeBodyGyroJerkStdZ","timeBodyAccMagMean","timeBodyAccMagStd","timeGravityAccMagMean","timeGravityAccMagStd","timeBodyAccJerkMagMean","timeBodyAccJerkMagStd","timeBodyGyroMagMean","timeBodyGyroMagStd","timeBodyGyroJerkMagMean","timeBodyGyroJerkMagStd","freqBodyAccMeanX","freqBodyAccMeanY","freqBodyAccMeanZ","freqBodyAccStdX","freqBodyAccStdY","freqBodyAccStdZ","freqBodyAccJerkMeanX","freqBodyAccJerkMeanY","freqBodyAccJerkMeanZ","freqBodyAccJerkStdX","freqBodyAccJerkStdY","freqBodyAccJerkStdZ","freqBodyGyroMeanX","freqBodyGyroMeanY","freqBodyGyroMeanZ","freqBodyGyroStdX","freqBodyGyroStdY","freqBodyGyroStdZ","freqBodyAccMagMean","freqBodyAccMagStd","freqBodyBodyAccJerkMagMean","freqBodyBodyAccJerkMagStd","freqBodyBodyGyroMagMean","freqBodyBodyGyroMagStd","freqBodyBodyGyroJerkMagMean","freqBodyBodyGyroJerkMagStd")

	grouped <- group_by(meanstd,subject,activity)
	newdata <- summarize_each(grouped,funs(mean))
	write.table(newdata,paste(workingdir, "/tidydata.txt"),row.names=FALSE)

}
