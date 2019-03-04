def str_destructive?(m)
  [
    "<<",
    "[]=",
    "clear",
    "concat",
    "force_encoding",
    "insert",
    "prepend",
    "replace",
    "setbyte",
  ].include?(m.to_s)
end
