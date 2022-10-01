data = read.csv("https://terra.girona.cat/opendata/storage/f/2021-04-19T07%3A52%3A25.797Z/padro-2021.csv", sep=';',dec=',')
save(data, file="data/padro_2020.RData")
summari