class ContactsController < ApplicationController
  rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed

  def index
    @contacts = Contact.all
    render json: @contacts
  end

  def create
    contact = Contact.new(contact_params)
    if contact.save
      render json: contact, status: :created
    else
      render json: contact.errors, status: :unprocessable_entity
    end
  end

  def destroy
    Contact.find(params[:id]).destroy!
    head :no_content
  end


  private

  def not_destroyed
    render json: {}, status: :unprocessable_entity
  end

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :email, :phone_number)
  end
end
