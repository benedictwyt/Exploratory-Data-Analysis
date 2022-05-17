#package
library(dplyr)

----------------------------------------------------------------------------------------
russia_losses_equipment <- read.csv("russia_losses_equipment.csv")
#aircraft
russia_losses_equipment <-mutate(russia_losses_equipment, 
new_losses_in_aircraft = russia_losses_equipment$aircraft -lag(russia_losses_equipment$aircraft,k = 1, order_by = date))
russia_losses_equipment$new_losses_in_aircraft [1] <- 10
#When was there were not longer war auto losses


summary_info <- list()
summary_info$num_observations <- nrow(russia_losses_equipment)
summary_info$date_losses_most_aircraft <- 
 pull(select(filter(russia_losses_equipment, new_losses_in_aircraft == max(new_losses_in_aircraft, na.rm = T)), date))[1]