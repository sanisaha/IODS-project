#Name : "SANI SAHA"
#Date : "11/11/2018"
#File_description : "R exercise 2, Data wragling, combining variables and exclude"
#read data
mydata <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
str(mydata)
dim(mydata)
#from read.table function we can read the data in R. By using 'str' function we can see the structure of the data, all the observation, columns and rows. By using 'dim' we can see dimension of data. how many observation and variables are in the data.
library(dplyr)
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
deep <- select(mydata, one_of(deep_questions))
mydata$deep <- rowMeans(deep)
surf <- select(mydata, one_of(surface_questions))
mydata$surf <- rowMeans(surf)
stra <- select(mydata, one_of(strategic_questions))
mydata$stra <- rowMeans(stra)
colnames(mydata)
keep_columns <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")
new_mydata <- select(mydata, one_of(keep_columns))
str(new_mydata)
new_mydata <- select(mydata, one_of(keep_columns))
str(new_mydata)
finaldata <- filter(new_mydata, Points > 0)
str(finaldata)
head(finaldata)

df <- data.frame(finaldata)
df

write.csv(df, "learning2014.csv")
