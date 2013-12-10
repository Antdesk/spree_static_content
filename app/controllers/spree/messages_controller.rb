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

    if @message.valid?
      flash[:notice] = 'Wiadomosc wyslana! Dziekuje za poinformowanie nas.'
      @dane = {:email => "adrian.toczydlowski@gmail.com", :from_address => @message.email, :subject => @message.content}

      if ActionMailer::Base.mail(to: @dane.email, from: @dane.from_address, subject: @dane.subject).deliver
        flash[:success] = Spree.t('sukces22')
      end
      render :json => @dane and return
      if Spree::TestMailer.contact_email(@dane).deliver
        flash[:success] = Spree.t('sukces')
      end
      redirect_to root_url
    else
      render :action => 'new'
    end
  end

end