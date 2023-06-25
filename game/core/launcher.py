from game.core.function import w
from game.core import graphics
n_1 = []
m_1 = []
res_1 = []
n_2 = []
m_2 = []
res_2 = []
n_3 = []
m_3 = []
res_3 = []

def calculate(n, m, d):
    str_res = ""
    for i in range(2, n+1):
        for j in range(1, m+1):
            if (j<=i):
                answer = w(i, j, d)
                res = round(float(answer), 5)
                str_res += "n: " + str(i) + " m: " + str(j) + " chance: " + str(res) + "\n"
    # print(str_res)
    return str_res

def calculate_graphics_1(n, m):
    for i in range(2, n+1):
        for j in range(1, m+1):
            if j <= i:
                answer = w(i, j, 0)
                res = round(float(answer), 5)
                n_1.append(i)
                m_1.append(j)
                res_1.append(res)
    graphics.show_graphics_1(n_1, m_1, res_1)

def calculate_graphics_2(n, m):
    for i in range(2, n+1):
        for j in range(1, m+1):
            if j <= i:
                answer = w(i, j, 1)
                res = round(float(answer), 5)
                n_2.append(i)
                m_2.append(j)
                res_2.append(res)
    graphics.show_graphics_1(n_2, m_2, res_2)

def calculate_graphics_3():
