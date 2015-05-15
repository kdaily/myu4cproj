library(synapseClient)
library(rGithubClient)
synapseLogin()

# Shows how to use github to link to the code that generates a file

NRows <- 700

myDF <- data.frame(ID=sprintf("ID%04d", 1:NRows),
                   foo=rep(c("a", "b", "c", "d", "e", "f", "g"), each=NRows / 7),
                   bar=rep(c(TRUE, FALSE), times=NRows / 2),
                   baz=rep(c(1, 2, 3, 4), each=NRows / 4))

write.csv(myDF, file="foo.csv")

# This script lives in Github
# To connect it to show that a file was generated using it,
# I get the most recent commit (requires you commit and push to Github first!)
thisRepo <- getRepo("kdaily/myu4cproj")
thisScript <- getPermlink(thisRepo, "foo.R")

# Save the output file to Synapse in the Data directory
f <- File("./foo.csv", parentId='syn4154679')
f <- synStore(f, executed=thisScript)
