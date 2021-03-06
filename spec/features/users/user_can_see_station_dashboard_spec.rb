require 'rails_helper'

describe 'User' do
  context 'who is logged in' do
    it 'can see all of the stations dashboard information' do
      station1 = Station.create(name:'Turing Station', dock_count: 2, city: 'Denver', installation_date:'2018-05-01 01:00:00 UTC')
      station2 = Station.create(name:'G School Station', dock_count: 4, city: 'Denver', installation_date:'2018-05-03 01:00:00 UTC')
      station3 = Station.create(name:'Red Rock', dock_count: 8, city: 'Denver', installation_date:'2018-05-04 01:00:00 UTC')
      station4 = Station.create(name:'Holy Heck', dock_count: 3, city: 'Denver', installation_date:'2018-05-03 01:00:00 UTC')

      visit(stations_dashboard_path)

      expect(current_path).to eq(stations_dashboard_path)
      expect(page).to have_content("#{Station.all.count}")
      expect(page).to have_content("#{Station.average(:dock_count).round}")
      expect(page).to have_content("#{station3.dock_count}")
      expect(page).to have_content("#{station3.name}")
      expect(page).to have_content("#{station1.dock_count}")
      expect(page).to have_content("#{station1.name}")
      expect(page).to have_content("#{station1.name}")
      expect(page).to have_content("#{station3.name}")
    end
  end
end
