require 'rails_helper'

describe "Contacts", type: :request do
  it 'returns all contacts' do
    get '/api/v1/contacts'

    expect(response).to have_http_status(:success)
    expect(JSON.parse(response.body).size).to eq(2)
  end
end
