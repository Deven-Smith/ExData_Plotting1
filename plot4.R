library(lubridate)
library(dplyr)

df <- read.table("household_power_consumption.txt", 
                 stringsAsFactors = FALSE,
                 header = TRUE, 
                 sep = ";")

df <- 
  df %>% 
  filter(Date %in% c("1/2/2007", "2/2/2007")) %>%
  mutate(DateTime = dmy_hms(paste(Date, Time)),
         Global_active_power = as.numeric(Global_active_power),
         Sub_metering_1 = as.numeric(Sub_metering_1),
         Sub_metering_2 = as.numeric(Sub_metering_2),
         Sub_metering_3 = as.numeric(Sub_metering_3)
  )


png("plot4.png", width=480, height=480)
par(mfcol = c(2, 2))

#plot2, upperleft
with(df, 
     plot(DateTime, 
          Global_active_power, 
          type="l", 
          xlab="", 
          ylab="Global Active Power (kilowatts)")
)


#plot3, lowerleft
with(df, 
     plot(DateTime,
          Sub_metering_1,
          type = "l",
          ylab = "Energy Submetering",
          xlab = "")
)

lines(df$DateTime, df$Sub_metering_2, type = "l", col = "red")
lines(df$DateTime, df$Sub_metering_3, type = "l", col = "blue")

legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1, 
       lwd = 2,
       col = c("black",
               "red",
               "blue"),
       bty = "n")


#newplot1, upperright
with(df,
     plot(DateTime,
          Voltage,
          type = "l",
          ylab = "Voltage",
          xlab = "datetime"))



#newplot2, lowerright
with(df,
     plot(DateTime,
          Global_reactive_power,
          type = "l",
          ylab = "Global_reactive_power",
          xlab = "datetime"))



dev.off()