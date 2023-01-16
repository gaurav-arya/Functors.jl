# fmap(walk::AbstractWalk, f, x, ys...) = walk(x, ys...)

function fmap(f, x, ys...; exclude = isleaf,
                           walk = DefaultWalk(),
                           cache = IdDict(),
                           prune = NoKeyword())
  _walk = ExcludeWalk(walk, f, exclude)
  if !isnothing(cache)
    _walk = CachedWalk(_walk, prune, cache)
  end
  _walk(x, ys...)
  # fmap(_walk, f, x, ys...)
end

fmapstructure(f, x; kwargs...) = fmap(f, x; walk = StructuralWalk(), kwargs...)

fcollect(x; exclude = v -> false) =
  fmap(ExcludeWalk(CollectWalk(), _ -> nothing, exclude), _ -> nothing, x)
