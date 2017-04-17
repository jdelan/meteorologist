require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

    url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + @street_address.gsub(" ","+")
    parsed_data = JSON.parse(open(url).read)
    latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
    longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

    weather_url = "https://api.darksky.net/forecast/bf63e8ad46b14e539229a60f2b5ca166/" + latitude.to_s + "," + longitude.to_s
    weather_parsed_data = JSON.parse(open(weather_url).read)

    @current_temperature = weather_parsed_data["currently"]["temperature"]

    @current_summary = weather_parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = weather_parsed_data["minutely"]["summary"]

    @summary_of_next_several_hours = weather_parsed_data["hourly"]["summary"]

    @summary_of_next_several_days = weather_parsed_data["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
