library(dplyr)


# Read test data
subject_test <- read.table("subject_test.txt", quote="\"")
X_test <- read.table("X_test.txt", quote="\"")
y_test <- read.table("y_test.txt", quote="\"")

# Read training data
subject_train <- read.table("subject_train.txt", quote="\"")
X_train <- read.table("X_train.txt", quote="\"")
y_train <- read.table("y_train.txt", quote="\"")

# Read features, i.e., names of columns in X
features <- read.table("features.txt", quote="\"")

# Read activity labels
activity_labels <- read.table("activity_labels.txt", quote="\"")

# Combine the train and test data
subject <- bind_rows(subject_train, subject_test)
X <- bind_rows(X_train, X_test)
y <- bind_rows(y_train, y_test)

# Rename variables using descriptive titles
subject <- rename(subject, Subject = V1)
y <- rename(y, Activity = V1)

# Add the names of the activities to y
y$Activity <- as.character(activity_labels[match(y$Activity, 
                                                 activity_labels$V1), 'V2'])

# Use the variable names from features.txt to name the columns of X
# and subset those with mean or std in the name
colnames(X) <- features$V2 
subX <- X[, as.vector(grep("mean|std", colnames(X), value=FALSE))]

# Create a single data frame with all the relevant values
meanStd.Data <- bind_cols(subject, y, subX)

# Create tidy data set with averages of each variable for activity and subject

tidy.Summary <- meanStd.Data %>% group_by(Activity,Subject) %>% summarise_each(funs(mean))












