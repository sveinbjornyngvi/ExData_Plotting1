#Activate library to format time.
library(chron)

#Read in data, convert date and time, subset the two dates, merge time and date and then remove the big data set.
hpc <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings ="?")
hpc$Date <- as.Date(hpc$Date, format='%d/%m/%Y')
hpc$Time <- chron(times=hpc$Time)
hpc.df <- subset(hpc[hpc$Date >= "2007-02-01" & hpc$Date <= "2007-02-02",])
hpc.df$datetime <- as.POSIXct(paste(hpc.df$Date, hpc.df$Time), format="%Y-%m-%d %H:%M:%S")
rm(hpc)

#Open png graphics device, plot Energy sub metering(1,2,3) against date and time, add legend and then close device.
png("plot3.png", width = 480, height = 480)
plot(hpc.df$datetime, hpc.df$Sub_metering_1, xlab="", ylab="Energy sub metering", type = "l", col = "black")
lines(hpc.df$datetime, hpc.df$Sub_metering_2, col = "red")
lines(hpc.df$datetime, hpc.df$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c("solid", "solid", "solid"), col = c("black", "red", "blue"))
dev.off()