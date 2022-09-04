class ProfilesController < ApplicationController
  # Skip validation endpoint
  skip_before_action :verify_authenticity_token, only: [:new]

  def new
    @profile = Profile.new(profile_params)

    respond_to do |format|
      format.html
      format.turbo_stream { @profile.valid? }
    end
  end

  def create
    @profile = Profile.new(profile_params)

    if @profile.save
      redirect_to root_path(profile_id: @profile.id)
    else
      render 'new'
    end
  end

  def profile_params
    params[:profile]&.permit(:first_name, :last_name, :nickname, :email, :phone) || {}
  end
end
