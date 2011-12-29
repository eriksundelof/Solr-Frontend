class Pagination
        
  DEFAULTS = {:total_nr_pages=>PER_PAGE, :total_pages_to_show=>5}

  def self.get_pagination_options(current_page, total_nr_pages, opt={})
  	options = {}
  	
  	#setup the basic variables
  	options[:total_nr_pages] = total_nr_pages ? total_nr_pages : DEFAULTS[:total_nr_pages]
  	options[:total_pages_to_show] = opt[:total_pages_to_show] ? opt[:total_pages_to_show] : DEFAULTS[:total_nr_pages]
  	options[:offset] = (options[:total_pages_to_show]/2).to_i
	
	  #set the current page
  	options[:current_page] = current_page || 1
  	
  	#set the start page for the pagination
  	options[:start_page] = options[:current_page] - options[:offset]
  	options[:start_page] = 1 if options[:start_page]<1
  	options[:end_page] = options[:start_page] + options[:total_pages_to_show]
  	
  	# special case when closing in on the last page
  	unless options[:end_page]<options[:total_nr_pages]
	    options[:start_page] = options[:total_nr_pages] - options[:total_pages_to_show] + 1
	    options[:start_page] = 1 if options[:start_page]<1
	    options[:end_page] = options[:total_nr_pages]
	  end
	  
  	#show prev/next links
  	options[:show_link] = {
  		:first_page => (options[:current_page]>1 ? true : false),
  		:last_page => (options[:current_page]<options[:total_nr_pages] ? true : false)
  	}
  	
  	#show ellipsis ?
  	options[:show_ellipsis] = {
  		:before => (options[:start_page]>1 ? true : false),
  		:after => (options[:end_page]<options[:total_nr_pages]) ? true : false
  	}
  	
    	#return the options
  	return options
  	
  end
  
  		 	  
end
