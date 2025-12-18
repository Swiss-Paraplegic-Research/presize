FROM rocker/shiny-verse:4.4.0

# System dependencies
RUN apt-get update -qq && apt-get install -y \
    libcurl4-openssl-dev libssl-dev libxml2-dev && \
    apt-get clean

# Copy entire package + install it first (for R/ functions)
COPY . /app/
WORKDIR /app
RUN R -e "remotes::install_local('.', dependencies = TRUE)"

# Change to Shiny app directory
WORKDIR /app/inst/ShinyApp

EXPOSE 3838
CMD ["/usr/bin/shiny-server"]
