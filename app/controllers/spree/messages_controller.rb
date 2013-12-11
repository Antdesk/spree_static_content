class Spree::MessagesController < Spree::StoreController

  before_filter :check_fields, :only => :create

  def new
    @message = Spree::Message.new

  end

  def check_fields
    if params[:message][:name] == '*Namn'
      params[:message][:name] = ''
    end
    if params[:message][:phone] == 'Telefonnummer'
      params[:message][:phone] = ''
    end
    if params[:message][:email] == '*Mailadress'
      params[:message][:email] = ''
    end
    if params[:message][:hau] == 'Hur fick du information om oss?'
      params[:message][:hau] = ''
    end
    if params[:message][:title] == '*Amne'
      params[:message][:title] = ''
    end
    if params[:message][:content] == '*Meddelande'
      params[:message][:content] = ''
    end

  end

  def create
    @message = Spree::Message.new(params[:message])

    if @message.valid? and verify_recaptcha(:model => @message, :private_key => '6LdJkesSAAAAAJ2jnla3m31yN-FzgvONRyWj3pBn', :message => "Oh! It's error with reCAPTCHA!")
      if Spree::ContactMailer.contact_email(@message).deliver
        flash[:notice] = 'Wiadomosc wyslana! Dziekuje za poinformowanie nas.'
        redirect_to root_url and return
      end
      render :json => "fail" and return
    else
      render :json => @message and return
      render :action => 'new'
    end
  end

end