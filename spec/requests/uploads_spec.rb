require 'rails_helper'

RSpec.describe "Uploads", type: :request do
  describe 'GET /new' do
    it 'returns a successful response' do
      get new_upload_path
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    it 'processes the upload successfully' do
      file = fixture_file_upload(Rails.root.join('spec/fixtures/uploads/users.csv'), 'text/csv')

      expect { post uploads_path, params: { upload: { file: file } } }.to change(User, :count).by(2)
      expect(assigns(:results)).to be_present
      expect(assigns(:results).count).to eq(7)
    end

    it 'gracefully handles a malformed csv' do
      malformed_file = fixture_file_upload(Rails.root.join('spec/fixtures/uploads/malformed.csv'), 'text/csv')

      expect { post uploads_path, params: { upload: { file: malformed_file } } }.not_to change(User, :count)

      expect(flash.now[:alert]).to eq("Any value after quoted field isn't allowed in line 3.")
    end
  end
end
