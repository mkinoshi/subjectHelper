json.array!(@links) do |link|
  json.extract! link, :id, :title, :content, :category_id, :user_id
  json.url link_url(link, format: :json)
end
