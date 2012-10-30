resources :timesheet, only: [:index] do
  collection do
    match  'report'
    delete 'reset'
    get    'context_menu'
  end
end