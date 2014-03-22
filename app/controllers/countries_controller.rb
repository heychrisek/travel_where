class CountriesController < ApplicationController

  def welcome
  end

  def index
    @countries = Country.all
  end

  def new
    @country = Country.new
  end

  def show
    @country = Country.last
  end

  def create
    @country = Country.find_or_create_by(country_params)
    hdi_value = @country.find_hdi_value_2012
    # rescue RuntimeError [for spelling]
    #   render :new
    @country.hdi = Hdi.new(:hdi_value_2012 => hdi_value)
    if @country.save
      redirect_to countries_show_path
    else
      render :new
    end
  end

  private
  def country_params
    params.require(:country).permit(:name)
  end

end
