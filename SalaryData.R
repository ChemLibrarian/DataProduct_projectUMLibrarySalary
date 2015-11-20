
# Data retrived from Faculty and Staff Salary Data 
# from the University of Michigan. 
# http://quod.lib.umich.edu/e/errwpc/public/3/3/1/3314612.html

# Year coverage 2002 -2014

#loading data
UMSalary2002 <- read.csv("/SalaryRawData/UMSalary2002.csv")
UMSalary2003 <- read.csv("/SalaryRawData/UMSalary2003.csv")
UMSalary2004 <- read.csv("/SalaryRawData/UMSalary2004.csv", header=FALSE)
UMSalary2005 <- read.csv("/SalaryRawData/UMSalary2005.csv")
UMSalary2006 <- read.csv("/SalaryRawData/UMSalary2006.csv")
UMSalary2007 <- read.csv("/SalaryRawData/UMSalary2007.csv")
UMSalary2008 <- read.csv("/SalaryRawData/UMSalary2008.csv")
UMSalary2009 <- read.csv("/SalaryRawData/UMSalary2009.csv")
UMSalary2010 <- read.csv("/SalaryRawData/UMSalary2010.csv")
UMSalary2011 <- read.csv("/SalaryRawData/UMSalary2011.csv")
UMSalary2012 <- read.csv("/SalaryRawData/UMSalary2012.csv")
UMSalary2013 <- read.csv("/SalaryRawData/UMSalary2013.csv")
UMSalary2014 <- read.csv("/SalaryRawData/UMSalary2014.csv")

summary(UMSalary2014)
summary(UMSalary2002)
str(UMSalary2002)
str(UMSalary2004)
summary(UMSalary2004)

# Add a column for Year and combine data into one data frame
library(dplyr)
UMSalary2002_2014 <- data.frame()
for (i in 2002:2014)
{
        filename <- as.symbol(paste("UMSalary", i, sep = ""))
        temp <- eval(filename)
        names(temp) <- names(UMSalary2014)
        UMSalary2002_2014 <- rbind(UMSalary2002_2014, mutate(temp, Year = i))
}

str(UMSalary2002_2014)

# remove Name column
UMSalary2002_2014_NoName <- select(UMSalary2002_2014, -NAME) 

# convert the salary column to numeric
UMSalary2002_2014_NoName <- transform(UMSalary2002_2014_NoName, APPT.ANNUAL.FTR = as.numeric(gsub(",","",APPT.ANNUAL.FTR)))

summary(UMSalary2002_2014_NoName)
head(UMSalary2002_2014_NoName$APPT.ANNUAL.FTR)
class(UMSalary2002_2014_NoName$APPT.ANNUAL.FTR)

# plot graph for year increase of library for different job type. 

# plotdata <- UMSalary2002_2014_NoName %>%
#         filter(APPT.FTR.BASIS == "12-Month") %>%
#         group_by(CAMPUS, APPOINTING.DEPT, APPOINTMENT.TITLE, Year) %>%
#         summarise(Average = mean(APPT.ANNUAL.FTR))
# 
# plotdata_library <- subset(plotdata, grepl("^Library", plotdata$APPOINTING.DEPT) )
# plotdata_library_sum <- plotdata_library %>%
#         group_by(APPOINTMENT.TITLE, Year) %>%
#         summarise(Average = mean(Average))

UMLibrarySalary_2002_2014 <- subset(UMSalary2002_2014_NoName, grepl("^Library", UMSalary2002_2014_NoName$APPOINTING.DEPT))
summary(UMLibrarySalary_2002_2014)
str(UMLibrarySalary_2002_2014)
head(UMLibrarySalary_2002_2014)

plotdata_library <- UMLibrarySalary_2002_2014 %>%
         filter(APPT.FTR.BASIS == "12-Month")

write.csv(plotdata_library, file = "UMLibrarySalary2002_2014.csv", row.names = FALSE)

# The following codes were used when exploring what can be plotted. 
#         group_by(APPOINTMENT.TITLE, Year) %>%
#         summarise(Average = mean(APPT.ANNUAL.FTR), Median = median(APPT.ANNUAL.FTR))
# 
# str(plotdata_library)
# summary(plotdata_library)
# 
# write.csv(plotdata_library, file = "UMLibrarySalarySummary2002_2014.csv", row.names = FALSE)

# plotdata_library_use <- plotdata_library %>%
#         filter(APPOINTMENT.TITLE == "LIBRARIAN")
# 
# library(ggplot2)
# ggplot(plotdata_library_use, aes(x = Year, y = Median)) +
#         geom_bar(stat = "identity") 
