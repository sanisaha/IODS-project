Name : "Sani Saha"
Date : "13/11/2018"
File description : "Student performing data sets (including alcohol consumption)" 
[Reference](https://archive.ics.uci.edu/ml/datasets/Student+Performance)
data1 <- read.csv("student-mat.csv", sep = ";", header = T)
str(data1)
data2 <- read.csv("student-por.csv", sep = ";", header = T)
str(data2)

library(dplyr)
library(ggplot2)

join_by <- c("school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet")

# join the two datasets by the selected identifiers
j_data <- inner_join(data1, data2, by = join_by, suffix = c(".data1", ".data2"))
colnames(j_data)
str(j_data)
dim(j_data)

# create a new data frame with only the joined columns
alc <- select(j_data, one_of(join_by))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(data1)[!colnames(data1) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(j_data, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# initialize a plot of alcohol use
g1 <- ggplot(data = alc, aes(x = alc_use))

# define the plot as a bar plot and draw it
g1 + geom_bar(aes(fill = sex))

# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)

# initialize a plot of 'high_use'
g2 <- ggplot(data = alc, aes(x = high_use))

# draw a bar plot of high_use by sex
g2 + geom_bar() + facet_wrap("sex")

dim(j_data)
str(alc)
dim(alc)



# glimpse at the alc data
glimpse(alc) 

df <- data.frame(alc)
df

write.csv(df, "alc.csv")
