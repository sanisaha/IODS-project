#name: "Sani saha"
#file description: "human data withgender equality and human developement"
#reference: [http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt]

#reading the data
mydata <- read.table("C:/Users/ratul/Documents/GitHub/IODS-project/data/human.csv", sep = ",", header = T)
str(mydata)
dim(mydata)
colnames(mydata)

#descriptiop of data
#the data has alltogether 195 observation and 19 variables. The variables names are written in short form. "GNI" = Gross National Income per capita
"LEB" = Life expectancy at birth
"E_SCHOOL" = Expected years of schooling 
"MMR" = Maternal mortality ratio
"ABR" = Adolescent birth rate
"PARLIAMENT_S" = Percetange of female representatives in parliament
"EDU2F" = Proportion of females with at least secondary education
"EDU2M" = Proportion of males with at least secondary education
"LabF" = Proportion of females in the labour force
"LabM" " Proportion of males in the labour force
"EDU2_Ratio" = EDU2F / EDU2M
"Lab_Ratio" = LabF / LabM

#1.mutating the data, making GNI variable to numeric.

library(dplyr)
library(stringr)
str(mydata$GNI)
mydata$GNI <- str_replace(mydata$GNI, pattern=",", replace ="") %>% as.numeric()
str(mydata)

#2. keeping only the selected variables
keep <- c("Country", "EDU2_Ratio", "Lab_Ratio", "E_SCHOOL", "LEB", "GNI", "MMR", "ABR", "PARLIAMENT_S")
mydata <- select(mydata, one_of(keep))
colnames(mydata)

#3. Removing rows with no values
complete.cases(mydata)
data.frame(mydata[-1], comp = complete.cases(mydata))
true_mydata <- filter(mydata, complete.cases(mydata))
str(true_mydata)

#4. removing observation those are not related to country and in this case they are the last 7 observation.
last <- nrow(true_mydata) - 7
data <- true_mydata[1:last, ]

#.5 defining rownames by country and removing country variable and finaly make a csv file
rownames(data) <- data$Country
data <- select(data, -Country)
str(data)

write.csv(data, file = "human.csv", row.names = TRUE)
