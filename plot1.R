library(XML)
library(dplyr)
library(xlsx)
library(RCurl)
library(data.table)
library(utils)

setwd("H:/Public/Coursera/Exploratory Data Analysis")
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./courseproject1.zip")
unzip("courseproject1.zip")
data <- read.table("H:/Public/Coursera/Exploratory Data Analysis/household_power_consumption.txt", sep=";", header=TRUE, stringsAsFactors = FALSE)
head(data)

data$Date <- as.character(data$Date)
datasub <- subset(data, Date=="1/2/2007" | Date=="2/2/2007")
data$Time <- as.character(data$Time)

datasub$DateTime <- paste(datasub$Date, datasub$Time)
datasub$DateTime <- strptime(datasub$DateTime, "%d/%m/%Y %H:%M:%S","GMT")    

##plot1.R
datasub$Global_active_power <- as.numeric(datasub$Global_active_power)
png("plot1.png", width=480, height=480, units="px")
hist(datasub$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red", border=NULL)
dev.off()
