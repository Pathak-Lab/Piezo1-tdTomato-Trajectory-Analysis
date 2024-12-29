# Piezo1-tdTomato Trajectory Analysis
Code associated with  Piezo1-tdTomato trajectory analyses reported in Ly et al. https://doi.org/10.1101/2022.09.30.510193

## Overview
The code is organized by analysis task:

- `get_trajectories/`: extract trajectories from JSON arrays generated by Flika and save them as R objects
- `compute_features/`: compute several trajectory geometric features as well as from the saved trajectories
- `generate_ImmobileMobile/`: use Golan and Sherman "scaled" radius of gyration (Nat Commun 2017 10.1038/ncomms15851) to label trajectories as "mobile" or "immobile"
- `mobile_oddsratio/`: use odds ratio to estimate treatmemt effects on "mobile" proportions 
- `mix_models/`: use mixture models to describe a trajectory ensemble step distribution and individual trajectories step-length distributions
- `alpha_estimates/`: use the methodology proposed by Kepten et. al (PRE 2013 10.1103/PhysRevE.87.052713) to characterize the TAMSD anomalous exponents distribution in an ensemble of the heterogenous diffusers

Minimal documentation is provided as README.md files under each directory and as comments in all files

## Requirements

- R (>= 4.0.0)
  - jsonlite package
  - mixtools package
- Mathematica (tested with version 14)

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Citation

If you use any part of this code in your research, please cite:
```
Ly et al. (2024). Single-particle tracking reveals heterogeneous PIEZO1 diffusion.
bioRxiv 2022.09.30.510193; doi: https://doi.org/10.1101/2022.09.30.510193
```

## Contact

For questions or issues, please contact [jfreites@uci.edu](mailto:jfreites@uci.edu).
