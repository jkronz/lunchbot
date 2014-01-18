json.array!(@restaurants) do |restaurant|
  json.extract! restaurant, :id, :name, :twitter
  json.url restaurant_url(restaurant, format: :json)
end
