#Name : SANI SAHA
#Data : 09/12/2018
#File description : BPRS and RATS data from GitHub repository of MABS (make longitudinal data)

BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep = '', header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep = '', header = T)
names(BPRS)
names(RATS)
str(BPRS)
str(RATS)
summary(BPRS)
summary(RATS)


library(dplyr)
library(tidyr)

BPRS$subject <- factor(BPRS$subject)
BPRS$treatment <- factor(BPRS$treatment)
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))

RATSL <-  RATS %>% gather(key = WD, value = weight, -ID, -Group)
RATSL <-  RATSL %>% mutate(Time = as.integer(substr(WD,3,4)))

glimpse(BPRSL)
glimpse(RATSL)

str(BPRSL)
str(BPRS)
str(RATS)
str(RATSL)



#The wide data contain more variables than longitudinal data. Wide data contain more number of variables as they present each week result. Where in longitudinal data
#, we collapes the all obersvation of weeks under a new variable name weeks. so in long data different weeks observations are in their own single column but in different rows, where in wide data they are in different columns. So, wide data is good more individual reading but long data is good for machine reading.  

df1 <- data.frame(BPRSL)
df2 <- data.frame(RATSL)

write.csv(df1, "BPRSL.csv")
write.csv(df2, "RATSL.csv")
                           
                           