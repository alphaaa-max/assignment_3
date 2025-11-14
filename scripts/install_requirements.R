# Install required R packages for Sakila analysis

# List of required packages
packages <- c("data.table", "ggplot2")

# Install packages if not already installed
for (pkg in packages) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, dependencies = TRUE)
    cat(sprintf("Installed package: %s\n", pkg))
  } else {
    cat(sprintf("Package already installed: %s\n", pkg))
  }
}

cat("\nAll required packages are ready!\n")
cat("You can now run: source('scripts/sakila_analysis.R')\n")
