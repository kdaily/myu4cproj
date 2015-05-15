library(synapseClient)

synapseLogin()

NCols <- 5
NRows <- 700

myMat <- as.data.frame(matrix(runif(NCols*NRows), 
                              ncol=NCols))

myMat <- cbind(ID=sprintf("ID%04d", 1:nrow(myMat)),
               myMat)

write.csv(myMat, file="baz.csv")

# Save this script to Synapse in the Code directory
thisScript <- File("./baz.R", parentId='syn4154686')
thisScript <- synStore(thisScript)

# Save the output file to Synapse in the Data directory
f <- File("./baz.csv", parentId='syn4154679')
f <- synStore(f, executed=thisScript)
