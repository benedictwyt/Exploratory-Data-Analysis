#package
library(dplyr)
library(ggplot2)
library(hrbrthemes)


#data frame edit---------------------------------------------------------------------------------------
russia_losses_equipment <- read.csv("russia_losses_equipment.csv")

russia_losses_equipment <-mutate(russia_losses_equipment, 
 new_losses_in_tank = russia_losses_equipment$tank -lag(russia_losses_equipment$tank,k = 1, order_by = date))
russia_losses_equipment$new_losses_in_tank [1] <- 0
total_battle_days <- nrow(russia_losses_equipment)+1

#Chart ------------------------------------------------------------------------------------------------
russia_losses_equipment$date <- as.Date(russia_losses_equipment$date)

# Plot
russia_losses_equipment %>%
  tail(total_battle_days) %>%
  ggplot( aes(x=date, y=new_losses_in_tank)) +
  geom_line( color="grey") +
  geom_point(shape=21, color="black", fill="#69b3a2", size=6) +
  theme_ipsum() +
  ggtitle("Loss of tank during the war")