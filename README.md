# API for extracting event locations of all planned "March for Our Lives" protests

For protest information, please go to the organizers site [here](https://event.marchforourlives.com/event/march-our-lives-events/search/).

# Installation 
```
devtools::install_github("edunford/marchforourlives")
```

Load package onto your system.

```
require(marchforourlives)
```

# Usage

The package offers a quick API to extract location information. Specifically, for a location within 50 miles of a particular zip code. 

```
extract_march(20010)
```


However, the API pings the existing website in ways that can adversely impact it, so the following function offers a time pad between functions if multiple zipcodes need to be retrieved. 

```
dat =  gather_marches(c(20010, 83333,98101,77001))
```


Finally, the location of all scheduled locations can be retrieved with the following:

```
all_planned_protests <- extract_all()
all_planned_protests
```

Now, go out and protest! ...at a location near you.  
