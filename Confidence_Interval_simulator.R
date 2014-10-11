#Kipp Johnson, kippjohnson@uchicago.edu

#vectors to store numbers later
lower_store = numeric()
upper_store = numeric()
range_store = numeric()

# set the population parameters & confidence
# interval statistics we desire
mu = 0
sigma = 1
sample_number = 100
sample_size = 50
confidence_level=0.95
pop_size = 1e5

# draw the population
population <- rnorm(pop_size, mean = mu, sd = sigma)


for(i in 1:sample_number){
	x <- sample(population, sample_size ,replace=TRUE) # get samples
 	xtest <- t.test(x, conf.level = confidence_level)  # t.test on samples
	lower_store[i] <- xtest$conf.int[1]				   # assign upper and lower
	upper_store[i] <- xtest$conf.int[2]				   # ends to approp. vector
}

# blank plot
plot(c(min(lower_store),max(upper_store)),c(0,sample_number),type="n",
	xlab = "Confidence Interval",ylab="Interval Number")

abline(v=mu,lwd=2,lty=2) # add line for true mean

for(i in 1:sample_number){
	lines(c(lower_store[i],upper_store[i]),c(i,i)) #add lines containing interval to plot

	if(mu <= upper_store[i] && mu >= lower_store[i]){ # number of intervals containing mu
		range_store[i] = 1
	}
}

mu_within = sum(range_store,na.rm = TRUE)

print(c("The fraction of intervals containing the true mean:", mu_within/sample_number))
