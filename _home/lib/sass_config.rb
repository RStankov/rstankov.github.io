Sass::Engine::DEFAULT_OPTIONS[:load_paths].tap do |load_paths|
  load_paths << "#{ROOT_PATH}/assets/stylesheets"
  load_paths << "#{Gem.loaded_specs['compass'].full_gem_path}/frameworks/compass/stylesheets"
end

Compass.configuration.fonts_path = "#{ROOT_PATH}/assets/fonts"
Compass.configuration.fonts_dir = "assets/"
