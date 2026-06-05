import Mathlib.Topology.Basic
import Mathlib.Order.Filter.Basic
import GradientDescentFormalization.Basics
import GradientDescentFormalization.ErrorSequence

set_option linter.style.whitespace false

open Filter
open Topology

namespace GradientDescentFormalization

/- This lemma proves the contraction condition that is needed
for gradient descent. I am essentially showing that is the step
size α is between 0 and 1 then (1-2α) has an absolite value of
less than 1. This is what ensures the convergence of the error
sequence. I am using linarith to solve the inequalities using
the conditions I set. -/
lemma stepSize_Contraction (α : ℝ) (hα_pos : 0 < α) (hα_step : α < 1) : |1 - 2 * α| < 1 := by
  rw[abs_lt]
  constructor <;> linarith

/- This lemma focuses on proving the opposite, which is that if
α ≥ 1 then we have |1-2α| ≥ 1. This means that the more iterations
there are the error does not shrink and as such the sequence may
diverge. -/
lemma stepsize_nContraction (α : ℝ) (hα : α ≥ 1) : |1 - 2 * α| ≥ 1 := by
  have h : 1 - 2 * α ≤ -1 := by linarith
  have h2 : -(1 - 2 * α) ≤ |1 - 2 * α|  := by exact neg_le_abs (1 - 2 * α)
  linarith

/- This lemma proves that a geometric sequence converges to zero if
|r| < 1. In mathematical terms r^n → 0 if |r| < 1. Instead of doing
this using real analysis from first principles I used a prexisting
Mathlib theorem tendsto_pow_atTop_nhds_zero_of_lt_one which applies
in our case as 0 ≤ r < 1. -/
lemma geometricSequence_tozero (r : ℝ) (hr : |r| < 1) :
  Tendsto (fun n : ℕ => r^n) atTop (nhds 0) := by
  have key : Tendsto (fun n : ℕ => |r|^n) atTop (nhds 0) :=
    tendsto_pow_atTop_nhds_zero_of_lt_one (abs_nonneg r) hr
  simpa [abs_pow] using key.abs

/- This theorem proves that the error sequence will converge to zero if
|1 - 2α| < 1. This means that the distance inbetween the gradient descent
iterate and the minimzing value of c goes to 0. This was done by first
showing that the factor or (1 - 2α)^n tends to zero as n get larger.
Secondly we know that x0 - c is constant in n, meaning it converges to
x0 - c. Thus, their product coverges to 0. -/
theorem errorSequence_tozero
  (α c x0 : ℝ) (hα : |1 - 2 * α| < 1) :
  Tendsto (fun n : ℕ => errorSequence α c x0 n) atTop (nhds 0) := by
 have hgeometric :
  Tendsto (fun n : ℕ => (1 - 2 * α)^n) atTop (nhds 0) :=
  geometricSequence_tozero (1 - 2 * α) hα
 have hconstant :
  Tendsto (fun n : ℕ => x0 - c) atTop (nhds (x0 - c)) :=
  tendsto_const_nhds
 have hmul :
  Tendsto (fun n : ℕ => (1 - 2 * α)^n * (x0 - c)) atTop (nhds (0 * (x0 - c))) :=
  hgeometric.mul hconstant
 simpa [errorSequence_closed] using hmul

/- This theorem proves that the gradient descent sequence defined in Basics.lean
coverges to the minimzing value c. I already showed that the errorSequence
converges to zero, and we know that errorSequence α c x0 n = gdSequence α c x0 n - c.
Thus, proving that the error sequence tends to zero is the same as showing that
gdSequence α c x0 n → c. I first used the above theorem to show that the error sequence
converges to zero and then showed that the constant sequence converges t0 c. Combining
the two I was able to show that gdSequence coverges to the minimizing value of c.-/
theorem gdSequence_tominimizer
  (α c x0 : ℝ) (hα : |1 - 2 * α| < 1) :
  Tendsto (fun n : ℕ => gdSequence α c x0 n) atTop (nhds c) := by
 have herror :
  Tendsto (fun n : ℕ => errorSequence α c x0 n) atTop (nhds 0) :=
  errorSequence_tozero α c x0 hα
 have hconstant :
  Tendsto (fun n : ℕ => c) atTop (nhds c) := tendsto_const_nhds
 have hsum :
  Tendsto (fun n : ℕ => errorSequence α c x0 n + c) atTop (nhds (0 + c)) :=
  herror.add hconstant
 simpa [errorSequence] using hsum

/- This theorem provides the desired covergence result by directly using the step size
assumption. Instead of using |1 - 2α| < 1, I assumed that 0 < α < 1, and used the theorems
above (gdSequence_tominimizer and stepSize_contraction). -/
theorem gdSequence_tominimizer' (α c x0 : ℝ) (hα_pos : 0 < α) (hα_step : α < 1) :
  Tendsto (fun n : ℕ => gdSequence α c x0 n) atTop (nhds c) :=
  gdSequence_tominimizer α c x0 (stepSize_Contraction α hα_pos hα_step)

end GradientDescentFormalization
