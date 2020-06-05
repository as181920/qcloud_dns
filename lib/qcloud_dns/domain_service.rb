module QcloudDns
  class DomainService
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def create(params={})
      client.perform(Action: "DomainCreate", domain: params[:domain])
    end
  end
end
