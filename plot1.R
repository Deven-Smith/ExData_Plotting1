library(lubridate)
library(dplyr)

df <- read.table("household_power_consumption.txt", 
                 stringsAsFactors = FALSE,
                 header = TRUE, 
                 sep = ";")

df <- 
  df %>% 
  filter(Date %in% c("1/2/2007", "2/2/2007")) %>%
  mutate(Global_active_power = as.numeric(Global_active_power)
  )


png("plot1.png", width=480, height=480)

with(df, 
     hist(Global_active_power,
          main = "Global Active Power",
          ylab = "Frequency",
          xlab = "Global Active Power (kilowatts)",
          col = "red")
     )

dev.off()
