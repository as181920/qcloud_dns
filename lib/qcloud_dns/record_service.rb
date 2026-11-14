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
        record_id = JSON.parse(list(params.slice(:domain, :subDomain)).body).dig("data", "records")&.detect do |attrs|
          attrs["name"].eql?(params[:subDomain]) && attrs["type"].eql?(params[:recordType]) && attrs["status"].eql?("enabled")
        end&.dig("id")
        raise QcloudDns::Error, "No enabled DNS record matches the requested name and type" unless record_id

        client.perform params.merge(Action: "RecordModify", recordId: record_id)
      else
        raise "params not valid!"
      end
    end
  end
end
