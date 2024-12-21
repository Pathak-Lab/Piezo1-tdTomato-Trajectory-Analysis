# Compute Features

Scripts to compute trajectory features reported in Ly et al. on trajectory data sets generated with `getTrajs.R`. The core feature calculation functions are all in `trajAnalysis.R`.

Each one of the following scripts should run at the command line as detailed in the script's comments:

- `getsRg.R`: compute Golan and Sherman "scaled" radius of gyration (Nat Commun 2017 10.1038/ncomms15851) for each trajectory (e.g. as reported in Ly et al. Figure 2) 
- `getStepsNormalized.R`: compute individual steps (displacements) for an ensemble of trajectories (e.g. as reported in Ly et al. Figure 3)
- `getStepLengthsDelta.R`: compute individual step lengths for each trajectory (e.g. data used in the mixture models reported in Ly et al. Figures 4 and 6)
- `getTAMSD.R`: compute time average MSD as a function of lag for each trajectory (e.g. as reported in Ly et al., Figure 7A)



