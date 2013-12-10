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

    if @message.valid? and verify_recaptcha()
      #@dane = {:email => "adrian.toczydlowski@gmail.com", :from_address => @message.email,
      #         :subject => @message.content}

      #if ActionMailer::Base.mail(to: "adrian.toczydlowski@gmail.com", from: "adrian.toczydlowski@gmail.com", subject: "ddasd").deliver
      #  render :json => @dane and return
      #  flash[:success] = Spree.t('sukces22')
      #end
      if Spree::ContactMailer.contact_email(@message).deliver
        flash[:notice] = 'Wiadomosc wyslana! Dziekuje za poinformowanie nas.'
        redirect_to root_url and return
      end
      render :json => "fail" and return
    else
      render :action => 'new'
    end
  end

end