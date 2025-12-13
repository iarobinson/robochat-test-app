module Robochat
  class MessagesController < ApplicationController
    before_action :initialize_provider_manager
    
    def index
      @providers = @provider_manager.available_providers
      @default_provider = Robochat.configuration.default_provider
    end

    def claude
      @provider = :claude
      @providers = [:claude]
      @default_provider = :claude
      render :index
    end

    def openai
      @provider = :openai
      @providers = [:openai]
      @default_provider = :openai
      render :index
    end

    def create
      message = params[:message]
      provider_name = params[:provider]&.to_sym || Robochat.configuration.default_provider
      
      provider = @provider_manager.get_provider(provider_name)
      response_text = provider.chat(message)
      
      render json: { 
        response: response_text,
        provider: provider_name
      }
    rescue StandardError => e
      Rails.logger.error "Robochat Error: #{e.message}"
      render json: { 
        response: "I'm sorry, I encountered an error. Please try again.",
        error: e.message
      }, status: 500
    end
    
    private
    
    def initialize_provider_manager
      @provider_manager = Robochat::ProviderManager.new(Robochat.configuration)
    end
  end
end