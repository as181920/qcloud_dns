require "test_helper"

class QcloudDnsTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::QcloudDns::VERSION
  end

  def test_modification_matches_record_type_even_when_another_type_is_first
    client = record_client([
      { "id" => "txt", "name" => "www", "type" => "TXT", "status" => "enabled" },
      { "id" => "disabled-a", "name" => "www", "type" => "A", "status" => "disabled" },
      { "id" => "other-a", "name" => "other", "type" => "A", "status" => "enabled" },
      { "id" => "wanted-a", "name" => "www", "type" => "A", "status" => "enabled" }
    ])

    QcloudDns::RecordService.new(client).modify(domain: "example.com", subDomain: "www", recordType: "A", value: "192.0.2.1")

    assert_equal "wanted-a", client.requests.last.fetch(:recordId)
    assert_equal({ domain: "example.com", subDomain: "www", Action: "RecordList" }, client.requests.first)
  end

  def test_an_explicit_record_id_does_not_require_a_list_request
    client = record_client([])
    QcloudDns::RecordService.new(client).modify(recordId: "explicit", recordType: "A", value: "192.0.2.1")

    assert_equal [{ recordId: "explicit", recordType: "A", value: "192.0.2.1", Action: "RecordModify" }], client.requests
  end

  def test_listing_preserves_explicit_pagination_and_filter_parameters
    client = record_client([])
    params = { domain: "example.com", subDomain: "www", recordType: "TXT", offset: 20, length: 10 }

    QcloudDns::RecordService.new(client).list(params)

    assert_equal params.merge(Action: "RecordList"), client.requests.last
    refute params.key?(:Action)
  end

  def test_an_unmatched_type_never_modifies_another_record
    client = record_client([{ "id" => "txt", "name" => "www", "type" => "TXT", "status" => "enabled" }])

    assert_raises(QcloudDns::Error) do
      QcloudDns::RecordService.new(client).modify(domain: "example.com", subDomain: "www", recordType: "A", value: "192.0.2.1")
    end

    assert_equal ["RecordList"], client.requests.map { |request| request.fetch(:Action) }
  end

  private

  def record_client(records)
    Struct.new(:requests, :records) do
      def perform(params)
        requests << params
        Struct.new(:body).new(JSON.generate("data" => { "records" => records }))
      end
    end.new([], records)
  end
end
