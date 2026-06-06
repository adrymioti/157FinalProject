import numpy as np
import matplotlib.pyplot as plt
from pathlib import Path

def quadratic(x, c):
    "Quadratic Function: f(x) = (x - c)^2 with minimum at x = c"
    return (x - c) ** 2

def gd_stepfunction(x, alpha, c):
    "One gradient descent step for f(x) = (x - c)^2"
    "Since f'(x) = 2(x - c) the update is: "
    "x_(n + 1) = x_n - 2 alpha (x_n - c)"
    return x - 2 * alpha * (x - c)

def gradientdescent(alpha, c, x0, steps):
    "Generates the gradient descent sequence"
    "with the following parameters:"
    "  - alpha: step size"
    "  - c: minimizer of f(x)"
    "  - x0: initial condition"
    "  - steps: number of iterations"
    "This returns a numpy array that conatins: "
    "   x_0, x_1, ... , x_steps"
    xs = [x0]

    for _ in range(steps):
        xs.append(gd_stepfunction(xs[-1], alpha, c))
    return np.array(xs)

def run_experiment(alpha, c=3.0, x0=10.0, steps=25):
    "Runs the Gradient Descent function and "
    "returns the iterations"
    xs = gradientdescent(alpha, c, x0, steps)
    ns = np.arange(len(xs))
    errors = xs - c
    fvalues = quadratic(xs, c)

    return ns, xs, errors, fvalues

def plottingsequence(alpha, c=3.0, x0=10.0, steps=25):
    "Plotting x_n over time"
    ns, xs, error, fvalues = run_experiment(alpha, c, x0, steps)
    Path("Python/plots").mkdir(parents=True, exist_ok=True)

    plt.figure()
    plt.plot(ns, xs, marker="o", label="x_n")
    plt.axhline(c, linestyle="-", label="minimizer c")
    plt.xlabel("Iteration n")
    plt.ylabel("x_n")
    plt.title(f"Gradient Descent Sequence, alpha = {alpha}")
    plt.savefig(f"Python/plots/sequence_alpha_{alpha}.png")
    plt.show()

def plottingerror(alpha, c=3.0, x0=10.0, steps=25):
    "Plotting |x_n - c| over time"
    ns, xs, error, fvalues = run_experiment(alpha, c, x0, steps)
    Path("Python/plots").mkdir(parents=True, exist_ok=True)

    plt.figure()
    plt.plot(ns, np.abs(error), marker="o", label="|x_n - c|")
    plt.xlabel("Iteration n")
    plt.ylabel("Absolute Error")
    plt.title(f"Error Decay, alpha = {alpha}")
    plt.savefig(f"Python/plots/error_alpha_{alpha}.png")
    plt.show()

def plottingfunctionvalues(alpha, c=3.0, x0=10.0, steps=25):
    "Plotting f(x) over time"
    ns, xs, error, fvalues = run_experiment(alpha, c, x0, steps)
    Path("Python/plots").mkdir(parents=True, exist_ok=True)

    plt.figure()
    plt.plot(ns, fvalues, marker="o", label="f(x_n)")
    plt.xlabel("Iteration n")
    plt.ylabel("f(x_n)")
    plt.title(f"Function Values, alpha = {alpha}")
    plt.savefig(f"Python/plots/function_alpha_{alpha}.png")
    plt.show()

if __name__ == "__main__":
    c = 3.0
    x0 = 10.0
    steps = 25

    convergent_alpha = [0.1, 0.7]

    divergent_alpha = [1.1]

    for alpha in convergent_alpha + divergent_alpha:
        plottingsequence(alpha, c, x0, steps)
        plottingerror(alpha, c, x0, steps)
        plottingfunctionvalues(alpha, c, x0, steps)


