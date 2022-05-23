#package
library(dplyr)



#data frame edit---------------------------------------------------------------------------------------
russia_losses_equipment <- read.csv("russia_losses_equipment.csv")

russia_losses_equipment <-mutate(russia_losses_equipment, 
 new_losses_in_tank = russia_losses_equipment$tank -lag(russia_losses_equipment$tank,k = 1, order_by = date))
russia_losses_equipment$new_losses_in_tank [1] <- 0

russia_losses_equipment <-mutate(russia_losses_equipment, 
new_losses_in_aircraft = russia_losses_equipment$aircraft -lag(russia_losses_equipment$aircraft,k = 1, order_by = date))
russia_losses_equipment$new_losses_in_aircraft [1] <- 0
total_battle_days <- nrow(russia_losses_equipment)+1

#Chart ------------------------------------------------------------------------------------------------
russia_losses_equipment$date <- as.Date(russia_losses_equipment$date)

plot(x=russia_losses_equipment$date, y=russia_losses_equipment$new_losses_in_aircraft, pch = 16, ylim = c(0, 70), main = "Intensity of the War", xlab = "Date", ylab = "Lost Unit")
lines(x = russia_losses_equipment$date, y=russia_losses_equipment$new_losses_in_aircraft)
points(x=russia_losses_equipment$date, y=russia_losses_equipment$new_losses_in_tank, pch = 17, col = "red")
lines(x = russia_losses_equipment$date, y=russia_losses_equipment$new_losses_in_tank, col = "red")
legend("topright", c("aircraft", "tank"), col = c("black", "red"), pch = c(16, 17))

