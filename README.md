Author: Jaroslaw Jedrzejowski

Script run_analysis.R is desiged to be run from a directory, where unpacked Samsung data is located as a "UCI HAR Dataset" directory
In the current directory, the "descriptives.txt" file needs to be present for step 4 of the assignment

Script starts with loading test and training data and providing those sets with original labels. At this stage, activities and subjects are joined to the datasets.
Then, test and training data are merged.

Next, variables that contain mean and standard deviation values are identified, and the sets are reduced only to the corresponding columns (Step 2)

Step 3: activity id's are replaced by descriptive names, by merging the activity translation table with the dataset.

Next, descriptive labels are provided (Step 4) 
Next, reshape functions are used to aggregate data as average, for each subject and activity (Step 5), and the resulting dataset is saved to a file "tidyData.txt" in the current directory.