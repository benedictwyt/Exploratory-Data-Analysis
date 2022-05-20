#Chart to analyze and visualize the the lost of aircraft in each day and to analyze the trend of it. 
#According to the graph, we can see that with the war keep going, the loses of aircraft in a single day showing a decreasing trend.
library(ggplot2)
library(tidyverse)

equipLoss <- read.csv("russia_losses_equipment.csv")

equipLoss <- equipLoss %>%
  mutate(new_aircraft = equipLoss$aircraft - lag(aircraft, n = 1, default = 0))

lm1.out <- lm(equipLoss$new_aircraft ~ equipLoss$day)
  
trend <- ggplot(data = equipLoss, aes(x = day, y = new_aircraft, fill = new_aircraft)) +
  geom_area(colour = 1, fill = "sky blue") +
  ggtitle("Trend of the losses of aircrafts") +
  xlab("Days of war") +
  ylab("Number of arcrafts lost in a single day") +
  geom_abline(slope = lm1.out$coef[2], intercept = lm1.out$coef[1], col = "red") 


