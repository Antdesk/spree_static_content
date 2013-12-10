class Spree::ContactMailer < ActionMailer::Base
  default to: "adrian.toczydlowski@gmail.com"

  def contact_email(user)
    @user = user
    @url = 'http://lycolife.se'
    mail(from: @user.email, subject: @user.title)

  end
end