class String
  def sanitize(options={})
    ActionController::Base.helpers.sanitize(self, options)
  end
  
  def strip_html
    self.gsub(/<\/?[^>]*>/, "")
  end
  
  def strip_double_spaces
    self.gsub("<p>&nbsp;</p>", "")
  end

  def truncate_words(length = 30, end_string = '&hellip;')
    words = self.split()
    words[0..(length-1)].join(' ') + (words.length > length ? end_string : '')
  end
  
  def strip_and_shorten(length = 30, end_string = '&hellip;')
    self.strip_html.truncate_words(length, end_string)
  end
  
  def simple_format(html_options={})
    ActionController::Base.helpers.simple_format(self, html_options={})
  end
end