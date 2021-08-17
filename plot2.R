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
         Global_active_power = as.numeric(Global_active_power)
  )


png("plot2.png", width=480, height=480)

with(df, 
     plot(DateTime, 
          Global_active_power, 
          type="l", 
          xlab="", 
          ylab="Global Active Power (kilowatts)")
     )

dev.off()