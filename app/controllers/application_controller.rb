# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  before_filter :set_base_header_info

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  def set_base_header_info
    @header = {}
    @header[:title] = []
    @header[:title] << SETTINGS[:site][:name]
    @header[:description] = SETTINGS[:site][:description]
    @header[:keywords] = SETTINGS[:site][:keywords]
  end

end