require "rails_helper"

RSpec.describe Organization, type: :model do
  subject(:organization) { described_class.new(name: "Acme", slug: "acme") }

  it "is valid with a name and unique slug" do
    expect(organization).to be_valid
  end

  it "requires a unique slug" do
    described_class.create!(name: "Existing", slug: "acme")

    expect(organization).not_to be_valid
    expect(organization.errors[:slug]).to include("has already been taken")
  end
end
