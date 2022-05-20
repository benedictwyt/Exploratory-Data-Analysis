#Chart to visualize and analyze the aircraft losing rate compared to the tank losing rate. 
#The formula used to calculate the losing rate is (new lost equipment / total lost equipment) * 100%.
#After seeing the graph, I conclude that relative more aircraft were destroyed at the early period of the war.
#And relative more tanks were destroyed at the late period of the war.
library(ggplot2)
library(tidyverse)

equipLoss <- read.csv("russia_losses_equipment.csv")

equipLoss <- equipLoss %>%
  mutate(new_aircraft_rate = (equipLoss$aircraft - lag(aircraft, n = 1, default = 0)) / max(aircraft) * 100)

equipLoss <- equipLoss %>%
  mutate(new_tank_rate = (equipLoss$tank - lag(tank, n = 1, default = 0)) / max(tank) * 100)

ggplot(equipLoss, aes(x = day)) + 
  geom_line(aes(y = new_aircraft_rate, col = "aircraft losing rate"), size = 1) +
  geom_line(aes(y = new_tank_rate, col = "tank losing rate"), size = 1) +
  labs(x = "Days of war", y = "Frequency in %", col = "Legand") +
  ggtitle("Aircraft & Tank losing rate")
              
