
trainx <- read.table("train/trainx.txt")
trainy <- read.table("train/trainy.txt")
subject_train <- read.table("train/subject_train.txt")

xtest <- read.table("test/Xtest.txt")
ytest <- read.table("test/ytest.txt")
subject <- read.table("test/subject.txt")

# create first data set
x_dataset <- rbind(trainx, xtest)
# create second data set
y_dataset <- rbind(trainy, ytest)

# create the topic data set
topicdata <- rbind(topictrain, topictest)


features <- read.table("features.txt")

# pull only columns with mean and sd
meansdfeatures <- grep("-(mean|std)\\(\\)", features[, 2])

# subset the x data
xdata <- xdata[, meansdfeatures]

# change the column names
names(xdata) <- features[meansdfeatures, 2]

#name the ativities 

activities <- read.table("activity_names.txt")

# change the y data set to the correct data names
ydata[, 1] <- activities[ydata[, 1], 2]

# correct names
names(y_data) <- "activity"


# correct column name
names(subject_data) <- "subject"

# bind all the data in a single data set
all_data <- cbind(xdata, ydata, subject_data)

averages_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(averages_data, "dataset.txt", row.name=FALSE)