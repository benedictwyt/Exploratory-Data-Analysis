library(dplyr)
library(stringr)
equip_loss_df <- read.csv("russia_losses_equipment.csv")
View(equip_loss_df)

# This table showcases the total loss of each equipment in each month, which is 
# from February to May. From this table, we can know the war situation through months.
# This indicate that the war peak is in April since the loss of each equipment 
# is the highest.

month_loss <- equip_loss_df %>% mutate(month = str_sub(date, 1,7)) %>% group_by(month) %>%
  summarise(aircraft_loss = sum(aircraft), helicopter_loss = sum(helicopter),
            tank_loss = sum(tank), APC_loss = sum(APC), 
            field_artillery_loss = sum(field.artillery), MRL_loss = sum(MRL),
            drone_loss = sum(drone), anti_aircraft_warfare_loss = sum(anti.aircraft.warfare))
View(month_loss)
