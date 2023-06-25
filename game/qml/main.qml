import QtQuick 2.13
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.4
import QtQuick.Controls.Universal 2.4
import QtCharts 2.2
//import QtQuick.Qt3D.Extras

ApplicationWindow {
    visible: true
    minimumHeight: 700
    minimumWidth: 1600
    Material.theme: Material.Dark

    Material.primary: Material.DarkPink
    Material.accent: Material.Pink

    menuBar: MenuBar {
        Menu {
            title: "&Помощь"
            Action {
                text: "&Инструкция по применению"

            }
        }
    }
    Pane {
        padding: 10
        anchors.fill: parent
        GridLayout {
            anchors.fill: parent
            flow: GridLayout.TopToBottom
            rows: 2
            CellBox {
                title: 'Параметры запуска'
                ColumnLayout {
                    anchors.fill: parent
                    SpinBox {
                        id: nSpinBox
                        value: 50
                        editable: true
                        Layout.fillWidth: true
                        onValueChanged: {
                            frontend_handler.on_n_spinbox_update(value)
                        }
                    }

                    SpinBox {
                        id: mSpinBox
                        value: Math.min(nSpinBox.value, mSpinBox.value)
                        editable: true
                        Layout.fillWidth: true
                        property int maxNSpinBoxValue: spinBox1.value
                        onValueChanged: {
                            frontend_handler.on_m_spinbox_update(value)
                        }
                    }

                    Switch {
                        id: switch1
                        Layout.alignment: Qt.AlignHCenter
                        onToggled: {
                            frontend_handler.on_d_switch_update(switch1.checked)
                        }
                    }
                }

                Connections {
                    target: nSpinBox
                    onValueChanged: {
                        mSpinBox.maxNSpinBoxValue = nSpinBox.value
                        if (mSpinBox.value > mSpinBox.maxNSpinBoxValue) {
                            mSpinBox.value = mSpinBox.maxNSpinBoxValue-1
                        }
                    }
                }
            }

            CellBox {
                title: 'Управление вычислениями'
                ColumnLayout {
                    anchors.fill: parent
                    DelayButton {
                        text: 'Сброс'
                        delay: 1000
                        Layout.fillWidth: true
                    }
                    Button {
                        text: "Пуск"
                        Layout.alignment: Qt.AlignHCenter
                        onClicked: {
                            frontend_handler.on_start_clicked()
                        }
                    }
                }
            }

        CellBox {
            Layout.rowSpan: 2; Layout.minimumWidth: 700
            title: 'Вывод данных'
            Layout.preferredWidth: parent.width * 0.5
            TabBar {
                id: bar
                width: parent.width
                TabButton { text: 'График без доктора' }
                TabButton { text: 'График с доктором' }
                TabButton { text: 'Разность значений' }
                TabButton { text: 'Трассировка' }
            }
            StackLayout {
                width: parent.width
                height: parent.height - y
                anchors.top: bar.bottom
                currentIndex: bar.currentIndex
                LargeChartView {
                    Rectangle {
                        width: 640
                        height: 480
                        Image {
                             source: "plot1.png"
                        }
                    }
                }
                LargeChartView {
                    Rectangle {
                        width: 640
                        height: 480
                        Image {
                             source: "plot2.png"
                        }
                    }
                }
                //TODO
                LargeChartView {
                    Rectangle {
                        width: 640
                        height: 480
                        Image {
                             source: "plot3.png"
                        }
                    }
                }
                CellBox {
                    ColumnLayout {
                        anchors.fill: parent

                        ScrollView {
                            id: scrollView
                            Layout.fillWidth: true
                            Layout.preferredHeight: parent.height
                            clip: true
                            ScrollBar.vertical.policy: ScrollBar.AlwaysOn
                            ScrollBar.vertical.implicitWidth: 20

                            TextArea {
                                id: outputField
                                width: ScrollView.width // Set explicit width
                                height: contentHeight
                                readOnly: true
                                wrapMode: TextArea.Wrap
                            }
                        }
                    }
                        }
                        Connections {
                            target: frontend_handler
                            function onUpdateOutput() {
                                var out = frontend_handler.output
                                outputField.text = out
                            }
                        }
                    }
            }
        }
    }
}