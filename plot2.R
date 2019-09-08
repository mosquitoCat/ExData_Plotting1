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

# Generate plot2 - a line graph of global active power 
png("plot2.png", width = 480, height = 480)
plot(newdf$DateTime, newdf$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "n")
lines(newdf$DateTime, newdf$Global_active_power)
dev.off()






