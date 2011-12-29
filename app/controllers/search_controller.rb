class SearchController < ApplicationController
  
  require 'open-uri'
  require 'nokogiri'
  
  before_filter :set_search_term
  
  def index
  end
  
  def s
    
    @header[:title] << @base_search_term
    
    args = {}
    
    if true
      args[:q] = @search_term
      args[:version] = 2.2
      @page = params[:page] ? params[:page].to_i : 1

      if params[:page] && params[:page].to_i>1
        args[:start] = (params[:page].to_i-1)*PER_PAGE - 1
      else
        args[:start] = 0
      end
      args[:rows] = PER_PAGE
      args[:indent] = "on"
      args[:qf]="title^2 content"
    else
      args[:q]="{!boost b=$dateboost v=$qq defType=dismax}"
      args[:qq] = @search_term
      args[:version] = 2.2
      @page = params[:page] ? params[:page].to_i : 1

      if params[:page] && params[:page].to_i>1
        args[:start] = (params[:page].to_i-1)*PER_PAGE - 1
      else
        args[:start] = 0
      end
      args[:rows] = PER_PAGE
      args[:indent] = "on"
      args[:qf]="title^2 content"
      args[:dateboost]="recip(ms(NOW,publishedDate),3.16e-11,1,1)"
    end
    url = Net::HTTP.post_form(URI.parse(SETTINGS[:site][:solr_url]), args)
    docs = Nokogiri.XML(url.body)
    
    docs.xpath("//response/result").each do |doc|
      doc.each do |c|
        @number_of_results = c[1] if c[0]=="numFound"
      end
    end
    @number_of_pages = (@number_of_results.to_f/PER_PAGE).floor+1
    
    @options = Pagination.get_pagination_options(@page, @number_of_pages)
    @options[:link_base] = "/search/s/#{URI.encode(@base_search_term)}"
    
    @items = []
    docs.xpath("//response/result/doc").each do |doc|
      item = {}
      doc.children.each do |c| 
        item[:url] = c.content if c[:name] == "url"
        item[:title] = c.content if c[:name] == "title"
        item[:content] = c.content if c[:name] == "content"
      end
      @items << item
    end
    
    @items.compact!
  end
  
  protected
  
  def set_search_term
    @base_search_term = URI.decode(params[:q] || "")
    @search_term = @base_search_term.split(" ").join(" AND ")
  end
  
end
