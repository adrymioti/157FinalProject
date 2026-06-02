import Mathlib


set_option linter.style.header false
set_option linter.style.whitespace false

namespace GradientDescentFormalization

/- Here I am defining the quadratic case of
gradient descent. The parameter 'c' is the
minimizing value of the function, while the
function as a whole represents the squared
distance from 'x' to 'c'. To minimize this
function I will be using gradient descent.-/
def quadratic (c x : ℝ) : ℝ :=
    (x - c)^2

/- Here gdStep performs a single gradient
descent update on the quadratic defined
above, with α representing the step size.
Using this def we are able to iterate from
the current point 'x' onwards.-/
def gdStep (α c x : ℝ) : ℝ :=
    x - 2 * α * (x - c)

/- Here I am defining the infinite sequence
that is generated when gradient descent is
repeatedly applied to my previously defined
quadratic. Its initial term is 'x0' and each
of the following terms can be found by applying
one more gradient descent step than the previous
term. -/
def gdSequence (α c x0 : ℝ) : ℕ → ℝ
    | 0 => x0
    | n + 1 => gdStep α c (gdSequence α c x0 n)

/- The zeroth term of the gradient descent sequence
is the same as the initial value obtained when
the sequence is initially defined.
This theorem using the recursive definition of
gdSequence at an index of 0. -/
lemma gdSequence_zero (α c x0 : ℝ) :
    gdSequence α c x0 0 = x0 := by rfl

/- The next term in the sequence can be obtained by
applying one gradient descet update to the preceding
term. Thus, this theorem uses the definition of a
recursive rule. The proof itself comes from this
definition. -/
lemma gdSequence_succ (α c x0 : ℝ) (n : ℕ) :
    gdSequence α c x0 (n + 1) = gdStep α c (gdSequence α c x0 n)
    := by rfl

end GradientDescentFormalization
