class PagesController < ApplicationController
  def home
    @profile = Profile.find_by(id: params[:profile_id])
  end
end
