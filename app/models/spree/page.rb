class Spree::Page < ActiveRecord::Base
  default_scope :order => "position ASC"

  validates_presence_of :title
  validates_presence_of :body

  scope :visible, where(:visible => true)

  before_save :update_positions_and_slug

  attr_accessible :title, :slug, :body, :position, :visible

  def self.by_slug(slug)
    slug = StaticPage::remove_spree_mount_point(slug)
    pages = self.arel_table
    query = pages[:slug].eq(slug).or(pages[:slug].eq("/#{slug}"))
    self.where(query)
  end

  def initialize(*args)
    super(*args)

    last_page = Spree::Page.last
    self.position = last_page ? last_page.position + 1 : 0
  end

  def link
    slug
  end

private

  def update_positions_and_slug
    unless new_record?
      return unless prev_position = Spree::Page.find(self.id).position
      if prev_position > self.position
        Spree::Page.update_all("position = position + 1", ["? <= position AND position < ?", self.position, prev_position])
      elsif prev_position < self.position
        Spree::Page.update_all("position = position - 1", ["? < position AND position <= ?", prev_position,  self.position])
      end
    end

    return true
  end

end
