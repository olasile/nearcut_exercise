require 'rails_helper'

RSpec.describe Upload, type: :model do
  let(:file) { fixture_file_upload(Rails.root.join('spec/fixtures/uploads/users.csv'), 'text/csv') }
  let(:upload) { described_class.new(file) }
  let(:upload_service) { instance_double(UploadService) }

  it 'process' do
    allow(UploadService).to receive(:new).with(upload).and_return(upload_service)
    expect(upload_service).to receive(:perform)

    upload.process
  end
end
