class CatFact
  def self.fact
    response = Typhoeus.get("http://catfacts-api.appspot.com/api/facts")
    JSON.parse(response.body)['facts'].first 			
  end
end
