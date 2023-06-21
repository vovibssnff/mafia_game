import os
import sys

from PyQt5 import QtQml, QtCore
from PyQt5.QtCore import QUrl, pyqtSlot, Qt, pyqtProperty
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtCore import QObject, pyqtSignal

from pyqt5_qtquick2_example.core import launcher
from pyqt5_qtquick2_example.handlers import handlers
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQml import QQmlApplicationEngine



# def handle_spinBox1_value_changed(value):
#     print("SpinBox1 value changed:", value)
#
# def handle_spinBox2_value_changed(value):
#     print("SpinBox2 value changed:", value)


# print(launcher.calculate(10, 2, 1))

class frontend_handler(QObject):
    spinBox1ValueChanged = pyqtSignal(int)
    spinBox2ValueChanged = pyqtSignal(int)
    switchValueChanged = pyqtSignal(int)
    startButtonClicked = pyqtSignal()
    updateOutput = pyqtSignal()
    out_text = ""
    n = 50
    m = 1
    d = 0

    # @pyqtProperty("QVariantMap", notify=dataChanged)
    # def out_text(self) -> dict:
    #     return self._data

    @pyqtProperty(str, notify=updateOutput)
    def output(self) -> str:
        print(self.out_text)
        # print("shit shit shit")
        return self.out_text

    # Текстовое поле
    @pyqtSlot()
    def on_start_clicked(self):
        # Emit the signal with the new data
        frontend_handler.out_text = launcher.calculate(frontend_handler.n, frontend_handler.m, frontend_handler.d)
        # print(frontend_handler.out_text)
        self.updateOutput.emit()

    # 1-й слайдер
    @pyqtSlot(int)
    def on_n_spinbox_update(self, value):
        print("n" + str(value))
        frontend_handler.n = value
        self.spinBox1ValueChanged.emit(value)

    # 2-й слайдер
    @pyqtSlot(int)
    def on_m_spinbox_update(self, value):
        print("m" + str(value))
        frontend_handler.m = value
        self.spinBox2ValueChanged.emit(value)

    # переклюк
    @pyqtSlot(bool)
    def on_d_switch_update(self, state):
        value = 1 if state else 0
        frontend_handler.d = value
        print(frontend_handler.d)
        self.switchValueChanged.emit(value)



    # @pyqtSlot()
    # def handleStartButtonClicked(self):
    #     text_handler.print_text("hi cutie")
    #     self.startButtonClicked.emit()

os.environ['QT_QUICK_CONTROLS_STYLE'] = "Material"

app = QApplication([])
engine = QQmlApplicationEngine()

frontend_handler = frontend_handler()

engine.rootContext().setContextProperty("frontend_handler", frontend_handler)

engine.load("/home/vovi/PycharmProjects/pyqt5-qtquick2-example-master/pyqt5-qtquick2-example-master/pyqt5_qtquick2_example/qml/main.qml")

app.exec_()

#from matplotlib_backend_qtquick.backend_qtquickagg import FigureCanvasQtQuickAgg

# os.environ['QT_QUICK_CONTROLS_STYLE'] = "Material"
#
# #QtQml.qmlRegisterType(FigureCanvasQtQuickAgg, "Backend", 1, 0, "FigureCanvas")
#
# app = QApplication(sys.argv)
#
# engine = QQmlApplicationEngine()
#
# engine.load(QUrl.fromLocalFile('/home/vovi/PycharmProjects/pyqt5-qtquick2-example-master/pyqt5-qtquick2-example-master/pyqt5_qtquick2_example/qml/main.qml'))
#
# #win = engine.rootObjects()[0]
# #igure_canvas = win.findChild(QtCore.QObject, "spectFigure")
# #figure = figure_canvas.figure
#
# if not engine.rootObjects():
#     sys.exit(-1)
#
# sys.exit(app.exec_())

# outputField = engine.rootObjects()[0].findChild(QObject, "outputField")

    # Handle SpinBox2 value change in Python

#Handlers for SpinBox signals
# spinBoxHandler.spinBox1ValueChanged.connect(handlers.handle_spinBox1_value_changed)
# spinBoxHandler.spinBox2ValueChanged.connect(handlers.handle_spinBox2_value_changed)
# spinBoxHandler.switchValueChanged.connect(handlers.handle_switch_value_changed)
# spinBoxHandler.startButtonClicked.connect(handlers.handle_start_button_clicked)

# spinBoxHandler.spinBox1ValueChanged.connect(handle_spinBox1_value_changed)
# spinBoxHandler.spinBox2ValueChanged.connect(handle_spinBox2_value_changed)

# def handle_start_button_clicked(output_text):
#     outputField.setProperty("text", output_text)
#     # Optionally, you can also scroll to the end of the TextArea
#     outputField.forceActiveFocus()
#     outputField.textCursor = Qt.textCursorAtEnd()
#     outputField.ensureCursorVisible()

