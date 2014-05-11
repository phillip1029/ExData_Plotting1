## Rough estimate the memory needed to read the dataset

howMuchRAM <-function(ncol, nrow, cushion=3){
  #40 bytes per col
  colBytes <- ncol*40

  #8 bytes per cell
  cellBytes <- ncol*nrow*8

  #object.size
  object.size <- colBytes + cellBytes

  #RAM
  RAM <- object.size*cushion
  cat("Your dataset will have up to", format(object.size*9.53674e-7, digits=1), "MB and you will probably need", format(RAM*9.31323e-10,digits=1), "GB of RAM to deal with it.")
  result <- list(object.size = object.size, RAM = RAM, ncol=ncol, nrow=nrow, cushion=cushion)
}

howMuchRAM(ncol=9,nrow=2075259)

setwd("C:/Users/ppeng/Dropbox/training/Coursera/Data Science Certificate/EDA/week1")
filein <- "C:/Users/ppeng/Dropbox/training/Coursera/Data Science Certificate/EDA/week1/household_power_consumption.txt"

require("sqldf")
mySql <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
df <- read.csv.sql(filein, mySql, sep = ";")

str(df)

df$DateTime <- paste(df$Date, df$Time)
df$DateTime <- strptime(df$DateTime, format="%d/%m/%Y %H:%M:%S")
str(df)
head(df)


## plot 4
par(mfrow = c(2,2))
plot(df$DateTime, df$Global_active_power, xlab = "", ylab = "Global_active_power", type = "l")
plot(df$DateTime, df$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")
plot(df$DateTime, df$Sub_metering_1, xlab = "", ylab = "Global_active_power", col = "black", type = "l")
lines(df$DateTime, df$Sub_metering_2, xlab = "", ylab = "Global_active_power", col = "red")
lines(df$DateTime, df$Sub_metering_3, xlab = "", ylab = "Global_active_power", col = "blue", type = "l")

legend("topright", 
       c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
       lty = c(1,1,1),
       col = c("black", "red","blue"), 
       lwd=c(1,1,1),
       cex = 0.5)

plot(df$DateTime, df$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l")
dev.copy(png,'plot4.png', width=480 ,height=480)
dev.off()






