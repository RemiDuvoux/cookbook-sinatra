class Marmiton
  def search(keyword)
    imported_recipes = []
    html_file = open("http://www.marmiton.org/recettes/recherche.aspx?aqt=#{keyword}")
    html_doc = Nokogiri::HTML(html_file)
    html_doc.search('.m_contenu_resultat').each do |node|
      name = node.search('.m_titre_resultat > a').text
      description = node.search('.m_detail_recette').text
      difficulty = node.search('.m_detail_recette').text.split(" - ")[2]
      if node.search('.m_detail_time > div').count == 2
        cooking_time = node.search('.m_detail_time > div').last.text
      end
      if name != ""
        imported_recipes << Recipe.new(name, description, cooking_time, false,difficulty)
      end
    end
    imported_recipes
  end
end
