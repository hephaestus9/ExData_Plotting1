#http://stackoverflow.com/questions/7597559/grep-in-r-with-a-list-of-patterns

#Set wd
setwd("C:\\Users\\jeramy\\Documents\\Coursera\\Exploratory Data Analysis")

#Get subset of data
text = grep(paste(c("^1/2/2007", "^2/2/2007"),collapse="|"), readLines("household_power_consumption.txt"), value=TRUE)
labels = readLines("household_power_consumption.txt", n=1)
text = paste(c(labels, text))
data = read.table(text=text, sep=";", header=TRUE)
remove(text)
remove(labels)

#Change Date column
data$Date = as.Date(data$Date, format=("%d/%m/%Y"))

#Space required for subset
subset_space_required = (nrow(data) * ncol(data) * 8) / (2^20)

#Create plot 3
png(file="plot3.png",width=480,height=480,res=90)
xrange = range(as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S"))
yrange = range(0,as.double(data$Sub_metering_1))

plot(xrange, yrange, type="n", xlab = "", ylab = "Global Active Power (kilowatts)")

lines(as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S"), as.double(data$Sub_metering_1), type="l", col="black")
lines(as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S"), as.double(data$Sub_metering_2), type="l", col="red")
lines(as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S"), as.double(data$Sub_metering_3), type="l", col="blue")
legend(x="topright",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1)
dev.off()