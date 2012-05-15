require 'rql'
require 'rack/request'

module Rack
  class RqlQuery
    def initialize(app, js_runtime=nil)
      @app = app
    end

    def call(env)
      req = Rack::Request.new(env)
      #strip any API key so that the query will parse correctly
      qs = req.query_string.split('&').select{|q| !(q =~ /api_key/) }.join('&')
      unless qs.empty?
        begin
          env['rql.query'] = Rql[qs]
        rescue => e
          env['rql.error'] = e
        end
      end
      
      @app.call(env)
    end
  end
end
