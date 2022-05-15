json.extract! issue, :id, :summary, :body, :status, :reporter, :created_at, :updated_at
json.url issue_url(issue, format: :json)
