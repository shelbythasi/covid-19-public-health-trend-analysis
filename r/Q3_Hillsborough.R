library(readxl)
library(ggplot2)

hills <- read_excel("Combined.xlsx", sheet = "Hillsborough")
hills_df <- data.frame(hills)

colnames(hills_df) <- c("Date", "Number.of.Cases", "Moving.Average")

hills_df$Date <- as.Date(hills_df$Date, "%B %d, %Y")

ggplot(hills_df, aes(x = Date)) +
  geom_col(aes(y = Moving.Average), fill = "pink") +   
  geom_line(aes(y = Number.of.Cases), color = "blue") +  
  labs(title = "Daily COVID Cases and Moving Average in Hillsborough",
       x = "Date",
       y = "Number of Daily Cases")
