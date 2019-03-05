require "./dm_ary"
require "./dm_str"
require "./dm_hash"

def dest_methods(rec)
  a0 = rec.methods.map(&:to_s) - Object.new.methods.map(&:to_s)
  a0.reject{ |m|
    /[\!\?]/===m || /^each_/===m || /^to_/===m || a0.include?("#{m}\!")
  }.sort.map(&:to_sym)
end

def putfiles
  [
    [ "ary.rb", [] ],
    [ "str.rb", "" ],
    [ "hash.rb", {} ],
  ].each do |fn,rec|
    File.open( fn, "w" ) do |f|
      dms = dest_methods(rec)
      f.puts <<~SRC
        def destructive?(m)
          [
            #{
              dms.map{ |dm|
                %Q!"#{dm}"!
              }.join(",\n")
            }
          ].include?(m.to_s)
        end
      SRC
    end
  end
end

def show( table, methods )
  puts( "|method|"+table.keys.map{ |e| e+"|" }.join )
  puts( "|:--|"+table.keys.map{ |e| ":--:|" }.join )
  v=table.values
  methods.each do |m|
    puts( "|`"+m.to_s+"`|"+v.map{ |x| x.include?(m) ? "✅|" : "-|" }.join )
  end
end

def list
  table=[
    [ "Array", [], :ary_destructive? ],
    [ "Hash", {}, :hash_destructive? ],
    [ "String", "", :str_destructive? ],
  ].each.with_object({}) do |(name,rec,method), o|
    m=dest_methods(rec).select{ |m|
      send(method,m)
    }
    o[name]=m
  end
  methods = table.values.flatten.uniq.sort
  p methods
  show( table, methods )
end

list

