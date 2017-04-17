require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("forecast/coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================


    weather_url = "https://api.darksky.net/forecast/bf63e8ad46b14e539229a60f2b5ca166/" + @lat.to_s + "," + @lng.to_s
    weather_parsed_data = JSON.parse(open(weather_url).read)


    @current_temperature = weather_parsed_data["currently"]["temperature"]

    @current_summary = weather_parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = weather_parsed_data["minutely"]["summary"]

    @summary_of_next_several_hours = weather_parsed_data["hourly"]["summary"]

    @summary_of_next_several_days = weather_parsed_data["daily"]["summary"]

    render("forecast/coords_to_weather.html.erb")
  end
end
