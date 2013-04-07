class Server
  def initialize(path)
    @builder = Rack::Builder.new do
      use Rack::CommonLogger

      map('/assets') { run AssetPipeline.new(path) }
      map('/')       { run SlimTemplate.new(path)  }
    end
  end

  def start(port = 3000)
    server = Rack::Handler::WEBrick

    trap(:INT) do
      if server.respond_to?(:shutdown)
        server.shutdown
      else
        exit
      end
    end

    server.run @builder, :Port => port
  end
end
