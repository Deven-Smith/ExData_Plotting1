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
         Sub_metering_1 = as.numeric(Sub_metering_1),
         Sub_metering_2 = as.numeric(Sub_metering_2),
         Sub_metering_3 = as.numeric(Sub_metering_3)
  )


png("plot3.png", width=480, height=480)

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
               "blue"))

dev.off()