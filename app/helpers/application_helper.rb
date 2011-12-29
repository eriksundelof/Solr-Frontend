# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  # get the stylesheets...
  def get_stylesheets(is_admin=false)
    stylesheets = ['base', 'main']
    stylesheets << "search" if params[:controller]=="search"
    stylesheet_link_tag stylesheets, :media => "all", :concat => stylesheet_name?(stylesheets), :cache => true
  end
  
  def stylesheet_name?(stylesheets)
    names = ['global']
    names << "search" if params[:controller]=="search"
    "cache/#{names.join('_')}"
  end
  
  def is_admin?
    false
  end
  
end
