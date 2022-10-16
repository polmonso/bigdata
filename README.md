
CHeatsheet
==========

general
-------
source("file.r")

getwd()

?function_name shows docs

vectors atòmics:
----------------
c is short for combine

foo = c(1,3,4,2,3,123,3,2,2)

parameters can be numeric, textual or boolean

operators repeat to match vector lengths e.g. c(1,2,3,4) + c(1,2) = c(2,4,4,6)
if repeated lengths do not match you'll get a warning but it does it anyway

ranges:
1:10
seq(1,10,2)
seq(0,1,length=10)

slicing
-------
foo = c('a','b','c','d','e')

positional
```r
foo[c(1,2)] -> ab
foo[c(-1,-2)] -> cde
foo[seq(1,4,2)] -> ac
```

logic
```r
foo[1:5 < 3] = ab
```

_Label elements to access by name_

x=1:12
names(x) = month.abb

then
x['Jan'] -> 1

_lists_

construct: foo = list(3)
slice: foo[1] -> dataframe-like  [[1]] [1] 3
get element: foo[[1]] -> 3

taula$capture_rate és equivalent a taula[['capture_rate']]

util functions
---------------

sapply(c(1,2), fib) : where fib is a function, applies function to each element
lapply -> list
mapply : zip with apply, coerced by min lenght

is.list()

```r
foo[['name']] is equivalent to foo$name
```

_io_

read_csv2 és el read_csv europeu
read_delim() per més control

```r
read_delim(
  "foo.csv",
  delim = ';',
  escape_double = FALSE,
  locale = locale(decimal_mark=',', grouping_mark='.'),
  guess_max = 1912, # forçar que miri fins a la fila 1912 per decidir column type
  trim_ws = TRUE
)
```

problems(data) # t'indica discrepancies entre expected i actual de columnes type

View(taula) a RStudio t'ensenya la taula interactiva
glimpse(taula)


piping
------

flights %>%
  filter(month == 1, day == 1) %>%
  arrange(dep_delay)

dplyr
-----

_slice_

slice()
slice_head(flights, n = 10)
slice_head(flights, prop = 0.00003)
slice_sample(flights, n = 100)
distinct(flights, origin)

_arrange_

reordenacions

```r
arrange(flights, year, month, day, desc(dep_delay)) # podem posar diversos criteris un després de l'altre
arrange(flights, !is.na(dep_delay)) # accepta funcions
```

_select_

pot seleccionar per noms de columnes, condicions de les files... Conditions are OR-interesected
select(filghts, starts_with('dep_'), contains('arr_'), -arr_time)

other selecting functions:
contains, matches (regex), all_of, any_of, starts_with, ends_with

_filter_

filter(flights, is.na(dep_time))

_mutate_
afegir columnes derivades al dataframe

```r
mutate(
    select(flights, distance, air_time),
    distance_km = distance * 1.60934,
    air_time_h = air_time / 60,
    speed_km_h = distance_km/air_time_h
)
```

`transmute` if we don't want to keep the source columns

proportions within a group:

mutate(group_by(birthwt_tab, smoke) p = n/sum(n))

gives

```
smoke low n p
0 0 86 0.748
0 1 29 0.252
1 0 44 0.595
1 1 30 0.405
is.na()
```

_summarise_

agrupacions sobre totes les files que colapsen a un resultat

agrupacions possibles: n (aka count), n_distinct, first, nth, last (dyplr) i les matemàtiques mean, sum ...
i **group_by**


summarise(
    flights,
    average_dep_delay = mean(dep_delay, na.rm=TRUE)
    average_arr_delay = mean(arr_delay, na.rm=TRUE)
)

summarise(group_by(obres, tipus_local, n = n())) és equivalent a count(obres, Tipus_local)

_joins_

canceled_day = group_by(filter(flights, is.na(dep_delay) | is.na(arr_delay)), year, month, day), n_canceled = n())
total_day = summarize(group_by(flights, year, month ,day), n_total = n())

mutate(
    inner_join(canceled_day, total_day),
    p_canceled = n_canceled / n_total
)

preguntes per resoldre
======================

Taula és un tipus? Quin?


plotting
========

ggplot2

ggplot(data=birthwt) +
  geom_bar(aes(x = smoke_lbl))

`aes` per definir l'estètica del ggplot (quina variable va a l'eix x, quin a l'eix y i tot de goodies estètics per anar modificant el graph)

gem_bar


`egg` per combinar graphs

ggarrange(p1, p2, ncol = 2)

on p1 p2 són ggplots


mare meva que fan servir .. per referir-se a variables internes rollo self o algo https://stackoverflow.com/questions/19997231/two-dots-in-r