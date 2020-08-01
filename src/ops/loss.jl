"""

    logp(x; dims=:)

Treat entries in `x` as as unnormalized log probabilities and return
normalized log probabilities.

`dims` is an optional argument, if not specified the normalization is
over the whole `x`, otherwise the normalization is performed over the
given dimensions.  In particular, if `x` is a matrix, `dims=1`
normalizes columns of `x` and `dims=2` normalizes rows of `x`.

"""
logp(x; dims=:) = generic_softmax(x,2,_logp; dims=dims)


# Math for the cross-entropy loss: x is unnormalized input, p is
# target probabilities, q is estimated probabilities. Read left column
# down, right column (loss gradients) back up.

# x			dx = -p + qz/z = -p + exp(logq)
# xmax  = max(x,1)	-sum(db)=0
# logqz = x .- xmax	-p + qz/z
# qz    = exp(logqz)	rep(1/z)
# z     = sum(qz,1)	1/z
# logz  = log(z)	sum(p)=1
# logq  = logqz.-logz	-p
# plogq = p .* logq	-1
# loss  = -sum(plogq)	1

# We keep the old implementation _logp for CPU arrays, slow cases and
# cases of d not handled by cudnn.
function _logp(x;dims=:,algo=2)
    xval = value(x)
    if isa(xval,Number)
        return zero(xval)
    elseif isempty(xval)
        return xval
    else
        x = x .- maximum(x,dims=dims)
        return (x .- log.(sum(exp.(x),dims=dims)))
        # Expanding for profiling:
        # x1 = maximum(x,d...)
        # x2 = x .- x1
        # x3 = exp.(x2)
        # x4 = sum(x3,d...)
        # x5 = log.(x4)
        # x6 = x2 .- x5
        # return x6
    end
end

function _logpback(x,y,dy;dims)
    xval = value(x)
    if isa(xval,Number)
        return zero(xval)
    elseif isempty(xval)
        return xval
    else
        return (dy - exp.(y).*sum(dy;dims=dims))
        # Expanding for profiling:
        # dx1 = sum(dy,d...)
        # dx2 = exp.(y)
        # dx3 = dx2 .* dx1
        # dx4 = dy - dx3
        # return dx4
    end
end

# dy should be -p and y=logq so this should give us -p+q
@primitive  _logp(x;dims=:,algo=2),dy,y  _logpback(x,y,dy,dims=dims)


"""

    softmax(x; dims=1, algo=1)

The softmax function typically used in classification.
Gives the same results as to `exp.(logp(x, dims))`. 

If `algo=1` computation is more accurate, if `algo=0` it is 
faster. 

See also `logsoftmax`.

"""
function softmax(x; dims=:, algo=1)
    generic_softmax(x, algo, _softmax; dims=dims)
end

function _softmax(x; dims=:, algo=1)
    @assert algo ∈ [0, 1]
    if algo == 1
        x = x .- maximum(x, dims=dims)
    end    
    x = exp.(x)
    return x ./ sum(x;dims=dims)
end

function _softback(x,y,dy;dims=:)
    return y .* dy .- y .* sum(y .* dy; dims=dims)
end

@primitive  _softmax(x;dims=:,algo=1),dy,y  _softback(x,y,dy,dims=dims)

"""
     logsoftmax(x; dims=:)

 Equivalent to `logp(x; dims=:)`. See also `sotfmax`. 
"""
const logsoftmax = logp

generic_softmax(x,algo::Int,fallback;dims=:) = fallback(x;dims=dims,algo=algo)


"""

    logsumexp(x;dims=:)

Compute `log(sum(exp(x);dims))` in a numerically stable manner.

`dims` is an optional argument, if not specified the summation is over
the whole `x`, otherwise the summation is performed over the given
dimensions.  In particular if `x` is a matrix, `dims=1` sums columns
of `x` and `dims=2` sums rows of `x`.

"""
function logsumexp(x;dims=:)
    xmax = maximum(x,dims=dims)
    xmax + log.(sum(exp.(x .- xmax),dims=dims))
end

@primitive logsumexp(x;dims=:),dy,y  (dy .* exp.(x .- y))


"""
    nll(scores, answers::Array{<:Integer}; dims=1, average=true)
    nll(model, data; dims=1, average=true, o...)

The first form calculates the negative log likelihood for a single batch given an
unnormalized `scores` matrix and an `Integer` array of correct `answers`. The `scores`
matrix should have size (classes,instances) if `dims=1` or (instances,classes) if
`dims=2`. `answers[i]` should be in `1:classes` to indicate the correct class for instance
i, or 0 to skip instance i.

The second form calculates negative log likelihood for a model and dataset iterating over
`nll(model(inputs; o...), answers; dims)` for `(inputs,answers)` in `data`. The `model`
should be a function returning scores given inputs, and data should be an iterable of
`(inputs,answers)` pairs.

In both forms, the return value is `(total/count)` if `average=true` and `(total,count)` if
`average=false` where `count` is the number of instances not skipped and `total` is their
total negative log likelihood.

## Example

Let's assume that there are three classes (cat, dog, ostrich) and just 2 instances with
the unnormalized score `scores[:,1]` and `scores[:,2]` respectively. The first instance
is actually a cat and the second instance a dog:

```julia
scores = [12.2    0.3;
           2.0   21.5;
           0.0  -21.0]
answers = [1, 2]
nll(scores,answers)
# returns 2.1657e-5
```

The probabilites are derived from the scores and the log-probabilities corresponding to the
answers are averaged:

```julia
probabilites = exp.(scores) ./ sum(exp.(scores),dims=1)
-(log(probabilites[answers[1],1]) + log(probabilites[answers[2],2]))/2
# returns 2.1657e-5
```
"""
function nll(y,a::AbstractArray{<:Integer}; dims=1, average=true)
    indices = findindices(y,a,dims=dims)
    lp = logp(y,dims=dims)[indices]
    average ? (-sum(lp) / length(lp)) : (-sum(lp), length(lp))
