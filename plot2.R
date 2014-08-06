## Read in the data. Here, csv2 is used because it specifies header=TRUE and sep=";" by default.
powertable <- read.table("household_power_consumption.txt", header = TRUE, sep =";", na.strings = "?", stringsAsFactors = FALSE)

## Convert the dates column to the Date class specifying dd/mm/yyyy format
powertable$Date <- as.Date(powertable$Date, "%d/%m/%Y")

## Extract dates between 2007-02-01 and 2007-02-02 and discard the rest.
useData <- powertable[powertable$Date >= "2007-02-01" & powertable$Date <= "2007-02-02", ]
rm(powertable)

## Convert the Time column to POSIXlt standard date-times.
useData$Time <- strptime(paste(useData$Date,useData$Time,sep=""), format="%Y-%m-%d%H:%M:%S")

## Now we have the clean useful data. Time to start plotting!

## Plot 2 - Global Active Power vs DateTime
png(filename = 'plot2.png', width = 480, height = 480, units = 'px')
plot(useData$Time, useData$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")
dev.off()