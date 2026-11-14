# QcloudDns

腾讯云DNS解析DNSPOD

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'qcloud_dns', git: "git@github.com:as181920/qcloud_dns.git", branch: "master"
```

## Usage

```ruby
client = ApiClient.new(secret_id, secret_key)
QcloudDns::RecordService.new(QcloudDns::ApiClient.new('secret_id', 'secret_key')).create(domain: "example.com", subDomain: "sub", recordType: "CNAME", recordLine: "默认", value: "target.com")
```

`modify` accepts an explicit `recordId`. Without one, it selects an enabled record matching both `subDomain` and `recordType`; other record types with the same name are not modified. If no record matches, it raises `QcloudDns::Error` without sending a modification request.

## Development

Development uses Ruby 4.0.9. After checking out the repo, run `bin/setup` to install dependencies, then run:

```sh
bundle exec rake test
bundle exec bundle-audit check --update --database tmp/ruby-advisory-db
```

Tests use an in-memory client and never call the DNS provider. You can also run `bin/console` for an interactive prompt.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/qcloud_dns.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
