
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)

gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

str(hd)
dim(hd)
colnames(hd)
names(hd) <- c("HDI Rank", "Country", "HDI", "LEB", "E_SCHOOL", "M_SCHOOL", "GNI", "GNI_PC")

str(gii)
str(gii)
colnames(gii)
names(gii) <- c("GII RANK", "Country", "GII", "MMR", "ABR", "PARLIAMENT_S", "EDU2F", "EDU2M", "LabF", "LabM") 

library(dplyr)
gii <- mutate(gii, EDU2_Ratio = EDU2F / EDU2M)
gii <- mutate(gii, Lab_Ratio = LabF / LabM)
colnames(gii)

join_by <- c("Country")
jdata <- inner_join(hd, gii, by = join_by, suffix = c(".hd", ".gii"))
colnames(jdata)
human <- jdata
human
glimpse(human) 

df <- data.frame(human)
df

write.csv(df, "human.csv")
