class SlimTemplate
  def initialize(root_path)
    @root  = root_path
    @trail = Hike::Trail.new root_path
    @trail.append_path 'views'
  end

  def call(env)
    template = find_template(env['REQUEST_PATH'])

    if template
      [200, {'Content-Type' => 'text/html'}, Tilt.new(template).render]
    else
      [404, {'Content-Type' => 'text/html'}, 'File not found']
    end
  end

  def compile_to(compile_dir)
    compile_dir = @root.join compile_dir

    Dir[@root.join('views').to_s + '/*.slim'].each do |file_path|
      template = Tilt.new file_path

      File.open compile_dir.join(template.name + '.html'), 'w+' do |file|
        file.write template.render
      end
    end
  end

  private

  def find_template(path)
    @trail.find "#{path == '/' ? 'index' : path}.slim"
  end
end

