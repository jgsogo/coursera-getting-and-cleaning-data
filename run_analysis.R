# Read the "UCI HAR Dataset" and builds a single and tidy dataset

run_analysis <- function(uci_har_dataset_path = "./UCI HAR Dataset") {
    cat("Running analysis over dataset at ", uci_har_dataset_path, " (expected UCI HAR Dataset)\n")
    
    # Feautres from data that we are considering
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
    #print("Working on TRAIN data")
    #base_path <- file.path(uci_har_dataset_path, "train")
    #test_data <- tidy_dataset(file.path(base_path, "subject_train.txt"),
    #                          file.path(base_path, "y_train.txt"),
    #                          file.path(base_path, "X_train.txt")
    #)

    # Append datasets
    data <- rbind(test_data, test_data)
    
    # Rename columns
    data_cols_names <- feature_list[feature_list$consider, 2, with=FALSE]
    names <- append(c("individual", "activity"), data_cols_names[[1]])
    names(data) <- names
    data
}


tidy_dataset <- function(subjectsFile, activitiesFile, dataFile, data_cols) {
    # Read each data file from disk
    subjects <- read.table(subjectsFile)
    activities <- read.table(activitiesFile)
    data <- read.table(dataFile)
    
    # Filter data table by columns
    data <- data[, data_cols[[1]]] # This way of getting a vector from data_cols is a little bit weird :/

    # Check files are valid
    if ((nrow(subjects) != nrow(activities)) || (nrow(subjects) != nrow(data)) ) {
        stop("Files must have the same number of rows in order to be merged into a tidy dataset")
    }
    
    #cat("Subject file has dimensions:", dim(subjects), "\n")
    #cat("Activities file has dimensions:", dim(activities), "\n")
    #cat("Data file has dimensiones:", dim(data), "\n")
    
    r <- cbind(subjects, activities, data)
    r
    }
