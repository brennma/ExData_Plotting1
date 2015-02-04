## Load the required packages
library(graphics)
library(grDevices)

## Read in household power consumption data
powerConsumption <- read.table("../Assignment1Data/household_power_consumption.txt",sep = ";", stringsAsFactors = FALSE, header=TRUE)

## Convert the string date into a Date class
powerConsumption$Date <- as.Date(powerConsumption$Date, format = "%d/%m/%Y")


## Get the subset of only Feb 1st and 2nd of 2007 to analyze
febPower <- powerConsumption[format(powerConsumption$Date,"%m/%d/%Y") %in% c("02/01/2007","02/02/2007"),]

## Convert the string time to POSIXct
febPower$Time <- strptime(febPower$Time, "%H:%M:%S")

## Ensure Global_active_power is a numeric class
febPower$Global_active_power <- as.numeric(febPower$Global_active_power)

## Create a DateTime variable for the X axis of the plot
febPower$DateTime <- strptime(paste(format(febPower$Date, "%m/%d/%Y"),format(febPower$Time,"%H:%M:%S")), "%m/%d/%Y %H:%M:%S")


## Open the png device with a size of 480px by 480px
png(file = "plot4.png",height = 480, width = 480)
par(mfrow=c(2,2))

## Create the 4 quadrant of plots of Global Active Power, voltage, Sub metering for meters 1,2,3 and global reactive power
with(febPower, {
  plot(x = DateTime, y = Global_active_power, type = "l",xlab="datetime", ylab="Global Active Power")
  plot(x = DateTime, y = Voltage, type = "l",xlab="datetime")
  plot(x = febPower$DateTime, y = febPower$Sub_metering_1, type = "n",xlab="", ylab = "Energy sub metering")
    points(x = febPower$DateTime, y = febPower$Sub_metering_1, type = "l", col="black")
    points(x = febPower$DateTime, y = febPower$Sub_metering_2, type = "l", col="red")
    points(x = febPower$DateTime, y = febPower$Sub_metering_3, type = "l", col="blue")
    legend("topright",lwd=1,col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")) 
  plot(x = DateTime, y = Global_reactive_power, type = "l",xlab="datetime")
})

## Close the png device to write the file.
dev.off()