module QcloudDns
  class ApiClient
    API_URL = "https://cns.api.qcloud.com/v2/index.php"

    attr_reader :secret_id, :secret_key

    def initialize(secret_id, secret_key)
      @secret_id, @secret_key = secret_id, secret_key
    end


    def perform(params={})
      params.reverse_merge!( Timestamp: Time.now.to_i, Nonce: rand(100000..999999), SecretId: secret_id, SignatureMethod: "HmacSHA1" )
      QcloudDns.logger.info "reqt: #{params.to_query}"
      resp = Faraday.post API_URL, params.merge(Signature: sign(params))
      QcloudDns.logger.info "resp(#{resp.status}): #{resp.body.squish}"

      resp
    end

    private
      def sign(sign_params)
        sign_text = sign_params.to_query # sign_params.sort.map{ |k, v| "#{k}=#{v}" }.join("&")
        Base64.strict_encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new("sha1"), secret_key, "POST#{URI.parse(API_URL).host}#{URI.parse(API_URL).path}?#{sign_text}"))
      end
  end
end
