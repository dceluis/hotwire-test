class EmploymentsController < ApplicationController
  before_action :set_profile

  def new
    @employment = Employment.new
    @employments = [@employment]

    if params[:append]
      streams = [
        turbo_stream.replace("add_employment", partial: "employments/add_employment", locals: { i: params[:append].to_i + 1 }),
        turbo_stream.append("employments", partial: 'employments/fields_for_employment', locals: { employment: @employment, index: params[:append]})
      ]

      render turbo_stream: streams
    else
      render "new"
    end
  end

  def validate
    @employments = employment_params.map { |ps| @profile.employments.new(ps) }

    respond_to do |format|
      # format.html
      format.turbo_stream { @employments.each(&:validate) }
    end
  end

  def create
    @employments = employment_params.map { |ps| @profile.employments.new(ps) }

    Employment.transaction do
      @employments.each(&:save!)
    end

    redirect_to root_path
  rescue ActiveRecord::RecordInvalid => e
    render 'new'
  end

  def employment_params
    params[:employments]&.map { |p| p.permit(:employer, :start_date, :end_date) } || [{}]
  end

  def set_profile
    @profile = Profile.find(params[:profile_id])
  end
end
