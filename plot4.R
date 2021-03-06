library(XML)
library(dplyr)
library(xlsx)
library(RCurl)
library(data.table)
#library(swirl)
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


##plot4.R
datasub$Voltage <- as.numeric(datasub$Voltage)
datasub$Sub_metering_1 <- as.numeric(datasub$Sub_metering_1)
datasub$Sub_metering_2 <- as.numeric(datasub$Sub_metering_2)
datasub$Sub_metering_3 <- as.numeric(datasub$Sub_metering_3)
datasub$Global_reactive_power <- as.numeric(datasub$Global_reactive_power)

png("plot4.png", width=480, height=480, units="px")
par(mfrow=c(2,2))

plot(x = datasub$DateTime, y = datasub$Global_active_power, type = "l", main=NULL, ylab="Global Active Power (kilowatts)", xlab="")

plot(x = datasub$DateTime, y = datasub$Voltage, type = "l", main=NULL, ylab="Voltage", xlab="datetime")

plot(x = datasub$DateTime, y = datasub$Sub_metering_1, type = "l", main=NULL, ylab="Energy sub metering", xlab="")
lines(x = datasub$DateTime, y = datasub$Sub_metering_2, col = "red", ylim=c(0,40))
lines(x = datasub$DateTime, y = datasub$Sub_metering_3, col = "blue", ylim=c(0,40))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), col=c("black", "red", "blue"), cex=0.5)

plot(x = datasub$DateTime, y = datasub$Global_reactive_power, type = "l", main=NULL, ylab="Global_reactive_power", xlab="datetime")
dev.off()