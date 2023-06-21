from cfractions import Fraction

memo = {}


def memorize(f):
    def helper(n, m, d):
        if (n, m, d) not in memo:
            memo[(n, m, d)] = f(n, m, d)
        return memo[(n, m, d)]
    print(memo)
    return helper


@memorize
def w(n, m, d):
    try:
        if m == 0:
            return 0
        if d == 0:
            if m > (n - m):
                return 1
            else:
                return Fraction((n - m), n) * w(n - 2, m, 0) + Fraction(m, n) * w(n - 2, m - 1, 0)
        if d == 1:
            # Если есть только доктор и несколько мафий
            if n - m - d == 0:
                return Fraction(m, n) * Fraction(1, n - 1) * w(n - 1, m - 1, 1) + \
                       Fraction(m, n) * Fraction(n - 2, n - 1) * w(n - 2, m - 1, 0) + \
                       Fraction(1, n) * w(n - 1, m, 0)
            # Если есть только один мирный житель
            if n - m - d == 1:
                return Fraction(m, n) * Fraction(1, n - 1) * w(n - 1, m - 1, 1) + \
                       Fraction(m, n) * Fraction(n - m - 1, n - m) * Fraction(n - 2, n - 1) * w(n - 2, m - 1, 1) + \
                       Fraction(m, n) * Fraction(1, n - m) * Fraction(n - 2, n - 1) * w(n - 2, m - 1, 0) + \
                       Fraction(1, n) * w(n - 2, m, 0) + \
                       Fraction(n - m - 1, n) * Fraction(1, n - 1) * w(n - 1, m, 1) + \
                       Fraction(n - m - 1, n) * Fraction(n - 2, n - 1) * w(n - 2, m, 0)
            # Если мирных жителей хотя бы двое
            else:
                return Fraction(m, n) * Fraction(1, n - 1) * w(n - 1, m - 1, 1) + \
                       Fraction(m, n) * Fraction(n - m - 1, n - m) * Fraction(n - 2, n - 1) * w(n - 2, m - 1, 1) + \
                       Fraction(m, n) * Fraction(1, n - m) * Fraction(n - 2, n - 1) * w(n - 2, m - 1, 0) + \
                       Fraction(1, n) * w(n - 2, m, 0) + \
                       Fraction(n - m - 1, n) * Fraction(1, n - 1) * w(n - 1, m, 1) + \
                       Fraction(n - m - 1, n) * Fraction(n - m - 2, n - m - 1) * Fraction(n - 2, n - 1) * w(n - 2, m, 1) + \
                       Fraction(n - m - 1, n) * Fraction(1, n - m - 1) * Fraction(n - 2, n - 1) * w(n - 2, m, 0)
        else:
            return "ERROR"
    except ZeroDivisionError:
        print(n, m, d, "division by zero")
        return 0