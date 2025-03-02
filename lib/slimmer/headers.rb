module Slimmer
  # @api public
  module Headers
    # @private
    InvalidHeader = Class.new(RuntimeError)

    # @private
    HEADER_PREFIX = "X-Slimmer"

    # @private
    SLIMMER_HEADER_MAPPING = {
      application_name:     "Application-Name",
      format:               "Format",
      page_owner:           "Page-Owner",
      organisations:        "Organisations",
      world_locations:      "World-Locations",
      result_count:         "Result-Count",
      search_parameters:    "Search-Parameters",
      section:              "Section",
      skip:                 "Skip",
      template:             "Template",
      remove_search:        "Remove-Search",
    }

    # @private
    APPLICATION_NAME_HEADER = "#{HEADER_PREFIX}-#{SLIMMER_HEADER_MAPPING[:application_name]}"

    # @private
    FORMAT_HEADER = "#{HEADER_PREFIX}-#{SLIMMER_HEADER_MAPPING[:format]}"

    # @private
    ORGANISATIONS_HEADER = "#{HEADER_PREFIX}-#{SLIMMER_HEADER_MAPPING[:organisations]}"

    # @private
    WORLD_LOCATIONS_HEADER = "#{HEADER_PREFIX}-#{SLIMMER_HEADER_MAPPING[:world_locations]}"

    # @private
    PAGE_OWNER_HEADER = "#{HEADER_PREFIX}-#{SLIMMER_HEADER_MAPPING[:page_owner]}"

    # @private
    RESULT_COUNT_HEADER = "#{HEADER_PREFIX}-#{SLIMMER_HEADER_MAPPING[:result_count]}"

    # @private
    SEARCH_PATH_HEADER = "#{HEADER_PREFIX}-Search-Path"

    # @private
    SEARCH_PARAMETERS_HEADER = "#{HEADER_PREFIX}-#{SLIMMER_HEADER_MAPPING[:search_parameters]}"

    # @private
    SKIP_HEADER = "#{HEADER_PREFIX}-#{SLIMMER_HEADER_MAPPING[:skip]}"

    # @private
    TEMPLATE_HEADER = "#{HEADER_PREFIX}-#{SLIMMER_HEADER_MAPPING[:template]}"

    # @private
    REMOVE_SEARCH_HEADER = "#{HEADER_PREFIX}-#{SLIMMER_HEADER_MAPPING[:remove_search]}"

    # Set the "slimmer headers" to configure the page
    #
    # @param hash [Hash] the options
    # @option hash [String] application_name
    # @option hash [String] format
    # @option hash [String] organisations
    # @option hash [String] page_owner
    # @option hash [String] remove_search
    # @option hash [String] result_count
    # @option hash [String] search_parameters
    # @option hash [String] section
    # @option hash [String] skip
    # @option hash [String] template
    # @option hash [String] world_locations
    def set_slimmer_headers(hash)
      raise InvalidHeader if (hash.keys - SLIMMER_HEADER_MAPPING.keys).any?
      SLIMMER_HEADER_MAPPING.each do |hash_key, header_suffix|
        value = hash[hash_key]
        headers["#{HEADER_PREFIX}-#{header_suffix}"] = value.to_s if value
      end
    end
  end
end
