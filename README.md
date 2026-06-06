# 157FinalProject

## Formalizing Gradient Descent in Lean

### Overview

This project is aimed at formalizing gradient descent for a quadratic function using Lean 4 and validates the results using computational experiments in Python.

To do this the convergence of gradient descent was studied for

$$
f(x) = (x-c)^2
$$

and then its iterates were shown to converge to the minimizer $$c$$ given a step size in the following range:

$$
0 < \alpha < 1
$$

This project successfully combines:
- Formal proof techniques in Lean
- Recursive definitions
- Induction
- Convergence relations
- Numerical Experiments in Python
- Visualization in Python

---

### Mathematical Background

Gradient Descent Updates:

$$
x_{n+1} = x_n - \alpha f'(x)
$$

For the function $$f(x) = (x-c)^2$$ we obtain

$$
x_{n+1} = x_n - 2\alpha(x_n - c)
$$

Defining the error gives us

$$
e_n = x_n - c
$$

Then for $$n+1$$ we can see that

$$
e_{n+1} = (1 - 2\alpha)e_n
$$

This results in:

$$
e_n = (1 - 2\alpha)^n(x_0 - c)
$$

Furthermore since we know $$|1 - 2\alpha| < 1$$ the error converges to zero and thus $$x_n$$ tends to $$c$$

---

# Repositiory Structure
```text
157FinalProject/
.
├── GradientDescentFormalization/
│   ├── Basics.lean
│   └── ErrorSequence.lean
│   └── Convergence.lean
│   └── Main.lean
├── Python/
│   └── GradientDescent.py
└── README.md
```
---

# Lean Files

## Basics.lean

Contains:
- definition of the quadratic function
- definition of the gradient descent update rule
- definition of the recursive gradient descent sequence

Main definitions:
```lean
quadratic
gdStep
gdSequence
```

--- 

## ErrorSequence.lean

Contains:
- definition of the error sequence
- proof of recursive error reduction
- closed form formula for error

The Main Results are:

$$
e_{n+1} = (1 - 2\alpha)e_n
$$

$$
e_n = (1 - 2\alpha)^n(x_0 - c)
$$

---

## Convergence.lean

Contains:
- the conditions required for geometric sequences to converge
- the final gradient descent convergence theorem

This effectively proves:

$$
x_n \to c
$$

---

# Running Lean

Build:

```bash
lake build
```

Build a specific file:

```bash
lake build GradientDescentFormalization.Basics
```

Open in VSCode:

```bash
code .
```

---

# Running Python

If python is installed run:

```bash
python3 Python/GradientDescent.py
```

If python is not installed it can be ran in Google Colab:
[Python Experiments](https://colab.research.google.com/drive/1La4otMWQJDwTL_Z36srPPA_sSvxumqVo?usp=sharing)

The generated plots are:
- the gradient descent sequence
- the error sequence
- $$f(x)$$ values

---

# Results

The Lean formalization proves

$$
0 < \alpha < 1
$$

which implies that

$$
x_n \to c
$$

The Python experiments confirm:
- convergence for step sizes within the range
- divergence for larger step sizes

---

# Future Extensions

Further work could include higher dimensional gradient descent, stochastic gradient descent, and adaptive step sizes.

---

## Author

Alexandra Margarita Drymioti

UC San Diego
Mathematics Major | Physics and Chemistry Minor



