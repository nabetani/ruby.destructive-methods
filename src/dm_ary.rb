def ary_destructive?(m)
  [
    "<<",
    "[]=",
    "append",
    "clear",
    "concat",
    "delete",
    "delete_at",
    "delete_if",
    "fill",
    "insert",
    "keep_if",
    "pop",
    "prepend",
    "push",
    "replace",
    "shift",
    "unshift",
  ].include?(m.to_s)
end
