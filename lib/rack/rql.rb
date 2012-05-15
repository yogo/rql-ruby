require 'rql'
require 'rack/request'

module Rack
  class RqlQuery
    def initialize(app, js_runtime=nil)
      @app = app
    end

    def call(env)
      req = Rack::Request.new(env)
      qs = req.query_string

      unless qs.empty?
        begin
          #strip any API key so that the query will parse correctly
          env['rql.query'] = Rql[qs.gsub(/api_key=\w*&/,'')]
        rescue => e
          env['rql.error'] = e
        end
      end
      
      @app.call(env)
    end
  end
end
