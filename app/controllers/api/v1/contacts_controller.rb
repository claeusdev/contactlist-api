class Api::V1::ContactsController < ApplicationController
  rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed
  before_action :set_contact, only: [:show, :update, :destroy]

  def index
    @contacts = Contact.all
    render json: serialize(@contacts, options)
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      render json: serialize(@contact), status: :created
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  def update
    if @contact.update(contact_params)
      render json: serialize(@contact, options), status: 200
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: serialize(@contact, options), status: 200
  end

  def destroy
    @contact.destroy!
    head :no_content
  end


  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def options
    @options ||= { include: %i[edit_logs] }
  end

  # Get all contacts
  def contacts
    @contacts ||= Contact.includes(:edit_logs).all
  end

  def contact
    @contact ||= Contact.includes(:edit_logs).find(params[:id])
  end

  def serialize(records, options = {})
    ContactSerializer.new(records, options).serializable_hash.to_json
  end

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :email, :phone_number)
  end
end
