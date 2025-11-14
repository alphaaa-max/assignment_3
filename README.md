# Sakila Database Analysis with R data.table

## Overview
This project analyzes the Sakila database using R's data.table package instead of traditional SQL queries.

## Project Structure
```
assignment_3/
├── data/           # CSV files from Sakila database
├── scripts/        # R analysis scripts
├── output/         # Query results
├── plots/          # Visualizations
└── README.md       # This file
```

## Requirements
- R (version 4.0+)
- data.table package

## Installation
```R
install.packages("data.table")
install.packages("ggplot2")  # for visualization
```

## Quick Start
1. Install required packages:
```R
source("scripts/install_requirements.R")
```

2. Run the main analysis:
```R
source("scripts/sakila_analysis.R")
```

3. Check results:
   - Query outputs: `output/*.csv`
   - Visualizations: `plots/*.png`

## Queries Implemented
1. Films with PG rating and rental duration > 5 days
2. Average rental rate grouped by rating
3. Total film count per language
4. Customer names with their store information
5. Payment details with staff information
6. Films that have not been rented
7. Data visualization

## Documentation
See `ASSIGNMENT_GUIDE.md` for detailed implementation notes and technical details.

## Results
All query results are automatically saved to the `output/` directory as CSV files. Visualizations are saved to the `plots/` directory as high-resolution PNG images.
