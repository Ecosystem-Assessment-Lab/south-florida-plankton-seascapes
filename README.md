# SFER Plankton Imaging & Dynamic Satellite Seascapes

Analysis, classification, and visualization code for the manuscript:

> **Scaling plankton imaging observations using dynamic satellite seascapes for characterizing the biogeography of phytoplankton and zooplankton in South Florida, USA**  
> E. Montes, F. E. Muller-Karger, N. C. Millette, L. R. Thompson, M. T. Kavanaugh, T. Christian, and C. Kelble (*Scientific Reports*, 2026).

---

## Repository Contents

| File / Folder | Language | Purpose & Manuscript Outputs |
| :--- | :--- | :--- |
| `Image_Classification.py` | Python | Runs PyTorch/ResNet-152 inference on CPICS `.png` ROIs (adapted from [SPC-UW-ZooCam](https://github.com/SPC-UW-ZooCam)) and filters predictions at $P \ge 0.70$. |
| `batch_cpics_classifier.ipynb` | Python | Batch wrapper around `Image_Classification.py`; validates ROI counts and generates seasonal/monthly bubble artifact plots (**Figure S4**). |
| `seascape_extractor_cpics.ipynb` | Python | Queries NOAA CoastWatch THREDDS for 8-day and monthly satellite seascapes and extracts modal classes/probabilities via KD-Tree matching. |
| `plankton_analysis.ipynb` | Python | Matches CPICS ROIs to CTD metadata, computes concentrations, and generates **Figures 3, 4, 5 (PCA), 7, S3, and S4**. |
| `cpics_image-seascape_analysis.Rmd` | R | Integrates CPICS counts with CTD metadata and seascapes; generates concentration time series, seasonal boxplots, and stacked bar charts (**Figures 3, 4, 5, 7**). |
| `seascape_similarity_analysis.Rmd` | R | Computes pairwise abundance-based Chao-Jaccard (Ružička) similarity matrices and renders heatmaps (**Figure 8**). |
| `seascape_mapping.m` | MATLAB | Downloads monthly satellite seascapes from NOAA CoastWatch THREDDS and maps stations overlaid on seascapes (**Figure 1**). |
| `ctd_meta_v4.csv` | Data | SFER CTD cast metadata, coordinates (`dec_lat`, `dec_lon`), sampled volumes, and matched seascape classes. |
| `custom.csv` | Data | 33×3 RGB colormap matrix for satellite seascape classes used by `seascape_mapping.m`. |
| `TS.Master/` | Data | Validated CPICS ROI filename/timestamp lists (`class.*.txt`) for 20 taxonomic and morphological groups. |

---

## Software & Environment Requirements

Analyses were conducted using the following software versions:

* **Python (v3.13.5):** `numpy`, `pandas`, `scipy`, `scikit-learn`, `xarray`, `requests`, `matplotlib`, `seaborn`, `cartopy`, `folium`, `tqdm`, `Pillow`, `opencv-python`, `torch`, `torchvision`
* **R (v4.5.0 / RStudio):** `tidyverse`, `dplyr`, `tidyr`, `lubridate`, `forcats`, `ggplot2`, `tidyplots`, `ggpubr`, `scales`, `hrbrthemes`, `viridis`
* **MATLAB (R2024a):** [M_Map](https://www.eoas.ubc.ca/~rich/map.html) mapping toolbox

---

## Data & External Dependencies

* **Hydrographic Data:** [NOAA NCEI](https://www.ncei.noaa.gov/access/metadata/landing-page/bin/iso?id=gov.noaa.nodc:0247167)
* **Validated Plankton Imagery:** [EcoTaxa Project 20154](https://ecotaxa.obs-vlfr.fr/prj/20154)
* **Net Tow Zooplankton Data:** [OBIS Dataset](https://portal.obis.org/dataset/afef5da2-614b-4208-aee6-c2413ed5ab76)
* **Satellite Seascapes (8-day & Monthly):** [NOAA CoastWatch THREDDS](https://cwcgom.aoml.noaa.gov/thredds/ncss/grid/SEASCAPE_8DAY/SEASCAPES.nc/dataset.html)
* **Automated Classification Pipeline:** Adapted from [SPC-UW-ZooCam](https://github.com/SPC-UW-ZooCam). *(Note: Pre-trained ResNet-152 model weights and raw `.png` ROIs are not included in this repository due to file size; contact the corresponding author for model weights.)*

---

## Citation

If you use this code, please cite the manuscript and the Zenodo archive:

> Montes, E. et al. Code for: Scaling plankton imaging observations using dynamic satellite seascapes for characterizing the biogeography of phytoplankton and zooplankton in South Florida, USA (v1.0.0). *Zenodo* https://doi.org/10.5281/zenodo.XXXXXXX (2026).

---

## License & Contact

This repository is released under the **MIT License**.  
For questions, contact **Enrique Montes** (enrique.montes@noaa.gov).
```[cite: 6, 7, 8, 12, 16, 17, 18, 20, 21]
