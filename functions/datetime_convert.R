# packages
library(tidyverse)
library(lubridate)

# Helper fucntion to try to turn character columns into POSIXct date-times
convert_to_datetime <- function(x) {
  if (!is.character(x)) return(x)

  x_clean <- na_if(x, "")

  dt <- suppressWarnings(
    parse_date_time(
      x_clean,
      orders = c(
        "mdY HMS p",  # 7/20/2025 10:41:25 PM
        "mdY HM p",   # 7/20/2025 10:41 PM
        "mdY HMS",    # 7/20/2025 22:41:25
        "mdY HM",     # 7/20/2025 22:41
        "mdY",        # 7/20/2025
        "Ymd HMS",    # 2025-07-20 22:41:25
        "Ymd HM",     # 2025-07-20 22:41
        "Ymd"         # 2025-07-20
      ),
      tz = "America/Anchorage"   # change if you prefer a different tz
    )
  )

  # If parsing completely failed, keep original column
  if (all(is.na(dt))) x else dt
}
