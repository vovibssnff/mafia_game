from pyqt5_qtquick2_example.core.function import w
n_1 = []
m_1 = []
res_1 = []

def calculate(n, m, d):
    str_res = ""
    for i in range(2, n+1):
        for j in range(1, m+1):
            if (j<=i):
                answer = w(i, j, d)
                res = round(float(answer), 5)
                n_1.append(i)
                m_1.append(j)
                res_1.append(res)
                str_res += "n: " + str(i) + " m: " + str(j) + " chance: " + str(res) + "\n"
    # print(str_res)
    return str_res
