libs = c('ggplot2','latticeExtra','grid')
suppressMessages(invisible(lapply(libs,require,character.only=T)))
data(diamonds)

dia.rest = subset(diamonds, cut != 'Ideal' & color != 'J')

png('figVI.png',width=720,height=720)

grid.newpage()
vp1= viewport(x=0,y=0,
	height=.5,width=1,
	just=c('left','bottom'))

pushViewport(vp1)

#lattice
hist.lat = histogram(~price | cut + color,
	data=dia.rest,
	as.table=T,
	plot.points=F,
	between=list(x=.2,y=.2),
	scales=list(x=list(rot=45)))

l.hist.lat=useOuterStrips(hist.lat)
print(l.hist.lat,newpage=F)

upViewport(1)

vp2= viewport(x=0,y=0.5,
        height=.5,width=1,
        just=c('left','bottom'))

pushViewport(vp2)

#ggplot2
hist.gg = ggplot(dia.rest,aes(x=price))
g.hist = hist.gg + 
	geom_histogram(aes(y=..ncount..)) + 
	facet_grid(color~cut) + 
	theme(axis.text.x=element_text(angle=45,hjust=1)) +
	ylab('Ratio')

suppressMessages(print(g.hist,newpage=F))
invisible(dev.off())
