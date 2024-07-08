require 'rails_helper'
RSpec.describe Survey, type: :request do

  SURVEY_URL = "/surveys"

  describe 'create' do
    it 'when pass the correct params' do
      post SURVEY_URL, params: { survey: { name: "abc" , description: "abc and more"} }
      data = JSON.parse(response.body)
      expect(response).to have_http_status(201)
      expect(data["message"]).to eq("Survey saved successfully!")
    end
    it 'when pass the wrong params' do
      post SURVEY_URL, params: { survey: {description: "abc and more"} }
      data = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(data["message"]).to eq("Can not save survey!")
    end
  end

  describe 'index' do
    it 'get list' do
      FactoryBot.create(:survey)
      get SURVEY_URL
      data = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(data["message"]).to eq("Survey fetched successfully!")
    end
    it 'when list is empty' do
      get SURVEY_URL
      data = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(data["message"]).to eq("There are no survey!")
    end
  end

  describe 'show' do
    it 'get' do
      survey = FactoryBot.create(:survey)
      get SURVEY_URL + "/#{survey.id}"
      data = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(data["message"]).to eq("Survey fetched successfully!")
    end
    it 'when list is empty' do
      get SURVEY_URL + "/5000"
      data = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(data["message"]).to eq("There are no survey!")
    end
  end

  describe 'update' do
    it 'get' do
      survey = FactoryBot.create(:survey)
      get SURVEY_URL + "/#{survey.id}", params: { survey: { name: "abc" , description: "abc and more"} }
      data = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(data["message"]).to eq("Survey updated successfully!")
    end
    it 'when list is empty' do
      get SURVEY_URL + "/5000", params: { survey: { name: "" , description: "abc and more"} }
      data = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(data["message"]).to eq("Can not save survey!")
    end
    it 'when list is empty' do
      survey = FactoryBot.create(:survey)
      get SURVEY_URL + "/#{survey.id}", params: { survey: { name: "" , description: "abc and more", label:{:1 => "hiii"} }
      data = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(data["message"]).to eq("Can not save survey!")
    end
  end

end
