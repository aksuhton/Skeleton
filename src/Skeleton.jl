module Skeleton
##
using DrWatson
##
"""
    dummy_project_function(x, y) → z

Dummy function for illustration purposes.
Performs operation:

```math
z = x + y
```
"""
function dummy_project_function(x, y)
    return x + y
end
"""
    fakesim(x, y) → z

Fake simulation function for illustration purposes.
Performs operation:

```math
z = x + y
```
"""
function fakesim(a, b, v, method="linear")
    if method == "linear"
        r = @. a + b * v
    elseif method == "cubic"
        r = @. a * b * v^3
    end
    y = sqrt(b)
    return r, y
end
function makesim(d::Dict)
    @unpack a, b, v, method = d
    r, y = fakesim(a, b, v, method)
    fulld = copy(d)
    fulld["r"] = r
    fulld["y"] = y
    return fulld
end
##
export fakesim, makesim
##
end #module
