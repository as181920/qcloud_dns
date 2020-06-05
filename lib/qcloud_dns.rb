require "base64"
require "openssl"
require "faraday"
require "active_support/all"
require "qcloud_dns/version"
require "qcloud_dns/api_client"
require "qcloud_dns/domain_service"
require "qcloud_dns/record_service"

module QcloudDns
  class Error < StandardError; end

  def self.logger
    @logger ||= defined?(Rails) ? Rails.logger : Logger.new(STDOUT)
  end
end
