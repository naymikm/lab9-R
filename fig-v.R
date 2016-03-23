libs = c('ggplot2','latticeExtra')
suppressMessages(invisible(lapply(libs,require,character.only=T)))
cat("Generating figV.pdf...\n")

data(diamonds)

dia.ideal = subset(diamonds, cut == 'Ideal')
dia.rest = subset(diamonds, cut != 'Ideal' & color != 'J')
mean.car.per.clar = aggregate(dia.ideal$carat, by=list(dia.ideal$clarity),FUN=mean)
med.car.per.clar = aggregate(dia.ideal$carat, by=list(dia.ideal$clarity),FUN=median)

merged = merge(mean.car.per.clar,med.car.per.clar,by='Group.1')
names(merged) = c('clarity','mean.carat','median.carat')

pdf('figV.pdf',width=3,height=3)

xyplot(mean.carat~median.carat,data=merged,
panel =function(x,y,...){
panel.xyplot(x,y,...)
panel.smoother(x,y,method='lm',col='black',col.se='black',alpha.se=.3)})

scatter.gg=ggplot(aes(x=median.carat,y=mean.carat),data=merged)
scatter.gg + geom_point() + stat_smooth(method='lm', se =T,fill='black',colour='black') + theme_bw()

invisible(dev.off())
