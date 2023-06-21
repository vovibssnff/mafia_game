import pyqt5_qtquick2_example.core.launcher

n = 50
m = 0
d = 0

def handle_spinBox1_value_changed(value):
    n = value
    print("SpinBox1 value changed:", n)

def handle_spinBox2_value_changed(value):
    m = value
    print("SpinBox2 value changed:", m)

def handle_switch_value_changed(value):
    d = value
    print("Switch value changed:", d)

def handle_start_button_clicked():
    return pyqt5_qtquick2_example.core.launcher.calculate(n, m, d)
    # Handle start button click in Python




