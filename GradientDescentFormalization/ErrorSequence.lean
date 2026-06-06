import Mathlib
import GradientDescentFormalization.Basics

/-! # Gradient Descent Formalization - Error Sequence
In this file I am defining
- the error sequence
Then I am proving
- that the error sequence has initial value of x0 - c
- that the error sequence follows the structure of a geometric sequence
- the error sequence has a closed form
- that each successive error is not larger than the previous one -/

namespace GradientDescentFormalization

/- Here I am using errorSequence to measure the error 'e_n'
of the nth gradient descent iteration, 'x_n' from the minimizing
value of c. It does so by measuring how far the current
iterate is from the target point of x=c. If this error tends to
zero then the sequence of these iterations converges to zero.-/
def errorSequence (α c x0 : ℝ) (n : ℕ) :=
  gdSequence α c x0 n - c

/- The initial value for the error is the difference
between 'x0' and the minimizing value of 'c'. This is
proven using the fact that the zeroth term of the gradient
descent sequence is x0-/
lemma errorSequence_zero (α c x0 : ℝ) :
  errorSequence α c x0 0 = x0 - c := by rfl

/- Each gradient descent step multiplies the current steps
error by a factor of '1 - 2 * α.'
In this lemma I am rewriting the recirsive gradient descent
update using the error from the minimizer, which effectively
shows that the error sequence follows the well-known structure
of a geometric sequence. -/
lemma errorSequence_succ (α c x0 : ℝ) (n : ℕ) :
  errorSequence α c x0 (n + 1) = (1 - 2 * α) * errorSequence α c x0 n := by
  simp [errorSequence, gdSequence_succ, gdStep]
  ring

/- Here I am showing that the error after n gradient descent steps
has a closed form. This form is e_n = (1 - 2 * α)^n * (x0 - c)
I have shown this through induction and the fact that each new step
multiplies the previous steps error by '1 - 2 * α' -/
lemma errorSequence_closed (α c x0 : ℝ) (n : ℕ) :
  errorSequence α c x0 n = (1 - 2 * α)^n * (x0 - c) := by
  induction n with
  | zero =>
    simp [errorSequence, gdSequence]
  | succ n ih =>
    calc
      errorSequence α c x0 (n + 1)
        = (1 - 2 * α) * errorSequence α c x0 n := by exact errorSequence_succ α c x0 n
       _ = (1 - 2 * α) * ((1 - 2 * α)^n * (x0 - c)) := by rw[ih]
       _ = (1 - 2 * α)^(n + 1) * (x0 - c) := by rw[pow_succ]; ring

/- Here I am showing that each successive error is not larger than the one
before it. I am essentially proving that |e_n+1| ≤ |e_n|, with e_n being
my predefined error sequence. I am also establishing 2 conditions hα_pos
(which implies a positive learning rate) and hα_step (which ensures the step
size is less than 1). These conditions ensure that |1 - 2 * α| remains less
than 1. -/
lemma errorSequence_mono (α c x0 : ℝ) (hα_pos : 0 < α) (hα_step : α < 1) (n : ℕ) :
  |errorSequence α c x0 (n + 1)| ≤ |errorSequence α c x0 n| := by
    have hcontract : |1 - 2 * α| < 1 := by rw[abs_lt]; constructor <;> linarith
    rw[errorSequence_succ, abs_mul]
    calc |1 - 2 * α| * |errorSequence α c x0 n|
      ≤ 1 * |errorSequence α c x0 n| :=
        mul_le_mul_of_nonneg_right (le_of_lt hcontract) (abs_nonneg _)
    _ = |errorSequence α c x0 n| := one_mul _

end GradientDescentFormalization
