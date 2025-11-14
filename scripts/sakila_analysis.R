# Sakila Database Analysis using data.table
# Assignment 3 - SQL to R Conversion

# Load required libraries
if (!require("data.table")) install.packages("data.table")
if (!require("ggplot2")) install.packages("ggplot2")

library(data.table)
library(ggplot2)

# Set working directory to project root
setwd("/home/user/assignment_3")

# ============================================================================
# DATA LOADING
# ============================================================================

cat("\n=== Loading Sakila Database Tables ===\n")

# Load all CSV files as data.tables
film <- fread("data/film.csv")
language <- fread("data/language.csv")
customer <- fread("data/customer.csv")
store <- fread("data/store.csv")
staff <- fread("data/staff.csv")
payment <- fread("data/payment.csv")
rental <- fread("data/rental.csv")
inventory <- fread("data/inventory.csv")

cat("Data loaded successfully!\n")
cat(sprintf("Films: %d rows\n", nrow(film)))
cat(sprintf("Customers: %d rows\n", nrow(customer)))
cat(sprintf("Payments: %d rows\n", nrow(payment)))

# ============================================================================
# QUERY 1: Films with PG rating and rental duration > 5 days
# ============================================================================

cat("\n=== QUERY 1: Films with PG rating and rental duration > 5 ===\n")

query1 <- film[rating == "PG" & rental_duration > 5,
               .(film_id, title, rating, rental_duration, rental_rate)]

print(query1)
cat(sprintf("\nTotal films found: %d\n", nrow(query1)))

# Save results
fwrite(query1, "output/query1_pg_films.csv")

# ============================================================================
# QUERY 2: Average rental rate grouped by rating
# ============================================================================

cat("\n=== QUERY 2: Average rental rate by rating ===\n")

query2 <- film[, .(
  film_count = .N,
  avg_rental_rate = round(mean(rental_rate), 2),
  min_rental_rate = min(rental_rate),
  max_rental_rate = max(rental_rate)
), by = rating][order(-avg_rental_rate)]

print(query2)

# Save results
fwrite(query2, "output/query2_avg_rental_by_rating.csv")

# ============================================================================
# QUERY 3: Total film count per language
# ============================================================================

cat("\n=== QUERY 3: Film count by language ===\n")

# Join film and language tables
query3 <- film[language, on = .(language_id), nomatch = 0][,
  .(total_films = .N),
  by = .(language_id, name)
][order(-total_films)]

setnames(query3, "name", "language_name")
print(query3)

# Save results
fwrite(query3, "output/query3_films_by_language.csv")

# ============================================================================
# QUERY 4: Customer names with their store information
# ============================================================================

cat("\n=== QUERY 4: Customers and their stores ===\n")

query4 <- customer[store, on = .(store_id), nomatch = 0][,
  .(customer_id,
    customer_name = paste(first_name, last_name),
    email,
    store_id,
    store_manager_id = manager_staff_id)
][order(store_id, customer_name)]

print(head(query4, 20))
cat(sprintf("\nTotal customers: %d\n", nrow(query4)))

# Save results
fwrite(query4, "output/query4_customers_stores.csv")

# ============================================================================
# QUERY 5: Payment details with staff information
# ============================================================================

cat("\n=== QUERY 5: Payments with staff details ===\n")

query5 <- payment[staff, on = .(staff_id), nomatch = 0][,
  .(payment_id,
    customer_id,
    amount,
    payment_date,
    staff_name = paste(first_name, last_name),
    staff_email = email)
][order(payment_date)]

print(head(query5, 20))
cat(sprintf("\nTotal payments: %d\n", nrow(query5)))

# Save results
fwrite(query5, "output/query5_payments_staff.csv")

# ============================================================================
# QUERY 6: Films that have NOT been rented
# ============================================================================

cat("\n=== QUERY 6: Films not rented ===\n")

# Get films that are in inventory
rented_film_ids <- unique(rental[inventory, on = .(inventory_id), nomatch = 0]$film_id)

# Find films NOT in the rented list
query6 <- film[!film_id %in% rented_film_ids,
               .(film_id, title, rating, rental_rate)]

print(query6)
cat(sprintf("\nTotal unreturned films: %d\n", nrow(query6)))

# Save results
fwrite(query6, "output/query6_unreturned_films.csv")

# ============================================================================
# QUERY 7: VISUALIZATION - Film distribution by rating
# ============================================================================

cat("\n=== QUERY 7: Creating visualization ===\n")

# Prepare data for visualization
plot_data <- film[, .(count = .N), by = rating][order(-count)]

# Create bar plot
p <- ggplot(plot_data, aes(x = reorder(rating, -count), y = count, fill = rating)) +
  geom_bar(stat = "identity", width = 0.7) +
  geom_text(aes(label = count), vjust = -0.5, size = 5) +
  labs(
    title = "Distribution of Films by Rating",
    subtitle = "Sakila Database Analysis",
    x = "Film Rating",
    y = "Number of Films"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
    plot.subtitle = element_text(hjust = 0.5, size = 12),
    axis.text.x = element_text(size = 12),
    axis.text.y = element_text(size = 11),
    legend.position = "none"
  ) +
  scale_fill_brewer(palette = "Set3")

# Save the plot
ggsave("plots/film_rating_distribution.png", plot = p,
       width = 10, height = 6, dpi = 300)

cat("Plot saved to: plots/film_rating_distribution.png\n")

# Additional plot: Rental rate distribution
p2 <- ggplot(film, aes(x = rental_rate)) +
  geom_histogram(binwidth = 0.5, fill = "steelblue", color = "black", alpha = 0.7) +
  labs(
    title = "Distribution of Film Rental Rates",
    subtitle = "Sakila Database Analysis",
    x = "Rental Rate ($)",
    y = "Frequency"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
    plot.subtitle = element_text(hjust = 0.5, size = 12)
  )

ggsave("plots/rental_rate_distribution.png", plot = p2,
       width = 10, height = 6, dpi = 300)

cat("Additional plot saved to: plots/rental_rate_distribution.png\n")

# ============================================================================
# SUMMARY STATISTICS
# ============================================================================

cat("\n=== ANALYSIS SUMMARY ===\n")
cat(sprintf("Total Films: %d\n", nrow(film)))
cat(sprintf("Total Customers: %d\n", nrow(customer)))
cat(sprintf("Total Payments: %d\n", nrow(payment)))
cat(sprintf("Total Rentals: %d\n", nrow(rental)))
cat(sprintf("Films with PG rating and rental > 5 days: %d\n", nrow(query1)))
cat(sprintf("Films never rented: %d\n", nrow(query6)))
cat(sprintf("Average rental rate across all films: $%.2f\n", mean(film$rental_rate)))

cat("\n=== All queries completed successfully! ===\n")
cat("Results saved to output/ directory\n")
cat("Plots saved to plots/ directory\n")
