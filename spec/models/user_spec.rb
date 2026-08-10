require "rails_helper"

RSpec.describe User, type: :model do
  subject(:user) do
    described_class.new(organization: organization, email: "user@example.com", password: "password")
  end

  let(:organization) { Organization.create!(name: "Acme", slug: "acme") }

  it "belongs to an organization" do
    expect(user).to be_valid
    expect(user.organization).to eq(organization)
  end

  it "requires an organization" do
    user_without_organization = described_class.new

    expect(user_without_organization).not_to be_valid
    expect(user_without_organization.errors[:organization]).to include("must exist")
  end
end
