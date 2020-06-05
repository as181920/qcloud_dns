module QcloudDns
  class RecordService
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def create(params={})
      client.perform(domain: "")
    end
  end
end
