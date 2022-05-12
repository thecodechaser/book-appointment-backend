# frozen_string_literal: true

module RenderHelper
  extend ActiveSupport::Concern

  def render_success(options)
    render json: { success: true, message: options[:message], data: options[:data] }, status: :multi_status
  end

  def render_error(error)
    render json: { success: false, errors: error }, status: :unprocessable_entity
  end

  def create_helper(value, message)
    if value.id
      if value.destroy!
        render_success({ message: message, data: value }) 
       elsif value.save
      render_success({ message: message, data: value })
       end
    else
      render_error(value.errors)
  end
end
