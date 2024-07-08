class SurveysController < ApplicationController
   
  skip_before_action :verify_authenticity_token  

  def create
    survey = Survey.create(survey_params)
    if survey.save
      render json: {message: "Survey saved successfully!", survey: survey}, status: :created
    else
      render json: {message: "Can not save survey!", errors: survey.errors}, status: :unprocessable_entity
    end
  end

  def index
    survey = Survey.all
    if survey.present?
      render json: {message: "Survey fetched successfully!", survey: survey}, status: :ok
    else
      render json: {message: "There are no survey!"}, status: :unprocessable_entity
    end
  end

  def show
    survey = Survey.find_by(id: params[:id])
    if survey.present?
      render json: {message: "Survey fetched successfully!", survey: survey}, status: :ok
    else
      render json: {message: "There are no survey!"}, status: :unprocessable_entity
    end
  end

  def destroy
    survey = Survey.find_by(id: params[:id])
    if survey.delete
      render json: {message: "Survey deleted successfully!"}, status: :ok
    else
      render json: {message: "There are no survey!"}, status: :unprocessable_entity
    end
  end

  def update
    survey = Survey.find_by(id: params[:id])
    if survey.present?
      survey.update(survey_params)
      params[:survey][:label].each do |record|
        Record.create(label: record.second, survey_id: survey.id)
      end
      if survey.save
        render json: {message: "Survey updated successfully!", survey: survey.reload}, status: :ok
      else
        render json: {message: "Can not save survey!", errors: survey.errors}, status: :unprocessable_entity
      end
    else
      render json: {message: "There are no survey!"}, status: :unprocessable_entity
    end
  end

  private

  def survey_params
    params.require(:survey).permit(:name, :description)
  end

end


