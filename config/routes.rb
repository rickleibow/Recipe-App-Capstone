Rails.application.routes.draw do 
  devise_for :users
  devise_scope :user do
    authenticated :user do
      root 'foods#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  
  resources :foods
  resources :general_shopping_list, only: [:index, :update]
  put 'ingredients/:id', as: 'recipe_food_update', action: :update_two, controller: 'foods'
  resources :recipes do
    resources :recipe_foods do
    end
  end
  get 'public_recipes', action: :show_public, controller: :recipes

  get 'recipes/:id/ingredient/new', as: 'recipes_new_ingredient', action: :edit_two, controller: :recipes
  post 'recipes/:recipe_id/ingredients', as: 'recipes_create_ingredient', action: :update_two, controller: :recipes

  root "foods#index"
end
