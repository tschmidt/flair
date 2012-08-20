Flair::Engine.routes.draw do
  
  root :to => 'styleguides#index'
  
  resources :styleguides, :only => [:index, :show]

end
