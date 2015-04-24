# Read the "UCI HAR Dataset" and builds a single and tidy dataset

library(data.table)

run_analysis <- function(uci_har_dataset_path = "./UCI HAR Dataset") {
    cat("Running analysis over dataset at ", uci_har_dataset_path, " (expected UCI HAR Dataset)\n")
    
    # Features from data that we are considering
    feature_list <- data.table(read.table(file.path(uci_har_dataset_path, "features.txt")))
    feature_list <- feature_list[, consider:=grepl("std\\(\\)|mean\\(\\)",feature_list$V2)]
    data_cols <- feature_list[feature_list$consider, 1, with=FALSE]
    
    # test data  
    print("Working on TEST data")
    base_path <- file.path(uci_har_dataset_path, "test")
    test_data <- tidy_dataset(file.path(base_path, "subject_test.txt"), # Individuals
                              file.path(base_path, "y_test.txt"),       # Activities
                              file.path(base_path, "X_test.txt"),       # Features
                              data_cols                # - feature selection
    )
    
    # train data
    print("Working on TRAIN data")
    base_path <- file.path(uci_har_dataset_path, "train")
    train_data <- tidy_dataset(file.path(base_path, "subject_train.txt"),
                               file.path(base_path, "y_train.txt"),
                               file.path(base_path, "X_train.txt"),
                               data_cols
    )

    print("Tidying it up: assigning labels to activities and names to variables")
    # Append datasets
    data <- rbind(test_data, train_data)
    
    # Rename columns
    data_cols_names <- feature_list[feature_list$consider, 2, with=FALSE]
    names <- append(c("volunteerID", "activity"), as.character(data_cols_names[[1]]))
    names(data) <- names
    
    # Use activity labels
    activities <- read.table(file.path(uci_har_dataset_path, "activity_labels.txt"))
    data$activity <- as.character(activities[match(data$activity, activities$V1), 'V2'])
    data$activity <- as.factor(data$activity)
    
    # Create table averaging each variable
    compute_avg(data)    
}


tidy_dataset <- function(volunteersFile, activitiesFile, dataFile, data_cols) {
    # Read each data file from disk
    volunteers <- read.table(volunteersFile)
    activities <- read.table(activitiesFile)
    data <- read.table(dataFile)
    
    # Filter data table by columns
    data <- data[, data_cols[[1]]] # This way of getting a vector from data_cols is a little bit weird :/

    # Check files are valid
    if ((nrow(volunteers) != nrow(activities)) || (nrow(volunteers) != nrow(data)) ) {
        stop("Files must have the same number of rows in order to be merged into a tidy dataset")
    }
    
    #cat("Subject file has dimensions:", dim(subjects), "\n")
    #cat("Activities file has dimensions:", dim(activities), "\n")
    #cat("Data file has dimensiones:", dim(data), "\n")
    
    r <- cbind(volunteers, activities, data)
    r
}

compute_avg <- function(dataset) {
    data <- dataset
    if(!is.data.table(dataset)) {
        data <- data.table(dataset)
    }
    data <- data[, lapply(.SD, mean), by=list(volunteerID, activity)]
    data
}

debug_script <- function(outputFile = "output.txt") {
    path <- "./UCI HAR Dataset"
    data <- run_analysis(path)
    write.table(data, outputFile, row.names=FALSE)
}
