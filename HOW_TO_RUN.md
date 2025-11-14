# How to Run This Assignment

## Prerequisites

1. **Install R**
   - Download from: https://www.r-project.org/
   - Version 4.0 or higher recommended

2. **Install RStudio (Optional but Recommended)**
   - Download from: https://www.rstudio.com/
   - Provides a better IDE experience

## Step-by-Step Instructions

### Option 1: Using RStudio (Recommended)

1. **Open RStudio**

2. **Set Working Directory**
   ```R
   setwd("/path/to/assignment_3")
   ```

3. **Install Required Packages**
   ```R
   source("scripts/install_requirements.R")
   ```

   This will install:
   - `data.table` - For efficient data manipulation
   - `ggplot2` - For creating visualizations

4. **Run the Analysis**
   ```R
   source("scripts/sakila_analysis.R")
   ```

5. **View Results**
   - Check console for output
   - Open `output/` folder for CSV files
   - Open `plots/` folder for PNG images

### Option 2: Using R Command Line

1. **Navigate to Project Directory**
   ```bash
   cd /path/to/assignment_3
   ```

2. **Start R**
   ```bash
   R
   ```

3. **Run Installation Script**
   ```R
   source("scripts/install_requirements.R")
   ```

4. **Run Analysis Script**
   ```R
   source("scripts/sakila_analysis.R")
   ```

5. **Exit R**
   ```R
   q()
   ```

### Option 3: Using Rscript (Non-Interactive)

1. **Navigate to Project Directory**
   ```bash
   cd /path/to/assignment_3
   ```

2. **Install Packages**
   ```bash
   Rscript scripts/install_requirements.R
   ```

3. **Run Analysis**
   ```bash
   Rscript scripts/sakila_analysis.R
   ```

## Expected Runtime

- Package installation: 1-3 minutes (first time only)
- Analysis execution: < 1 second
- Plot generation: 1-2 seconds

**Total time:** ~5 minutes for first run, < 5 seconds for subsequent runs

## Troubleshooting

### Issue: Package installation fails

**Solution:**
```R
# Try installing packages individually
install.packages("data.table", dependencies = TRUE)
install.packages("ggplot2", dependencies = TRUE)
```

### Issue: "cannot open file" error

**Solution:**
- Ensure you're in the correct working directory
- Check that data files exist in `data/` folder

### Issue: Plots don't appear

**Solution:**
- Plots are automatically saved to `plots/` directory
- Open the PNG files manually to view them

### Issue: Permission denied when saving files

**Solution:**
```bash
# Make sure output directories have write permissions
chmod -R 755 output plots
```

## Verifying Success

After running the script, verify these items:

1. **Console Output**
   - See results for all 7 queries
   - No error messages
   - Summary statistics at the end

2. **Output Files**
   ```bash
   ls output/
   ```
   Should show 6 CSV files:
   - query1_pg_films.csv
   - query2_avg_rental_by_rating.csv
   - query3_films_by_language.csv
   - query4_customers_stores.csv
   - query5_payments_staff.csv
   - query6_unreturned_films.csv

3. **Plot Files**
   ```bash
   ls plots/
   ```
   Should show 2 PNG files:
   - film_rating_distribution.png
   - rental_rate_distribution.png

## Manual Verification of Queries

To run queries individually for testing:

```R
# Load libraries
library(data.table)

# Load data
film <- fread("data/film.csv")
customer <- fread("data/customer.csv")
# ... load other tables as needed

# Run individual query (example: Query 1)
result <- film[rating == "PG" & rental_duration > 5]
print(result)
```

## Additional Commands

### View Data Structure
```R
# Check loaded data
str(film)
summary(film)
head(film)
```

### Re-run Specific Sections
```R
# The script is organized in sections
# You can run specific sections by highlighting and executing
# Or by copying specific query blocks
```

## System Requirements

- **OS:** Windows, macOS, or Linux
- **R Version:** 4.0+
- **RAM:** 1GB minimum (dataset is small)
- **Disk Space:** 100MB for R packages + data

## Support

If you encounter issues:
1. Check that R is properly installed: `R --version`
2. Verify all data files are present in `data/` folder
3. Ensure you have write permissions in project directory
4. Check R package installation: `library(data.table)`

## Success Criteria

✅ All 7 queries execute without errors
✅ 6 CSV files created in `output/`
✅ 2 PNG files created in `plots/`
✅ Console shows query results and summary
✅ No warnings or errors in output

---

**Estimated Total Time:** 5-10 minutes (including package installation)

**Note:** After initial setup, subsequent runs take less than 5 seconds.
