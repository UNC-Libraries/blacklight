# frozen_string_literal: true

module Blacklight
  class DocumentMetadataComponent < Blacklight::Component
    renders_many :fields, (lambda do |component: nil, **kwargs|
      component.new(**kwargs)
    end)
    with_collection_parameter :fields

    # @param fields [Enumerable<Blacklight::FieldPresenter>] Document field presenters
    def initialize(fields: [], show: false, view_type: nil)
      @fields = fields
      @show = show
      @view_type = view_type
    end

    def before_render
      return unless fields

      @fields.each do |field|
        with_field(component: field.component, field: field, show: @show, view_type: @view_type)
      end
    end

    def render?
      fields.present?
    end

    attr_reader :view_type
  end
end
