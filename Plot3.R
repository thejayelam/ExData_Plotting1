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

png("plot3.png", width = 480, height = 480)
plot(subsetData$DateTime, subsetData$Sub_metering_1, xlab = "", ylab = "Energy Sub Metering", type = "l")
lines(subsetData$DateTime, subsetData$Sub_metering_2, col ="red", type = "l")
lines(subsetData$DateTime, subsetData$Sub_metering_3, col = "blue", type = "l")
legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= 1, lwd=2, col = c("black", "red", "blue"))
dev.off()