end

"""
    accuracy(scores, answers; dims=1, average=true)

Given an unnormalized `scores` matrix and an `Integer` array of correct `answers`, return
the ratio of instances where the correct answer has the maximum score. `dims=1` means
instances are in columns, `dims=2` means instances are in rows. Use `average=false` to
return the pair (ncorrect,count) instead of the ratio (ncorrect/count). If `answers[i] == 0`,
instance i is skipped.

"""
function accuracy(y,a::AbstractArray{<:Integer}; dims=1, average=true)
    indices = findindices(y,a,dims=dims)
    ycpu = convert(Array,y)
    (maxval,maxind) = findmax(ycpu,dims=dims)
    maxind = LinearIndices(ycpu)[maxind]
    maxind = vec(maxind)[vec(a) .!= 0]
    correct = (maxind .== indices)
    average ? (sum(correct) / length(correct)) : (sum(correct), length(correct))
end

function findindices(y,a::AbstractArray{<:Integer}; dims=1)
    ninstances = length(a)
    nindices = 0
    indices = Vector{Int}(undef,ninstances)
    if dims == 1                   # instances in first dimension
        y1 = size(y,1)
        y2 = div(length(y),y1)
        if ninstances != y2; throw(DimensionMismatch()); end
        @inbounds for j=1:ninstances
            if a[j] == 0; continue; end
            indices[nindices+=1] = (j-1)*y1 + a[j]
        end
    elseif dims == 2               # instances in last dimension
        y2 = size(y,ndims(y))
        y1 = div(length(y),y2)
        if ninstances != y1; throw(DimensionMismatch()); end
        @inbounds for j=1:ninstances
            if a[j] == 0; continue; end
            indices[nindices+=1] = (a[j]-1)*y1 + j
        end
    else
        error("findindices only supports dims = 1 or 2")
    end
    return (nindices == ninstances ? indices : view(indices,1:nindices))
end

"""
    logistic(scores, answers; average=true)
Computes logistic loss given scores(predicted values) and answer labels.
answer values should be {-1,1}, then it returns `mean|sum(log(1 + exp(-answers*scores)))`. See also `bce`.
"""
function logistic(x̂,x;average=true)
    ε = eltype(x̂)(1e-12)
    l = log.((1-ε) .+ exp.(-x .* x̂))
    average ? mean(l) : sum(l)
end

"""

    bce(scores,answers;average=true)

Computes binary cross entropy given scores(predicted values) and answer labels.
answer values should be {0,1}, then it returns negative of `mean|sum(answers * log(p) + (1-answers)*log(1-p))`
where `p` is equal to `1/(1 + exp.(scores))`. See also `logistic`.
"""
function bce(x̂,x;average=true) 
    ε = eltype(x̂)(1e-12)
    p = 1 ./ (1 .+ exp.(-x̂))
    l = x .* log.(p .+ ε) .+ (1 .- x).*log.((1-ε) .- p)
    average ? -mean(l) : -sum(l)
end

function nll(model, data; dims=1, average=true, o...)
    sum = cnt = 0
    for (x,y) in data
        (z,n) = nll(model(x; o...), y; dims=dims, average=false) 
        sum += z; cnt += n
    end
    average ? sum / cnt : (sum, cnt)
end


"""
    accuracy(model, data; dims=1, average=true, o...)

Compute `accuracy(model(x; o...), y; dims)` for `(x,y)` in `data` and return (correct/total)
if average=true or (correct,total) if average=false.

"""
function accuracy(model, data; dims=1, average=true, o...)
    sum = cnt = 0
    for (x,y) in data
        (z,n) = accuracy(model(x; o...), y; dims=dims, average=false)
        sum += z
        cnt += n
    end
    average ? sum / cnt : (sum, cnt)
end

"zeroone loss is equal to 1 - accuracy"
zeroone(x...; o...) = 1 - accuracy(x...; o...)

# We need the (model,x,y) interface to implement regularization:
nll(f, x, y; dims=1, average=true, o...)=nll(f(x; o...), y; dims=dims, average=average)
accuracy(f, x, y; dims=1, average=true, o...)=accuracy(f(x; o...), y; dims=dims, average=average)

# We need the (weights,data,predict) interface to support the old interface:
nll(w, data, f::Function; dims=1, average=true, o...)=nll(x->f(w,x;o...), data; dims=dims, average=average)
accuracy(w, data, f::Function; dims=1, average=true, o...)=accuracy(x->f(w,x;o...), data; dims=dims, average=average)

# TODO: analyze and filter all these nll/accuracy methods, not all are necessary and we risk ambiguity.
