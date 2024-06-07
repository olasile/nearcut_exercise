require 'rails_helper'

RSpec.describe "Uploads", type: :request do
  let(:file) { fixture_file_upload(Rails.root.join('spec/fixtures/uploads/users.csv'), 'text/csv') }

  describe 'GET /new' do
    it 'returns a successful response' do
      get new_upload_path
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    let(:results) do
      [
        {
          name: 'Muhammad',
          result: 'success',
        },
        {
          name: 'Maria Turing',
          result: User::PASSWORD_VALIDATION_MESSAGE
        },
        {
          name: 'Isabella',
          result: User::PASSWORD_VALIDATION_MESSAGE
        },
        {
          name: 'Axel',
          result: User::PASSWORD_VALIDATION_MESSAGE
        },
        {
          name: '',
          result: "Name can't be blank"
        },
        {
          name: 'Test User',
          result: User::PASSWORD_VALIDATION_MESSAGE
        }
      ]
    end

    it 'processes the users' do
      post uploads_path, params: { upload: { file: file } }

      expect(response).to be_successful
      expect(assigns(:upload)).to be_present
      expect(assigns(:upload).results).to eq(results)
    end
  end
end
