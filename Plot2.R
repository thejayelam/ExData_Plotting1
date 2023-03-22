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

#Constructing the plot 2 and saving it as PNG

png("plot2.png", width = 480, height = 480)
plot(subsetData$DateTime,subsetData$Global_active_power, xlab = "", ylab = "Global Active Power (Kilowatts)", type = "l")
dev.off()
