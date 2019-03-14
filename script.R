library(tidyverse)
library(gt)
library(janitor)

spain_polls <- read_csv(file = "https://pollofpolls.eu/get/polls/ES-parliament/format/csv") %>% 
  clean_names() %>% 
  gather(pp, psoe, bng, cc, erc, pnveaj, cs, vox, podemos, eh_bildu, pacma, p_de_cat, key = "party", value = "vote")

good_firms <- spain_polls %>% 
  group_by(firm) %>% 
  summarize(number = n()) %>% 
  filter(number >= 40) %>% 
  pull(firm)

spain_polls %>%
  filter(Sys.Date() - date < 365) %>% 
  filter(firm %in% good_firms) %>% 
  ggplot(aes(x = date, y = vote, color = party)) + 
  geom_smooth()