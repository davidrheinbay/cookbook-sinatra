require 'open-uri'
require 'nokogiri'
require 'byebug'

class RecipeScraper
  attr_reader :prep_time
  def scrape_search(ingredient, difficulty = nil)
    url = "http://www.letscookfrench.com/recipes/find-recipe.aspx?aqt=#{ingredient}"
    url = url + "&dif=#{difficulty}" unless difficulty.empty?
    html_doc = Nokogiri::HTML(open(url).read)
    @links = html_doc.search('.m_titre_resultat a').map do |element|
      element.attribute('href').value.strip
    end.take(5)

    html_doc.search('.m_titre_resultat a').map do |element|
      element.attribute('title').value.strip
    end.take(5)
  end

  def scrape_description(import_index)
    recipe_url = "http://www.letscookfrench.com#{@links[import_index]}"
    html_doc = Nokogiri::HTML(open(recipe_url).read)

    @prep_time = html_doc.search('.preptime').map do |element|
      element.text.strip
    end.take(5)

    # @prep_time = html_doc.search('.').map do |element|
    #   element.text.strip
    # end.take(5)

    html_doc.search('.m_content_recette_todo').map do |element|
      element.text.strip
    end
  end
end
