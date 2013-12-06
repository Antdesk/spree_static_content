class Spree::StaticContentController < Spree::StoreController

  helper "spree/products"
  layout :determine_layout

  def show
    path = case params[:path]
    when Array
      '/' + params[:path].join("/")
    when String
      '/' + params[:path]
    when nil
      request.path
    end

    unless @page = Spree::Page.visible.by_slug(path).first
      render_404
    end
  end

  def showoffer
    path = case params[:path]
             when Array
               '/' + params[:path].join("/")
             when String
               '/' + params[:path]
             when nil
               request.path
           end

    unless @page = Spree::Page.visible.by_slug(path).first
      render_404
    end
  end

  private

  def determine_layout
    Spree::Config.layout
  end

  def accurate_title
    @page.title
  end

end
