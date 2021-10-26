require 'rails_helper'

describe 'Contacts', type: :request do
  describe 'GET /contacts' do
    before do
      FactoryBot.create(:contact, first_name: 'Nacho', last_name: 'Manu', email: 'nn@factorial.com',
                                  phone_number: '080889898')
      FactoryBot.create(:contact, first_name: 'Mo', last_name: 'Salah', email: 'victor@factorial.com',
                                  phone_number: '080889898')
    end

    it 'returns all contacts' do
      get '/api/v1/contacts'

      expect(response).to have_http_status(:success)
      response_data = JSON.parse(response.body)['data']
      expect(response_data.size).to eq(2)
    end
  end

  describe 'POST /contacts' do
    it 'creates a new contact' do
      expect do
        post '/api/v1/contacts', params: {
          contact:
            { first_name: 'Nana', last_name: 'Manu', email: 'nana@factorial.com', phone_number: '080889898' }
        }
      end.to change { Contact.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe 'DELETE /contacts/:id' do
    let!(:contact) do
      FactoryBot.create(:contact, first_name: 'Jeff', last_name: 'Manu', email: 'jeff@factorial.com',
                                  phone_number: '080889898')
    end

    it 'deletes a contacts' do
      expect do
        delete "/api/v1/contacts/#{contact.id}"
      end.to change { Contact.count }.from(1).to(0)
      expect(response).to have_http_status(:no_content)
    end
  end
end
