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

## Plot 3 - Sub_metering 1,2 and 3 vs DateTime
png(filename = 'plot3.png', width = 480, height = 480, units = 'px')
par(mar = c(2, 4, 1, 1))
with(useData, plot(Time, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l", col = "black"))
with(useData, lines(Time, Sub_metering_2, col = "red"))
with(useData, lines(Time, Sub_metering_3, col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col = c("black", "red", "blue"), cex = 0.7)
dev.off()