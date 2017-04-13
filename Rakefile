require 'rake/clean'
require 'aws-sdk'

CLEAN << 'build'

BUCKET_REGION = 'us-east-1'.freeze
BUCKET_NAME = 'www.randrpump.com'.freeze
BUILD_DIR = File.expand_path(File.join(File.dirname(__FILE__), 'build'))

desc 'Build the site with Middleman'
task :build do
  sh 'bundle exec middleman build --parallel'
end

desc 'Deploy the site to S3'
task deploy: [:clean, :build] do
  files = FileList.new(File.join(BUILD_DIR, '**', '*')) do |fl|
    fl.exclude { |f| File.directory? f }
  end

  s3 = Aws::S3::Resource.new(region: BUCKET_REGION)
  bucket = s3.bucket(BUCKET_NAME)

  files.each do |f|
    key = f.sub(BUILD_DIR, '').sub(%r{^/}, '')
    puts "Uploading #{f} => s3://#{BUCKET_NAME}/#{key}"
    obj = bucket.object(key)
    obj.upload_file(f)
  end
end

task default: :build
