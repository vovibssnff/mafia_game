import os

from PyQt5.QtCore import QUrl, pyqtSlot, Qt, pyqtProperty
from PyQt5.QtCore import QObject, pyqtSignal
from game.core import launcher, graphics
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQml import QQmlApplicationEngine

class frontend_handler(QObject):
    spinBox1ValueChanged = pyqtSignal(int)
    spinBox2ValueChanged = pyqtSignal(int)
    switchValueChanged = pyqtSignal(int)
    startButtonClicked = pyqtSignal()
    updateOutput = pyqtSignal()
    updateImage = pyqtSignal()
    out_text = ""
    n = 50
    m = 1
    d = 0

    @pyqtProperty(str, notify=updateOutput)
    def output(self) -> str:
        print(self.out_text)
        return self.out_text

    # Текстовое поле
    @pyqtSlot()
    def on_start_clicked(self):
        launcher.calculate_graphics_1(self.n, self.m)
        launcher.calculate_graphics_2(self.n, self.m)
        launcher.calculate_graphics_3(self.n, self.m)
        self.out_text = launcher.calculate(self.n, self.m, self.d)
        self.updateOutput.emit()

    # 1-й слайдер
    @pyqtSlot(int)
    def on_n_spinbox_update(self, value):
        print("n" + str(value))
        self.n = value
        self.spinBox1ValueChanged.emit(value)

    # 2-й слайдер
    @pyqtSlot(int)
    def on_m_spinbox_update(self, value):
        print("m" + str(value))
        self.m = value
        self.spinBox2ValueChanged.emit(value)

    # переклюк
    @pyqtSlot(bool)
    def on_d_switch_update(self, state):
        value = 1 if state else 0
        self.d = value
        print(self.d)
        self.switchValueChanged.emit(value)


os.environ['QT_QUICK_CONTROLS_STYLE'] = "Material"

app = QApplication([])
engine = QQmlApplicationEngine()

frontend_handler = frontend_handler()

engine.rootContext().setContextProperty("frontend_handler", frontend_handler)

engine.load("game/qml/main.qml")

app.exec_()
