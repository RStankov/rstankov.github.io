class AssetPipeline < Sprockets::Environment
  def initialize(root_path)
    super(root_path)

    self.cache = false
    self.append_path 'assets/javascripts'
    self.append_path 'assets/stylesheets'
    self.append_path 'assets/fonts'
    self.append_path 'assets/images'
    self.append_path "#{Gem.loaded_specs['compass'].full_gem_path}/frameworks/compass/stylesheets"

    context_class.class_eval do
      def asset_path(path, options = {})
        "/assets/#{options[:type]}s/#{path}"
      end
    end
  end
end

