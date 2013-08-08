JobVacancy::App.controllers :health do
  
  get :index do
    ping = Ping.create(:description => 'health-controller')
    ping.nil?? 500 : 'ok'
  end

  get :stats do
    content_type:'json'
    { offers_count: JobOffer.count, users_count: User.count }.to_json
  end

end
