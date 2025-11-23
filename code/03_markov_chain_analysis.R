# ============================================
# MARKOV CHAIN ANALYSIS
# Conservation Status Transitions
# Author: Saee Kurhade
# ============================================

install.packages("markovchain");library(markovchain)
install.packages("diagram"); library(diagram)
install.packages("expm"); library(expm)

# One-step Transition Probability Matrix for Reptiles:
DD <- c(0, 0.611353712, 0.074235808, 0.082969432, 0.170305677, 0.061135371, 0, 0)
LC <- c(0.21978022, 0, 0.450549451, 0.197802198, 0.10989011, 0.021978022, 0, 0)
NT <- c(0.027272727, 0.581818182, 0, 0.190909091, 0.181818182, 0.018181818, 0, 0)
VU <- c(0.082191781, 0.246575342, 0.150684932, 0, 0.342465753, 0.157534247, 0.006849315, 0.01369863)
EN <- c(0.107526882, 0.139784946, 0.096774194, 0.225806452, 0, 0.419354839, 0, 0.010752688)
CR <- c(0.171428571, 0.028571429, 0.057142857, 0.114285714, 0.6, 0, 0, 0.028571429)
EW <- c(0, 0, 0, 0.333333333, 0, 0.333333333, 0, 0.333333333)
EX <- c(0, 0, 0, 0, 0, 0.75, 0.25, 0)

reptiles_matrix <- matrix(c(DD, LC, NT, VU, EN, CR, EW, EX), nrow=8, byrow=TRUE)
states <- c("DD", "LC", "NT", "VU", "EN", "CR", "EW", "EX")

rownames(reptiles_matrix) <- states
colnames(reptiles_matrix) <- states

# Create Markov Chain object
mc_reptiles <- new("markovchain", transitionMatrix=reptiles_matrix, states=states,
                  name="Reptile Conservation Status")
mc_reptiles

# Plot Markov Chain
plot(mc_reptiles)

# Calculate steady states
ss <- steadyStates(mc_reptiles)
barplot(ss, main='Taxonomy - Reptiles', ylab='Prob. of attaining a particular consn. status in future',col='red')
summary(mc_reptiles)
simm = rmarkovchain(n=100,mc_repltiles,t0='NT'); simm

# Save steady states and matrix for later use
write.csv(reptiles_matrix, "reptiles_transition_matrix.csv")
write.csv(data.frame(State=states, Probability=as.numeric(ss)), "reptiles_steady_states.csv")
