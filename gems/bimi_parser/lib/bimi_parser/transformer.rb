module BimiParser
  class Transformer < Parslet::Transform
    rule(v: simple(:v)) { v.to_s }
    rule(l: simple(:l)) { URI.parse(l) if l }
    rule(a: simple(:a)) { URI.parse(a) if a }
    rule(record: subtree(:record)) do
      Struct.new("Record", :version, :locations, :authorities, keyword_init: true).
        new(record)
    end
  end
end
