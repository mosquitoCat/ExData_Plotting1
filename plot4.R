# Load library
library(dplyr)

# Calcute memory required for reading the dataset
# memory_required = ncol * nrow * 8/1073741824 (GB)
memory_required = 2075259 * 9 * 8/1073741824
memory_required

# Read in dataset
df <- read.csv("~/Downloads/household_power_consumption.txt", sep = ";")
df [df == "?"] <- NA

# Subset the dataset using the provided dates
newdf <- subset(df, Date == "1/2/2007" | Date == "2/2/2007")

# Add two new columns - DataTime and Weekday
newdf <- newdf %>% mutate (DateTime = as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"), Weekday = weekdays(as.Date(DateTime), abbreviate = T), Global_active_power = as.numeric(as.character(Global_active_power)), Sub_metering_1 = as.numeric(as.character(Sub_metering_1)), Sub_metering_2 = as.numeric(as.character(Sub_metering_2)), Voltage = as.numeric(as.character(Voltage)), Global_reactive_power = as.numeric(as.character(Global_reactive_power)))

# Generate plot4 - a 2x2 panel 
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))
# subplot1 - already generated
plot(newdf$DateTime, newdf$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "n")
lines(newdf$DateTime, newdf$Global_active_power)
# subplot2 - a line graph of Voltage against time
plot(newdf$DateTime, newdf$Voltage, xlab = "datetime", ylab = "Voltage", type = "n")
lines(newdf$DateTime, newdf$Voltage)
# subplot3 - already generated
plot(newdf$DateTime, newdf$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n")
lines(newdf$DateTime, newdf$Sub_metering_1, col = "black")
lines(newdf$DateTime, newdf$Sub_metering_2, col = "red")
lines(newdf$DateTime, newdf$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")
# subplot4 - a line graph of global reactive power against time
plot(newdf$DateTime, newdf$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "n")
lines(newdf$DateTime, newdf$Global_reactive_power)
dev.off()



