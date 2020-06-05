module QcloudDns
  class RecordService
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def create(params={})
      client.perform params.merge(Action: "RecordCreate")
    end
  end
end
