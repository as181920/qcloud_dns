module QcloudDns
  class RecordService
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def create(params={})
      client.perform params.merge(Action: "RecordCreate")
    end

    def list(params={})
      client.perform params.merge(Action: "RecordList")
    end

    def modify(params={})
      if params[:recordId].present?
        client.perform params.merge(Action: "RecordModify")
      elsif params[:subDomain].present? && params[:recordType].present?
        record_id = JSON.load(list(params).body).dig("data", "records")&.detect{ |attrs| attrs["name"].eql?(params[:subDomain]) && attrs["type"].eql?(params[:recordType]) && attrs["status"].eql?("enabled") }&.dig("id")
        client.perform params.merge(Action: "RecordModify", recordId: record_id)
      else
        raise "params not valid!"
      end
    end
  end
end
