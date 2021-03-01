module BimiParser
  class Parser < Parslet::Parser
    root :record

    rule :record do
      (
        bimi_version.as(:version) >>
        bimi_locations.as(:locations) >>
        bimi_authorities.maybe.as(:authorities)
      ).as(:record)
    end

    rule :bimi_version do
      str('v') >> separator >> match['[:alnum:]'].repeat.as(:v) >> delimiter
    end

    rule :bimi_locations do
      str('l') >> separator >> naive_uri.maybe.as(:l) >> delimiter?
    end

    rule :bimi_authorities do
      str('a') >> separator >> naive_uri.maybe.as(:a) >> delimiter?
    end

    # helpers
    rule(:naive_uri) { match['a-zA-Z0-9.:/_#?=\-'].repeat(1) }
    rule(:separator) { space? >> str('=') >> space? }
    rule(:delimiter) { space? >> str(';') >> space? }
    rule(:delimiter?) { delimiter.maybe }
    rule(:space?) { match[' \t'].maybe }
  end
end
