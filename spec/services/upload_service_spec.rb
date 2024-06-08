require 'rails_helper'

RSpec.describe UploadService do
  let(:file) { fixture_file_upload(Rails.root.join('spec/fixtures/uploads/users.csv'), 'text/csv') }
  let(:malformed_file) { fixture_file_upload(Rails.root.join('spec/fixtures/uploads/malformed.csv'), 'text/csv') }
  let(:upload_valid) { Upload.new(file) }
  let(:upload_malformed) { Upload.new(malformed_file) }

  describe '#perform' do
    it 'successfully processes a valid csv' do
      service = described_class.new(upload_valid)

      expect { service.perform }.to change(User, :count).by(2)
      expect(service.results.count).to eq(7)
      expect(service.results.first[:result]).to eq('success')
    end

    it 'raises an UploadError on a malformed csv' do
      service = described_class.new(upload_malformed)
      expect { service.perform }.to raise_error(UploadError)
    end
  end
end
