module Spree
  HomeController.class_eval do
    def contact
      @message = Spree::Message.new

    end
  end
end