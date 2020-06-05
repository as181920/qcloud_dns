require_relative 'lib/qcloud_dns/version'

Gem::Specification.new do |spec|
  spec.name          = "qcloud_dns"
  spec.version       = QcloudDns::VERSION
  spec.authors       = ["Andersen Fan"]
  spec.email         = ["as181920@gmail.com"]

  spec.summary       = %q{qcloud dns api services}
  spec.description   = %q{manage domains and records}
  spec.homepage      = "https://github.com/as181920/qcloud_dns"
  spec.license       = "MIT"

  spec.metadata["allowed_push_host"] = ""

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/as181920/qcloud_dns"
  spec.metadata["changelog_uri"] = "https://github.com/as181920/qcloud_dns"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activesupport"
  spec.add_dependency "faraday"
end
