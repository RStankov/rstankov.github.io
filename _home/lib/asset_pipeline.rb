class AssetPipeline < Sprockets::Environment
  def initialize(root_path)
    super(root_path)

    @root = root_path

    self.cache = false
    self.append_path 'assets'
    self.append_path "#{Gem.loaded_specs['compass'].full_gem_path}/frameworks/compass/stylesheets"

    context_class.class_eval do
      def asset_path(path, options = {})
        "/assets/#{options[:type]}s/#{path}"
      end
    end
  end

  def compile_to(compile_dir)
    compile_dir = @root.join compile_dir

    FileUtils.rm_rf compile_dir

    Dir[@root.join('assets').to_s + '/**/*.*'].each do |bundle|
      assets = find_asset bundle

      prefix, basename = assets.pathname.to_s.split('/')[-2..-1]
      FileUtils.mkpath compile_dir.join(prefix)

      assets.to_a.each do |asset|
        real_name = asset.pathname.basename.to_s.split(".")[0..1].join(".")
        asset.write_to compile_dir.join(prefix, real_name)
      end
    end
  end
end

