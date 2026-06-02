import Mathlib

set_option linter.style.header false
set_option linter.style.whitespace false

namespace GradientDescentFormalization

def quadratic (c x : ℝ) : ℝ :=
    (x - c)^2

def gdStep (α c x : ℝ) : ℝ :=
    x - 2 * α * (x - c)

def gdSequence (α c x0 : ℝ) : ℕ → ℝ
    | 0 => x0
    | n + 1 => gdStep α c (gdSequence α c x0 n)

lemma gdSequence_zero (α c x0 : ℝ) :
    gdSequence α c x0 0 = x0 := by rfl

lemma gdSequence_succ (α c x0 : ℝ) (n : ℕ) :
    gdSequence α c x0 (n + 1) = gdStep α c (gdSequence α c x0 n) := by rfl

end GradientDescentFormalization
