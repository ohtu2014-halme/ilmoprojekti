
require 'spec_helper'
include TestHelper

describe "Projectpundle page" do

  it "none of the views can be accessed by a teacher" do
    user = FactoryGirl.create(:teacher)
    projectbundle = FactoryGirl.create(:projectbundle)
    signin(username:user.username, password:user.password)
    visit new_projectbundle_path

    expect(page).to have_content("Vain järjestelmävalvojalla on pääsy sivulle")

    visit projectbundles_path

    expect(page).to have_content("Vain järjestelmävalvojalla on pääsy sivulle")

    visit projectbundle_path(projectbundle)

    expect(page).to have_content("Vain järjestelmävalvojalla on pääsy sivulle")

    visit edit_projectbundle_path(projectbundle)

    expect(page).to have_content("Vain järjestelmävalvojalla on pääsy sivulle")

  end

  describe "Projectbundle new" do



    it "should have correct texts in the page" do
      user = FactoryGirl.create(:admin)
      signin(username:user.username, password:user.password)
      visit new_projectbundle_path;

      expect(page).to have_content("Projektiryhmän nimi")
      expect(page).to have_content("Kuvaus")
      expect(page).to have_content("Ilmoittautuminen alkaa")
      expect(page).to have_content("Ilmoittautuminen päättyy")
      expect(page).to have_content("Aktiivinen")

    end

    it "should have correct fields in the page" do
      user = FactoryGirl.create(:admin)
      signin(username:user.username, password:user.password)
      visit new_projectbundle_path;

      expect(page).to have_unchecked_field("projectbundle_active")
      expect(page).to have_field("projectbundle_description")
      expect(page).to have_button("Tallenna projektiryhmä")
    end

    it "should go to own page after creating valid bundle" do
      user = FactoryGirl.create(:admin)
      signin(username:user.username, password:user.password)
      visit new_projectbundle_path;
      fill_in("projectbundle_name", with: 'testi')
      fill_in("projectbundle_description", with: 'testingtesting')

      click_button("Tallenna projektiryhmä")

      expect(page).to have_content "Projektiryhmä onnistuneesti luotu."
    end

    it "should not create new bundle after creating with empty name field" do
      user = FactoryGirl.create(:admin)
      signin(username:user.username, password:user.password)
      visit new_projectbundle_path;
      fill_in("projectbundle_name", with: '')
      fill_in("projectbundle_description", with: 'testingtesting')

      click_button("Tallenna projektiryhmä")

      expect(page).to have_content "Nimi ei voi olla sisällötön"
    end
    it "should not create new bundle after creating with empty description field" do
      user = FactoryGirl.create(:admin)
      signin(username:user.username, password:user.password)
      visit new_projectbundle_path;
      fill_in("projectbundle_name", with: 'testi')
      fill_in("projectbundle_description", with: '')

      click_button("Tallenna projektiryhmä")

      expect(page).to have_content "Kuvaus ei voi olla sisällötön"
      end
  end
  describe "Projectbundle edit" do
    it "should change the name when edited with valid information" do
      user = FactoryGirl.create(:admin)
      signin(username:user.username, password:user.password)
      projectbundle = FactoryGirl.create(:projectbundle, name:"Testi")


      visit "/projectbundles/#{projectbundle.id}/edit"

      fill_in("projectbundle_name", with: "Muokattu")
      #expect{
        click_button "Tallenna projektiryhmä"
      #}.to change{projectbundle.name}.from("Testi").to("Muokattu")
      expect(page).to have_content "Muokattu"
    end
  end

  describe "Projectbundle edit" do
    it "should change the description when edited with valid information" do
      user = FactoryGirl.create(:admin)
      signin(username:user.username, password:user.password)
      projectbundle = FactoryGirl.create(:projectbundle, name:"Testi", description: "Testing")


      visit "/projectbundles/#{projectbundle.id}/edit"

      fill_in("projectbundle_description", with: "Muokattu")

      click_button "Tallenna projektiryhmä"

      expect(page).to have_content "Muokattu"
    end

    it "should not update the project if fields do not pass validation " do
      user = FactoryGirl.create(:admin)
      signin(username:user.username, password:user.password)
      projectbundle = FactoryGirl.create(:projectbundle, name:"Testi", description: "Testing")

      visit "/projectbundles/#{projectbundle.id}/edit"

      fill_in("projectbundle_description", with: "")

      click_button "Tallenna projektiryhmä"

      expect(page).to have_content "1 virhe esti projektinipun tallentamisen:"
    end

  end

  describe "Projectbundle destroy" do
    it "should destroy a project if user is logged in as an admin" do
      user = FactoryGirl.create(:admin)
      signin(username:user.username, password:user.password)
      projectbundle = FactoryGirl.create(:projectbundle, name:"Testi", description: "Testing")

      expect(Projectbundle.count).to be(1)

      visit projectbundles_path

      click_link("Poista")

      expect(Projectbundle.count).to be(0)

    end


  end


end
