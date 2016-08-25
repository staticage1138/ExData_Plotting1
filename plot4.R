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

png("plot4.png",width=480,height=480)
par(mfrow=c(2,2))

## Upper left.
with(hh.power.consumption,
     plot(datetime,
          Global_active_power,
          type="l",
          ylab="Global Active Power",
          xlab=""))

## Upper Right
with(hh.power.consumption,
     plot(datetime,
          Voltage,
          type="l",
          ylab="Voltage"))

## Lower Left
with(hh.power.consumption,
     plot(datetime,
          Sub_metering_1,
          type="l",
          ylab="Energy sub metering",
          xlab=""))
with(hh.power.consumption,
     lines(datetime,
           Sub_metering_2,
           col="red"))
with(hh.power.consumption,
     lines(datetime,
           Sub_metering_3,
           col="blue"))
legend("topright",
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lwd=1,
       col=c("black","red","blue"),
       bty="n",
       cex=0.9)

## Lower Right
with(hh.power.consumption,
     plot(datetime,
          Global_reactive_power,
          type="l"))

dev.off()

setwd(oldwd)