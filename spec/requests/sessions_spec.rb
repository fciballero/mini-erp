require "rails_helper"

RSpec.describe "Authentication", type: :request do
  let(:organization) { Organization.create!(name: "Acme", slug: "acme") }
  let!(:user) do
    ActsAsTenant.with_tenant(organization) do
      User.create!(email: "user@example.com", password: "password")
    end
  end

  it "redirects anonymous users to the login page" do
    get root_path

    expect(response).to redirect_to(login_path)
  end

  it "renders the login page" do
    get login_path

    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Log in")
    expect(response.body).to include("user_email")
  end

  it "allows authenticated users to access the dashboard" do
    sign_in user

    get root_path

    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Bienvenido, user@example.com.")
  end

  it "logs authenticated users out" do
    sign_in user

    delete destroy_user_session_path

    expect(response).to redirect_to(login_path)
  end
end
