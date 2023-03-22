#datasource

datafileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
datafile <- "household_power_consumption.zip"

if(!file.exists(datafile)){
        download.file(datafileURL, datafile, method = "curl")
}
if(!file.exists("household_power_consumption.txt")){
        unzip(datafile)
}

#Loading the data

data <- read.csv("household_power_consumption.txt", header=TRUE, sep=';', stringsAsFactors = FALSE, na.strings = "?")

#Subsetting the data to only include dates 1/2/2007 and 2/2/2007

subsetData <-  subset(data, Date %in% c("1/2/2007","2/2/2007"))

#Converting Date/Time variables to Date/Time Classes
subsetData$Date <- as.Date(subsetData$Date, format = "%d/%m/%Y") 
subsetData$DateTime <- as.POSIXct(paste(subsetData$Date, subsetData$Time)) 

#Constructing the plot 3 and saving it as PNG

png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2)) #Creating 4 plots on the same screen
#plot1
plot(subsetData$DateTime,subsetData$Global_active_power, xlab = "", ylab = "Global Active Power (Kilowatts)", type = "l")
#plot2
plot(subsetData$DateTime,subsetData$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")
#plot3
plot(subsetData$DateTime, subsetData$Sub_metering_1, xlab = "", ylab = "Energy Sub Metering", type = "l")
lines(subsetData$DateTime, subsetData$Sub_metering_2, col ="red", type = "l")
lines(subsetData$DateTime, subsetData$Sub_metering_3, col = "blue", type = "l")
legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= 1, lwd=2, col = c("black", "red", "blue"))
#plot4
plot(subsetData$DateTime,subsetData$Global_reactive_power, xlab = "datetime", ylab = "Global_Reactive_Power", type = "l")
dev.off() 
