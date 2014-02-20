require 'spec_helper'
include TestHelper

describe "Enrollments page" do

  describe "Signup form" do

    it "has all the correct fields, lists project information and projects" do

      FactoryGirl.create :projectbundle

      generate_six_unique_projects_with_user(1)
      @projects = Project.all

      visit root_path

      expect(page).to have_content("Testibundle")

      expect(page).to have_content("Firstname")
      expect(page).to have_content("Lastname")
      expect(page).to have_content("Studentnumber")
      expect(page).to have_content("Email")

      expect(page).to have_content("1 This is a")
      expect(page).to have_content("2 This is a")
      expect(page).to have_content("3 This is a")
      expect(page).to have_content("4 This is a")
      expect(page).to have_content("5 This is a")
      expect(page).to have_content("6 This is a")

      expect(page).to have_content("123456")
      #expect(page).to have_content("Prioriteetti 2:123456")
      #expect(page).to have_content("Prioriteetti 3:123456")
      #expect(page).to have_content("Prioriteetti 4:123456")
      #expect(page).to have_content("Prioriteetti 5:123456")
      #expect(page).to have_content("Prioriteetti 6:123456")


    end

    it "accepts enrollment with correct form values" do

      FactoryGirl.create :projectbundle

      generate_six_unique_projects_with_user(1)
      @projects = Project.all

      expect(Project.count).to eq(6)

      visit root_path

      fill_in('enrollment_firstname', with:"Testi")
      fill_in('enrollment_lastname', with:"Testinen")
      fill_in('enrollment_studentnumber', with:"1234567")
      fill_in('enrollment_email', with:"testi@testi.fi")

      select('1', from:'enrollment[signups_attributes][0][project_id]')
      select('2', from:'enrollment[signups_attributes][1][project_id]')
      select('3', from:'enrollment[signups_attributes][2][project_id]')
      select('4', from:'enrollment[signups_attributes][3][project_id]')
      select('5', from:'enrollment[signups_attributes][4][project_id]')
      select('6', from:'enrollment[signups_attributes][5][project_id]')

      expect {
        click_button('Create Enrollment')
      }.to change{Signup.count}.by(6)

      expect(page).to have_content 'Nimi: Testi Testinen'
    end

    it "creates unique hash for users" do
      FactoryGirl.create :projectbundle

      generate_six_unique_projects_with_user(1)
      @projects = Project.all

      expect(Project.count).to eq(6)

      visit root_path

      fill_in('enrollment_firstname', with:"Testi")
      fill_in('enrollment_lastname', with:"Testinen")
      fill_in('enrollment_studentnumber', with:"1234567")
      fill_in('enrollment_email', with:"testi@testi.fi")

      select('1', from:'enrollment[signups_attributes][0][project_id]')
      select('2', from:'enrollment[signups_attributes][1][project_id]')
      select('3', from:'enrollment[signups_attributes][2][project_id]')
      select('4', from:'enrollment[signups_attributes][3][project_id]')
      select('5', from:'enrollment[signups_attributes][4][project_id]')
      select('6', from:'enrollment[signups_attributes][5][project_id]')

      user= Enrollment.find_by_studentnumber:'1234567'
  #    hash= Enrollment.create_hash(user)
  #    expect(page).to have_content 'http://ilmoprojekti.herokuapp.com/enrollments/edit/' + user.id + '/' + hash 
    end

    it "redirets to confirmation page containing information about signups" do
       FactoryGirl.create :projectbundle

      generate_six_unique_projects_with_user(1)
      @projects = Project.all

      expect(Project.count).to eq(6)

      visit root_path

      fill_in('enrollment_firstname', with:"Testi")
      fill_in('enrollment_lastname', with:"Testinen")
      fill_in('enrollment_studentnumber', with:"1234567")
      fill_in('enrollment_email', with:"testi@testi.fi")

      select('1', from:'enrollment[signups_attributes][0][project_id]')
      select('2', from:'enrollment[signups_attributes][1][project_id]')
      select('3', from:'enrollment[signups_attributes][2][project_id]')
      select('4', from:'enrollment[signups_attributes][3][project_id]')
      select('5', from:'enrollment[signups_attributes][4][project_id]')
      select('6', from:'enrollment[signups_attributes][5][project_id]')

      click_button('Create Enrollment')
      expect(page).to have_content('Henkilötiedot')
      expect(page).to have_content('Nimi: Testi Testinen')
      expect(page).to have_content('Opiskelijanumero: 1234567')
      expect(page).to have_content('Email: testi@testi.fi')

      @projects.each do |pro|
        expect(page).to have_content(pro.name)
      end

    end

 

  end

end