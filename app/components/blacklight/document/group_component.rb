# frozen_string_literal: true

module Blacklight
  module Document
    # Render the 'more like this' results from the response
    class GroupComponent < ::ViewComponent::Base
      with_collection_parameter :group

      # @param [Blacklight::Solr::Response::Group] group
      # @param [Integer] group_limit
      def initialize(group:, group_limit: -1)
        @group = group
        @group_limit = group_limit
      end

      def grouped_documents
        helpers.render_document_index @group.docs
      end

      def add_group_facet_params_and_redirect(group)
        Deprecation.silence(Blacklight::UrlHelperBehavior) do
          helpers.search_action_path(helpers.add_group_facet_params_and_redirect(group))
        end
      end
    end
  end
end
