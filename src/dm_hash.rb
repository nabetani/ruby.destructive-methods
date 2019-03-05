def hash_destructive?(m)
  [
    "[]=",
    "clear",
    "compare_by_identity",
    "default=",
    "default_proc=",
    "delete",
    "delete_if",
    "keep_if",
    "rehash",
    "replace",
    "shift",
    "store",
    "update",
  ].include?(m.to_s)
end
