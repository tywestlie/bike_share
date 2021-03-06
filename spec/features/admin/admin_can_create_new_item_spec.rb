require 'rails_helper'

describe 'As an admin' do
  describe 'I visit the admin dashboard' do
    it 'can click on a button to create' do
      admin = User.create(first_name: 'Gertrude', last_name: 'McGillicuddy', address:'123 admin street', username:'admin', password: 'admin', role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_dashboard_path

      click_on 'Create New Accessory'

      expect(current_path).to eq(admin_bike_shop_new_path)
    end

    it 'can create a new accessory' do
      title = "Jeff Goldblum"
      price = 100.00
      description = 'Jeff Goldblum is a tryranasarous'
      image = 'https://cdn.movieweb.com/img.news.tops/NE3SJdAlaqpY6b_1_b/Jurassic-Park-Jeff-Goldblum-Explains-Shirtless-Scene.jpg'

      admin = User.create(first_name: 'Gertrude', last_name: 'McGillicuddy', address:'123 admin street', username:'admin', password: 'admin', role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_bike_shop_new_path

      fill_in 'item[title]', with: title
      fill_in 'item[price]', with: price
      fill_in 'item[image]', with: image
      fill_in 'item[description]', with: description
      click_on 'Create Item'

      item = Item.last

      expect(current_path).to eq(item_path(item))

      expect(item.title).to eq(title)
      expect(item.price).to eq(price)
      expect(item.image).to eq(image)
      expect(item.description).to eq(description)
    end

    it 'uses place-holder image if none provided during creation' do
      title = "Jeff Goldblum"
      price = 100.00
      description = 'Jeff Goldblum is a tryranasarous'
      placeholder = 'https://images-na.ssl-images-amazon.com/images/I/41gvKImzHqL.jpg'

      admin = User.create(first_name: 'Gertrude', last_name: 'McGillicuddy', address:'123 admin street', username:'admin', password: 'admin', role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_bike_shop_new_path

      fill_in 'item[title]', with: title
      fill_in 'item[price]', with: price
      fill_in 'item[description]', with: description
      click_on 'Create Item'

      item = Item.last

      expect(current_path).to eq(item_path(item))

      expect(item.image).to eq(placeholder)
    end

    it 'cannot create an item that is less than zero' do
      title = "Unique title"
      price = -1.00
      description = 'Jeff Goldblum is a tryranasarous'
      error = "Item needs a price greater than zero"

      admin = User.create(first_name: 'Gertrude', last_name: 'McGillicuddy', address:'123 admin street', username:'admin', password: 'admin', role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_bike_shop_new_path

      fill_in 'item[title]', with: title
      fill_in 'item[price]', with: price
      fill_in 'item[description]', with: description
      click_on 'Create Item'

      expect(page).to have_content(error)
    end

    it 'item needs a unique name' do
      title = "Unique Title"
      price = 11.00
      image = 'placeholder.jpeg'
      description = 'Jeff Goldblum is a tryranasarous'
      error = "Item must have unique title"

      admin = User.create(first_name: 'Gertrude', last_name: 'McGillicuddy', address:'123 admin street', username:'admin', password: 'admin', role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      item = Item.create(title: title, price: price, image: image, description: description)

      visit admin_bike_shop_new_path

      fill_in 'item[title]', with: title
      fill_in 'item[price]', with: price
      fill_in 'item[description]', with: description
      click_on 'Create Item'


      expect(page).to have_content(error)
    end
  end
end
