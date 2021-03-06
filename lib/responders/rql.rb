module Responders
  module RqlResponder
    def resource
      super_resource = super
      rql = request.env['rql.query']
      rql_error = request.env['rql.error']
      controller.logger.debug("RQL Query: #{rql.inspect}")
      controller.logger.debug("RQL Error: #{rql_error.inspect}")
      if(rql)
        begin
          rql.on(super_resource)
        end
      else
        super_resource
      end
    end
  end
end
