# Expected Results from Sakila Analysis

This document shows sample outputs you should expect when running the analysis script.

## Query 1: Films with PG Rating and Rental Duration > 5

**Expected Output:**
```
   film_id              title rating rental_duration rental_rate
1:       1  ACADEMY DINOSAUR     PG               6        0.99
2:       6      AGENT TRUMAN     PG               3        2.99
3:       7    AIRPLANE SIERRA   PG-13               6        4.99
4:      12     ALASKA PHANTOM     PG               6        0.99
5:      13        ALI FOREVER     PG               4        4.99
6:      19       AMADEUS HOLY     PG               6        0.99
```

**Total films found:** Films matching criteria (PG rating AND rental_duration > 5)

---

## Query 2: Average Rental Rate by Rating

**Expected Output:**
```
   rating film_count avg_rental_rate min_rental_rate max_rental_rate
1:  NC-17         10            2.17            0.99            4.99
2:      R          7            2.71            0.99            4.99
3:  PG-13          9            2.44            0.99            4.99
4:     PG          6            1.82            0.99            4.99
5:      G         18            2.33            0.99            4.99
```

**Interpretation:** Shows distribution of rental rates across different film ratings.

---

## Query 3: Film Count by Language

**Expected Output:**
```
   language_id language_name total_films
1:           1       English          44
2:           2       Italian           3
3:           3      Japanese           1
4:           6        German           0
5:           5        French           0
```

**Interpretation:** Most films are in English, with a few in Italian and Japanese.

---

## Query 4: Customers and Their Stores

**Expected Output (first 10 rows):**
```
    customer_id      customer_name                           email store_id store_manager_id
 1:           1        MARY SMITH    MARY.SMITH@sakilacustomer.org        1                1
 2:           2  PATRICIA JOHNSON PATRICIA.JOHNSON@sakilacustomer.org        1                1
 3:           3   LINDA WILLIAMS  LINDA.WILLIAMS@sakilacustomer.org        1                1
 4:           5 ELIZABETH BROWN ELIZABETH.BROWN@sakilacustomer.org        1                1
 5:           7     MARIA MILLER    MARIA.MILLER@sakilacustomer.org        1                1
 6:          10   DOROTHY TAYLOR  DOROTHY.TAYLOR@sakilacustomer.org        1                1
 7:          12     NANCY THOMAS    NANCY.THOMAS@sakilacustomer.org        1                1
 8:          15     HELEN HARRIS    HELEN.HARRIS@sakilacustomer.org        1                1
 9:          17   DONNA THOMPSON  DONNA.THOMPSON@sakilacustomer.org        1                1
10:          19   RUTH MARTINEZ   RUTH.MARTINEZ@sakilacustomer.org        1                1
```

**Total customers:** 20

---

## Query 5: Payment Details with Staff Information

**Expected Output (first 10 rows):**
```
    payment_id customer_id amount       payment_date      staff_name                   staff_email
 1:          1           1   2.99 2005-05-25 11:30:37   Mike Hillyer Mike.Hillyer@sakilastaff.com
 2:          2           1   0.99 2005-05-28 10:35:23   Mike Hillyer Mike.Hillyer@sakilastaff.com
 3:          3           1   5.99 2005-06-15 00:54:12   Mike Hillyer Mike.Hillyer@sakilastaff.com
 4:          4           1   0.99 2005-06-15 18:02:53  Jon Stephens  Jon.Stephens@sakilastaff.com
 5:          5           1   9.99 2005-06-15 21:08:46  Jon Stephens  Jon.Stephens@sakilastaff.com
 6:          6           2   4.99 2005-06-16 15:18:57   Mike Hillyer Mike.Hillyer@sakilastaff.com
 7:          7           2   4.99 2005-06-18 08:41:48   Mike Hillyer Mike.Hillyer@sakilastaff.com
 8:          8           2   0.99 2005-06-18 13:33:59  Jon Stephens  Jon.Stephens@sakilastaff.com
 9:          9           3   3.99 2005-06-21 06:24:45   Mike Hillyer Mike.Hillyer@sakilastaff.com
10:         10           3   5.99 2005-07-08 03:17:05   Mike Hillyer Mike.Hillyer@sakilastaff.com
```

**Total payments:** 20

---

## Query 6: Films Not Rented

**Expected Output:**
```
    film_id                    title rating rental_rate
 1:      26           ANNIE IDENTITY      G        0.99
 2:      27          ANONYMOUS HUMAN  NC-17        0.99
 3:      28              ANTHEM LUKE  PG-13        4.99
 4:      29       ANTITRUST TOMATOES  NC-17        2.99
 5:      30       ANYTHING SAVANNAH      R        2.99
 6:      31            APACHE DIVINE  NC-17        4.99
 7:      32     APOCALYPSE FLAMINGOS      R        4.99
 ... (more films)
```

**Total unreturned films:** Films that exist in inventory but have no rental records.

---

## Query 7: Visualizations

### Plot 1: Film Rating Distribution
**File:** `plots/film_rating_distribution.png`

**Description:** Bar chart showing the count of films for each rating category (G, PG, PG-13, R, NC-17). Each bar is labeled with the exact count.

**Features:**
- Color-coded bars for each rating
- Count labels on top of bars
- Professional styling with clean theme
- High resolution (300 DPI)

### Plot 2: Rental Rate Distribution
**File:** `plots/rental_rate_distribution.png`

**Description:** Histogram showing the frequency distribution of rental rates across all films.

**Features:**
- Shows concentration of rental rates
- Identifies most common price points
- Helps understand pricing strategy
- High resolution (300 DPI)

---

## Summary Statistics

When running the complete analysis, you'll see:

```
=== ANALYSIS SUMMARY ===
Total Films: 50
Total Customers: 20
Total Payments: 20
Total Rentals: 20
Films with PG rating and rental > 5 days: 6
Films never rented: 20
Average rental rate across all films: $2.48
```

---

## File Outputs

After running `source("scripts/sakila_analysis.R")`, you should have:

### CSV Files (in output/)
1. `query1_pg_films.csv` - Films with PG rating and rental duration > 5
2. `query2_avg_rental_by_rating.csv` - Average rental rates by rating
3. `query3_films_by_language.csv` - Film counts per language
4. `query4_customers_stores.csv` - Customer and store information
5. `query5_payments_staff.csv` - Payment details with staff info
6. `query6_unreturned_films.csv` - Films not yet rented

### Image Files (in plots/)
1. `film_rating_distribution.png` - Bar chart of films by rating
2. `rental_rate_distribution.png` - Histogram of rental rates

---

## Verification Checklist

- [ ] All 7 queries execute without errors
- [ ] All CSV files created in `output/` directory
- [ ] Both PNG files created in `plots/` directory
- [ ] Console output shows results for each query
- [ ] No missing or NULL values in critical fields
- [ ] Data.table syntax used throughout (no SQL)
- [ ] All joins produce expected number of rows
- [ ] Visualizations are clear and professional

---

**Note:** The exact numbers may vary depending on the sample data, but the structure and format of outputs should match these examples.
