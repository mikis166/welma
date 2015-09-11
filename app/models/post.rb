class Post < ActiveRecord::Base
  belongs_to :user

  before_create :save_permalink

  before_save :save_html

  def save_permalink
  	write_attribute :permalink, title.parameterize
  end

  def save_html
  	md  = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new, extensions = {})
  	write_attribute :html, md.render(markdown)
  end

end
