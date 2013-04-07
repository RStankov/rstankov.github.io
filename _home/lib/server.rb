module Server
  def self.start(port = 3000)
    builder = Rack::Builder.new do
      use Rack::CommonLogger
    end

    yield builder

    server = Rack::Handler::WEBrick

    trap(:INT) do
      if server.respond_to?(:shutdown)
        server.shutdown
      else
        exit
      end
    end

    server.run builder, :Port => port
  end
end
