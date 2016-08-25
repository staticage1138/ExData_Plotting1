## Setup directory if needed,
oldwd <- getwd()

if(!file.exists("./datasciencecoursera/ExData_Plotting1/"))
{
        dir.create("./datasciencecoursera/ExData_Plotting1/",showWarnings = FALSE,recursive = TRUE)
}

setwd("./datasciencecoursera/ExData_Plotting1/")


## Check if data is available.  Download and unzip if it is not.
fname <- "household_power_consumption.txt"
zipname <- "exdata_data_household_power_consumption.zip"
zipurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if(!file.exists(fname))
{
        if(!file.exists(zipname))  
        {
                download.file(zipurl,zipname)
        }
        unzip(zipname)
}

## Get required packages.
require(dplyr)
require(tidyr)
require(data.table)
require(lubridate)


## Import the data set using fread().
classes <- c("date","character",rep("numeric",7))

if(!exists("hh.power.consumption"))
{
        hh.power.consumption <- tbl_df(fread(fname,
                                             colClasses = classes,
                                             na.strings="?"))
}

## Filter data set and add additional datetime column.
hh.power.consumption <- hh.power.consumption %>%
        filter((Date=="1/2/2007"|Date=="2/2/2007")) %>%
        mutate(datetime=parse_date_time(paste(Date,Time),
                                        "%d%m%y hms"))

png("plot2.png",width=480,height=480)
with(hh.power.consumption,
        plot(datetime,
             Global_active_power,
             type="l",
             ylab="Global Active Power (kilowatts)",
             xlab=""))
dev.off()

setwd(oldwd)