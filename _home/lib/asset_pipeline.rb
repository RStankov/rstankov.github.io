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

    assets_path = @root.join 'assets'
    Dir["#{assets_path}/**/*.*"].each do |bundle|
      find_asset(bundle).to_a.each do |asset|
        dirname  = compile_dir.join asset.pathname.dirname.to_s.gsub("#{assets_path}/", '')
        basename = asset.pathname.basename.to_s.split('.')[0..1].join('.')

        FileUtils.mkpath compile_dir.join(dirname)
        asset.write_to compile_dir.join(dirname, basename)
      end
    end
  end
end

