Howto use tract_choropleth:
===========================

You will need some FIPS codes for counties.  Find those here: http://www.nws.noaa.gov/mirs/public/prods/maps/cnty_fips_list.htm

```
tract.economics=get_tract_poverty("florida",county=c(12086,12011))
tract.economics$value=tract.economics$percent_in_poverty
tract_choropleth(tract.economics,"florida",county=c(12086,12011),num_colors=7)
```

How to put a point and label on a map:
--------------------------------------

```
gg <- tract_choropleth(tract.economics,"florida",county=c(12086,12011),num_colors=7)
pointdf <- as.data.frame(cbind(c(-80.1820427),c(26.0020233))
row.names(pointdf) <- c("Memorial")
gg+geom_point(data = pointdf, aes(x = lon, y = lat), size = 2, shape = 21,fill="red",alpha=0.8, inherit.aes = FALSE)+ geom_label(data = pointdf, aes(x=lon,y=lat),label = as.character(rownames(pointdf)), angle = 0, hjust = 0, color = "red",inherit.aes=FALSE)
```