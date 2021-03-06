Rails.application.routes.draw do
  match "/404" => "errors#error404", via: [ :get, :post, :patch, :delete ]

  get 'anunciante_contratos/index'

  get 'medio_contratos/index'

  get 'cobros/index'

  get 'pagos/index'

  get 'audiences/index'

  get 'anuncios/index'

  get 'anunciantes/index'

  get 'home/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  get 'contabilidad' => 'contabilidad#show'

  post 'delete' => 'application#delete_all'
  post 'reset' => 'application#reset_data'

  resources :medios, except: [:update, :edit] do
    member do
      post 'audiences/:audience_id', action: :associate_audience, as: :associate_audience
      delete 'audiences/:audience_id', action: :dissociate_audience, as: :dissociate_audience
    end

    resources :espacios, except: [:update, :edit]
    resources :contratos, controller: :medio_contratos, except: [:destroy, :update, :edit] do
        resources :pagos, only: :create
    end
  end

  resources :anunciantes, except: [:update, :edit] do
    member do
      post 'audiences/:audience_id', action: :associate_audience, as: :associate_audience
      delete 'audiences/:audience_id', action: :dissociate_audience, as: :dissociate_audience
    end

    resources :anuncios do
      member do
        post 'espacios/:espacio_id', action: :allocate_to, as: :allocate_to
        delete 'espacios/:espacio_id', action: :deallocate_from, as: :deallocate_from
      end
    end
    resources :contratos, controller: :anunciante_contratos, except: [:destroy, :update, :edit] do
        resources :cobros, only: :create
    end
  end

  resources :audiences, except: [:update, :edit]


  match '*unmatched_route', :to => 'application#raise_not_found!', :via => :all

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
