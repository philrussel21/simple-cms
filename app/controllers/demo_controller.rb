class DemoController < ApplicationController
  
  layout false
  def index
  end

  def home
    @id = params[:id]
    @page = params['page']
  end

  def about
    render("about_us")
  end

  def contact
    @country = params[:country]

    if @country == "us" || @country == "ca"
      @ph_num = "(800) 555-6789"
    elsif @country == "uk"
      @ph_num = "(020) 7946 1234"
    else
      @ph_num = "+1(987) 654-3210"
    end

    render("contact_us")
  end

end
