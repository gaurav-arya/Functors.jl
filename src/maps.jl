fmap(walk::AbstractWalk, f, x, ys...) = walk((xs...) -> fmap(walk, f, xs...), x, ys...)

function fmap(f, x, ys...; exclude = isleaf,
                           walk = DefaultWalk(),
                           cache = IdDict(),
                           prune = NoKeyword())
  _walk = CachedWalk(ExcludeWalk(AnonymousWalk(walk), f, exclude), prune, cache)
  fmap(_walk, f, x, ys...)
end

fmapstructure(f, x; kwargs...) = fmap(f, x; walk = StructuralWalk(), kwargs...)

fcollect(x; exclude = v -> false) =
  fmap(ExcludeWalk(CollectWalk(), _ -> nothing, exclude), _ -> nothing, x)
