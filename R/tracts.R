#' An R6 object for creating choropleths of Census Tracts.
#' @importFrom tigris tracts
#' @export
TractChoropleth = R6Class("TractChoropleth",
  inherit = choroplethr::Choropleth,
  public = list(
    
    # initialize with the proper shapefile
    initialize = function(state_fips, user.df)
    {
      tract.map = get_tract_map(state_fips)
      super$initialize(tract.map, user.df)
      
      if (private$has_invalid_regions)
      {
        warning("Your dataframe contains unmappable regions")
      }
    }
  )
)

#' Create a choropleth of Census Tracts in a particular state.
#' 
#' @param df A data.frame with a column named "region" and a column named "value".  
#' @param state_fips the FIPS code for the state you want to map
#' @param title An optional title for the map.  
#' @param legend An optional name for the legend.  
#' @param num_colors The number of colors on the map. A value of 1 
#' will use a continuous scale. A value in [2, 9] will use that many colors. 
#' @param reference_map If true, render the choropleth over a reference map from Google Maps.
#'
#' @seealso \url{https://www.census.gov/geo/reference/gtc/gtc_ct.html} for more information on Census Tracts
#' @export
#' @importFrom Hmisc cut2
#' @importFrom stringr str_extract_all
#' @importFrom ggplot2 ggplot aes geom_polygon scale_fill_brewer ggtitle theme theme_grey element_blank geom_text
#' @importFrom ggplot2 scale_fill_continuous scale_colour_brewer  
#' @importFrom scales comma
tract_choropleth = function(df, 
                            state_fips,
                            title         = "", 
                            legend        = "", 
                            num_colors    = 7, 
                            reference_map = FALSE)
{
  c = TractChoropleth$new(state_fips, df)
  c$title  = title
  c$legend = legend
  c$set_num_colors(num_colors)
  if (reference_map) {
    c$render_with_reference_map()
  } else {
    c$render()
  }
}