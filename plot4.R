## Check if data exists. If not, download it.
if(!file.exists("household_power_consumption/household_power_consumption.txt")) {
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, destfile = "household_power_consumption.zip", method = "curl")
  unzip("household_power_consumption.zip", exdir = "household_power_consumption")
}

## Read in the data using read.table with correct specifications.
powertable <- read.table("household_power_consumption/household_power_consumption.txt", header = TRUE, sep =";", na.strings = "?", stringsAsFactors = FALSE)

## Convert the dates column to the Date class specifying dd/mm/yyyy format
powertable$Date <- as.Date(powertable$Date, "%d/%m/%Y")

## Extract dates between 2007-02-01 and 2007-02-02 and discard the rest.
useData <- powertable[powertable$Date >= "2007-02-01" & powertable$Date <= "2007-02-02", ]
rm(powertable)

## Convert the Time column to POSIXlt standard date-times.
useData$Time <- strptime(paste(useData$Date,useData$Time,sep=""), format="%Y-%m-%d%H:%M:%S")

## Now we have the clean useful data. Time to start plotting!

## Plot 4 - 4 different plots of Global Active Power, Voltage, Sub_metering 1,2 and 3, and Global_reactive_power vs Time
png(filename = 'plot4.png', width = 480, height = 480, units = 'px')

par(mar = c(4, 5, 0.5, 0.8))
par(mfcol = (c(2, 2)))
par(cex.axis = 0.8)
par(cex.sub = 1)
par(cex.lab = 1)
 
#1st plot
plot(useData$Time, useData$Global_active_power, xlab = "", ylab = "Global Active Power", type = "l")

#2nd plot
with(useData, plot(Time, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l", col = "black"))
with(useData, lines(Time, Sub_metering_2, col = "red"))
with(useData, lines(Time, Sub_metering_3, col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col = c("black", "red", "blue"), cex = 0.7, bty = "n")
 
#3rd plot
plot(useData$Time, useData$Voltage, xlab = "datetime", ylab = "Voltage", type= "l")
 
#4th plot
plot(useData$Time, useData$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type= "l")

dev.off()
