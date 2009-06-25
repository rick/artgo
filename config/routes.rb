ActionController::Routing::Routes.draw do |map|
  map.connect 'bingo/:id', :controller => 'bingo', :action => 'index'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
