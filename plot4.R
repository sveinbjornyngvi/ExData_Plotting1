#Activate library to format time.
library(chron)

#Read in data, convert date and time, subset the two dates, merge time and date and then remove the big data set.
hpc <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings ="?")
hpc$Date <- as.Date(hpc$Date, format='%d/%m/%Y')
hpc$Time <- chron(times=hpc$Time)
hpc.df <- subset(hpc[hpc$Date >= "2007-02-01" & hpc$Date <= "2007-02-02",])
hpc.df$datetime <- as.POSIXct(paste(hpc.df$Date, hpc.df$Time), format="%Y-%m-%d %H:%M:%S")
rm(hpc)

#Open png graphics device, define how many plots (2 rows, 2 columns) plot a, b, c and d and then close device.
png("plot4.png", width = 480, height = 480)

par(mfrow = c(2, 2))

#Plot a
plot(hpc.df$datetime, hpc.df$Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type = "n")
lines(hpc.df$datetime, hpc.df$Global_active_power)

#Plot b
plot(hpc.df$datetime, hpc.df$Voltage, xlab="datetime", ylab="Voltage", type = "n")
lines(hpc.df$datetime, hpc.df$Voltage)

# Plot c
plot(hpc.df$datetime, hpc.df$Sub_metering_1, xlab="", ylab="Energy sub metering", type = "l", col = "black")
lines(hpc.df$datetime, hpc.df$Sub_metering_2, col = "red")
lines(hpc.df$datetime, hpc.df$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c("solid", "solid", "solid"), col = c("black", "red", "blue"))

#Plot d
plot(hpc.df$datetime, hpc.df$Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", type = "n")
lines(hpc.df$datetime, hpc.df$Global_reactive_power)

dev.off()