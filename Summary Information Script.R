#package
library(dplyr)

#-------------------------------------------------------------------------------------------------------
russia_losses_equipment <- read.csv("russia_losses_equipment.csv")

#Date loss most aircraft
russia_losses_equipment <-mutate(russia_losses_equipment, 
new_losses_in_aircraft = russia_losses_equipment$aircraft -lag(russia_losses_equipment$aircraft,k = 1, order_by = date))
russia_losses_equipment$new_losses_in_aircraft [1] <- 10

#When did most done used during the war----------------------------------------------------------------
russia_losses_equipment <-mutate(russia_losses_equipment, 
new_losses_in_drone = russia_losses_equipment$drone -lag(russia_losses_equipment$drone,k = 1, order_by = date))
russia_losses_equipment$new_losses_in_drone [1] <- 0

#Total number of tank loss
russia_losses_tank_total <- pull(select(filter(russia_losses_equipment, tank == max(tank, na.rm = T)), tank))[1]

#Total number of Naval ship
russia_losses_naval_ship_total <- pull(select(filter(russia_losses_equipment, naval.ship == max(naval.ship, na.rm = T)), naval.ship))[1]

#Number of weeks that the war took place
russia_war_total_weeks <- round((pull(select(filter(russia_losses_equipment, day == max(day, na.rm = T)), day))[1])/7, digits = 0)

#summary-----------------------------------------------------------------------------------------------
summary_info <- list()
summary_info$num_days_of_war <- nrow(russia_losses_equipment)+1
summary_info$date_losses_most_aircraft <- 
 pull(select(filter(russia_losses_equipment, new_losses_in_aircraft == max(new_losses_in_aircraft, na.rm = T)), date))[1]
summary_info$date_losses_most_drone <- 
  pull(select(filter(russia_losses_equipment, new_losses_in_drone == max(new_losses_in_drone, na.rm = T)), date))[1]
summary_info$total_loss_tank <- russia_losses_tank_total
summary_info$total_loss_naval_ship <- russia_losses_naval_ship_total
summary_info$total_weeks_war_took_place <- russia_war_total_weeks
