require 'rails_helper'

RSpec.feature "Primary charity admin creates charity admin" do
  scenario "successfully creates admin for corresponding charity" do
    create(:charity_admin_role)
    charity = create(:charity)
    primary_admin = create(:user)
    role = Role.create(name: "primary_charity_admin")

    UserRole.create(user: primary_admin, role: role, charity: charity)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( primary_admin )

    visit charity_dashboard_path(charity.slug, charity.id)

    click_on "Create New Admin"

    expect(page).to have_content("Create New Admin For #{charity.name}")

    within(".panel-body") do
      fill_in "Email",     with: "new@mail.com"
      fill_in "Cell",      with: "1234567890"
      fill_in "Username",  with: "apple"
      fill_in "Password",  with: "password"
      click_on "Create Charity Admin Account"
    end

    expect(page).to have_content("New admin 'apple' successfully created!")
  end
end
