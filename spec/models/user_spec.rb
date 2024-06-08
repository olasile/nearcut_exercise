require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user)}

  context 'valid attributes' do
    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end
  end

  context 'invalid attributes' do
    it 'is invalid without a name' do
      user.name = nil
      expect(user).not_to be_valid
    end

    it 'is invalid without a password' do
      user.password = nil
      expect(user).not_to be_valid
    end

    it 'is invalid with a short password' do
      user.password = 'Abc123'
      expect(user).not_to be_valid
    end

    it 'is invalid without an uppercase character or digit' do
      user.password = 'abcdefghijklmnop'
      expect(user).not_to be_valid
    end

    it 'is invalid with a password containing three repeating characters' do
      user.password = 'AAAfk1swods'
      expect(user).not_to be_valid
    end
  end
end
