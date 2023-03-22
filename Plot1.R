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

#Constructing the plot 1 and saving it as PNG

png("plot1.png", width = 480, height = 480)
hist(subsetData$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (Kilowatts)", ylab = "Frequency", col = "red")
dev.off()