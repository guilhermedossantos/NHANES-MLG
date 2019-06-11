library(foreign)
library(DataExplorer)

read.xport("C:\\Users\\201610882-79\\Downloads\\HEPA_I.XPT") -> aa
demo <- read.xport("C:\\Users\\201610882-79\\Downloads\\DEMO_I.XPT")
renda <- read.xport("C:\\Users\\201610882-79\\Downloads\\INQ_I.XPT")
dieta <- read.xport("C:\\Users\\201610882-79\\Downloads\\DR2IFF_I.XPT")


diq <- read.xport("C:\\Users\\201610882-79\\Downloads\\DIQ_I.XPT")


aaa <- inner_join(diq[,1:2], demo, by = "SEQN") %>% inner_join(renda, by = "SEQN") %>% 
  mutate(DIQ010 = na_if(DIQ010, 9) %>% na_if(3)) %>% mutate(DIQ010 = ifelse(DIQ010 == 1, 1,0 ))


aaa %>% select(-c(RIDAGEMN, RIDEXAGM, DMQADFC, DMDYRSUS, DMDEDUC2)) -> aaa

aaa %>% mutate(INQ320 = ifelse(INQ320 %in% c(66,77,99), NA, INQ320)) -> aaa


plot_intro(aaa)


plot_histogram(aaa) 
plot_correlation(aaa) 


boxplot(aaa$RIDAGEYR ~ aaa$DIQ010)

boxplot(aaa$INDFMPIR ~ aaa$DIQ010)

boxplot(aaa$INDFMIN2 ~ aaa$DIQ010, ylim = c(0,20))
boxplot(aaa$INDHHIN2 ~ aaa$DIQ010, ylim = c(0,20))





