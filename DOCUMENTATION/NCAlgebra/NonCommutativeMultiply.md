# NonCommutativeMultiply {#PackageNonCommutativeMultiply}

**NonCommutativeMultiply** is the main package that provides noncommutative functionality to Mathematica's native `NonCommutativeMultiply` bound to the operator `**`.

Members are:

* [aj](#aj)
* [co](#co)
* [Id](#Id)
* [inv](#inv)
* [tp](#tp)
* [rt](#rt)
* [CommutativeQ](#CommutativeQ)
* [NonCommutativeQ](#NonCommutativeQ)
* [SetCommutative](#SetCommutative)
* [SetNonCommutative](#SetNonCommutative)
* [Commutative](#Commutative)
* [CommuteEverything](#CommuteEverything)
* [BeginCommuteEverything](#BeginCommuteEverything)
* [EndCommuteEverything](#EndCommuteEverything)
* [ExpandNonCommutativeMultiply](#ExpandNonCommutativeMultiply)

## aj {#aj}

`aj[expr]` is the adjoint of expression `expr`. It is a conjugate linear involution.

See also:
[tp](#tp), [co](#co).

## co {#co}

`co[expr]` is the conjugate of expression `expr`. It is a linear involution.

See also:
[aj](#aj).

## Id {#Id}

`Id` is noncommutative multiplicative identity. Actually Id is now set equal `1`.

## inv {#inv}

`inv[expr]` is the 2-sided inverse of expression `expr`.

## rt {#rt}

`rt[expr]` is the root of expression `expr`.

## tp {#tp}

`tp[expr]` is the tranpose of expression `expr`. It is a linear involution.

See also:
[aj](#tp), [co](#co).

## CommutativeQ {#CommutativeQ}

`CommutativeQ[expr]` is *True* if expression `expr` is commutative (the default), and *False* if `expr` is noncommutative.

See also:
[SetCommutative](#SetCommutative), [SetNonCommutative](#SetNonCommutative).

## NonCommutativeQ {#NonCommutativeQ}

`NonCommutativeQ[expr]` is equal to `Not[CommutativeQ[expr]]`.

See also:
[CommutativeQ](#CommutativeQ).

## SetCommutative {#SetCommutative}

`SetCommutative[a,b,c,...]` sets all the *Symbols* `a`, `b`, `c`, ... to be commutative.

See also:
[SetNonCommutative](#SetNonCommutative), [CommutativeQ](#CommutativeQ), [NonCommutativeQ](#NonCommutativeQ).

## SetNonCommutative {#SetNonCommutative}

`SetNonCommutative[a,b,c,...]` sets all the *Symbols* `a`, `b`, `c`, ... to be noncommutative.

See also:
[SetCommutative](#SetCommutative), [CommutativeQ](#CommutativeQ), [NonCommutativeQ](#NonCommutativeQ).

## Commutative {#Commutative}

`Commutative[symbol]` is commutative even if `symbol` is noncommutative.

See also:
[CommuteEverything](#CommuteEverything), [CommutativeQ](#CommutativeQ), [SetCommutative](#SetCommutative), [SetNonCommutative](#SetNonCommutative).

## CommuteEverything {#CommuteEverything}

`CommuteEverything[expr]` is an alias for [BeginCommuteEverything](#BeginCommuteEverything).

See also:
[BeginCommuteEverything](#BeginCommuteEverything), [Commutative](#Commutative).

## BeginCommuteEverything {#BeginCommuteEverything}

`BeginCommuteEverything[expr]` sets all symbols appearing in `expr` as commutative so that the resulting expression contains only commutative products or inverses. It issues messages warning about which symbols have been affected.

`EndCommuteEverything[]` restores the symbols noncommutative behaviour.

`BeginCommuteEverything` answers the question *what does it sound like?*

See also:
[EndCommuteEverything](#EndCommuteEverythning), [Commutative](#Commutative).

## EndCommuteEverything {#EndCommuteEverything}

`EndCommuteEverything[expr]` restores noncommutative behaviour to symbols affected by `BeginCommuteEverything`.

See also:
[BeginCommuteEverything](#BeginCommuteEverythning), [Commutative](#Commutative).

## ExpandNonCommutativeMultiply {#ExpandNonCommutativeMultiply}

`ExpandNonCommutativeMultiply[expr]` expands out `**`s in `expr`.

For example

    ExpandNonCommutativeMultiply[a**(b+c)]

returns

    a**b+a**c.

Its aliases are `NCE`, and `NCExpand`.