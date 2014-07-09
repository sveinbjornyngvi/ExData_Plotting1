#Activate library to format time.
library(chron)

#Read in data, convert date and time and subset the two dates.
hpc <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings ="?")
hpc$Date <- as.Date(hpc$Date, format='%d/%m/%Y')
hpc$Time <- chron(times=hpc$Time)
hpc.df <- subset(hpc[hpc$Date >= "2007-02-01" & hpc$Date <= "2007-02-02",])

#Open png graphics device, plot Global Active Power and close device.
png("plot1.png", width = 480, height = 480)
hist(hpc.df$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()