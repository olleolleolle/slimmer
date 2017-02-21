require 'json'

module Slimmer
  class I18nBackend
    include I18n::Backend::Base, I18n::Backend::Flatten

    def available_locales
      Slimmer.cache.fetch(template_path, expires_in: Slimmer::CACHE_TTL) do
        locale_json = fetch(static_locales_url)
        locales = JSON.parse(locale_json).map(&:to_sym)
      end
    end

    def lookup(locale, key, scope = [], options = {})
      key = normalize_flat_keys(locale, key, scope, options[:separator])
      translations = translations(locale)
      translations["#{locale}.#{key}".to_sym]
    end

  private

    def translations(locale)
      Slimmer.cache.fetch("translations/#{locale}", expires_in: Slimmer::CACHE_TTL) do
        fetch_translations(locale)
      end
    end

    def static_locales_url(locale=nil)
      [static_host, "templates", "locales", locale].compact.join('/')
    end

    def static_host
      @static_host ||= Plek.new.find('static')
    end

    def fetch_translations(locale)
      url = static_locales_url(locale)
      json_data = fetch(url)
      translations = JSON.parse(json_data)
      flatten_translations(locale, translations, false, false)
    rescue TemplateNotFoundException
      {}
    end

    def fetch(url)
      HTTPClient.get(url)
    rescue RestClient::Exception => e
      raise TemplateNotFoundException, "Unable to fetch: '#{url}' because #{e}", caller
    rescue Errno::ECONNREFUSED => e
      raise CouldNotRetrieveTemplate, "Unable to fetch: '#{url}' because #{e}", caller
    rescue SocketError => e
      raise CouldNotRetrieveTemplate, "Unable to fetch: '#{url}' because #{e}", caller
    end
  end
end
