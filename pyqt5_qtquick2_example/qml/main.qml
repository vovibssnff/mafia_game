import QtQuick 2.13
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.4
import QtQuick.Controls.Universal 2.4
import QtCharts 2.2

ApplicationWindow {
    visible: true
    minimumHeight: 700
    minimumWidth: 1600
    Material.theme: Material.Dark

    // Customize the colors of individual elements
    Material.primary: Material.DarkPink
    Material.accent: Material.Pink

    menuBar: MenuBar {
        Menu {
            title: "&Help"
            Action {
                text: "&About"

            }
        }
    }
    Drawer {
        id: sideNav
        width: 200
        height: parent.height
        ColumnLayout {
            width: parent.width
            Label {
                    text: 'Drawer'
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 20
                    Layout.fillWidth: true
            }
            Repeater {
                model: 5
                SideNavButton {
                    icon.source: '../images/baseline-category-24px.svg'
                    text: 'List ' + index
                    Layout.fillWidth: true
                }
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

//                        onmaxNSpinBoxValueChanged: {
//                            if (mSpinBox.value > maxNSpinBoxValue) {
//                                mSpinBox.value = maxNSpinBoxValue
//                            }
//                        }
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
//FigureCanvas {
//        id: mplView
//        objectName : "figure"
//        dpi_ratio: Screen.devicePixelRatio
//        anchors.fill: parent
//}

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
                        //onClicked: frontend_handler.on_start_clicked()
                    }
                }
            }

        CellBox {
            Layout.rowSpan: 2; Layout.minimumWidth: 700
            title: 'Вывод данных'
            Layout.preferredWidth: parent.width * 0.5 // Keep the ratio right!
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
                    // Define x-axis to be used with the series instead of default one
                    ValueAxis {
                        id: valueAxisAreaSeries
                        min: 2000
                        max: 2011
                        tickCount: 12
                        labelFormat: '%.0f'
                    }
                    AreaSeries {
                        name: 'The U.S.'
                        axisX: valueAxisAreaSeries
                        upperSeries: LineSeries {
                            XYPoint { x: 2000; y: 3 }
                            XYPoint { x: 2001; y: 2 }
                            XYPoint { x: 2002; y: 1 }
                            XYPoint { x: 2003; y: 2 }
                            XYPoint { x: 2004; y: 1 }
                            XYPoint { x: 2005; y: 1 }
                            XYPoint { x: 2006; y: 0 }
                            XYPoint { x: 2007; y: 3 }
                            XYPoint { x: 2008; y: 4 }
                            XYPoint { x: 2009; y: 1 }
                            XYPoint { x: 2010; y: 0 }
                            XYPoint { x: 2011; y: 1 }
                        }
                    }
                    AreaSeries {
                        name: 'Russian'
                        axisX: valueAxisAreaSeries
                        upperSeries: LineSeries {
                            XYPoint { x: 2000; y: 1 }
                            XYPoint { x: 2001; y: 1 }
                            XYPoint { x: 2002; y: 1 }
                            XYPoint { x: 2003; y: 1 }
                            XYPoint { x: 2004; y: 1 }
                            XYPoint { x: 2005; y: 0 }
                            XYPoint { x: 2006; y: 1 }
                            XYPoint { x: 2007; y: 1 }
                            XYPoint { x: 2008; y: 4 }
                            XYPoint { x: 2009; y: 3 }
                            XYPoint { x: 2010; y: 2 }
                            XYPoint { x: 2011; y: 1 }
                        }
                    }
                    AreaSeries {
                        name: 'Taiwan'
                        axisX: valueAxisAreaSeries
                        upperSeries: LineSeries {
                            XYPoint { x: 2000; y: 2 }
                            XYPoint { x: 2001; y: 1 }
                            XYPoint { x: 2002; y: 0 }
                            XYPoint { x: 2003; y: 3 }
                            XYPoint { x: 2004; y: 0 }
                            XYPoint { x: 2005; y: 0 }
                            XYPoint { x: 2006; y: 1 }
                            XYPoint { x: 2007; y: 1 }
                            XYPoint { x: 2008; y: 0 }
                            XYPoint { x: 2009; y: 2 }
                            XYPoint { x: 2010; y: 2 }
                            XYPoint { x: 2011; y: 1 }
                        }
                    }
                }
                LargeChartView {
                    BarSeries {
                        axisX: BarCategoryAxis {
                            categories: ['2007', '2008', '2009', '2010', '2011', '2012' ]
                        }
                        BarSet { label: 'Bob'; values: [2, 2, 3, 4, 5, 6] }
                        BarSet { label: 'Susan'; values: [5, 1, 2, 4, 1, 7] }
                        BarSet { label: 'James'; values: [3, 5, 8, 13, 5, 8] }
                    }
                }
                LargeChartView {
                    BoxPlotSeries {
                        name: 'Income'
                        BoxSet { label: 'Jan'; values: [3, 4, 5.1, 6.2, 8.5] }
                        BoxSet { label: 'Feb'; values: [5, 6, 7.5, 8.6, 11.8] }
                        BoxSet { label: 'Mar'; values: [3.2, 5, 5.7, 8, 9.2] }
                        BoxSet { label: 'Apr'; values: [3.8, 5, 6.4, 7, 8] }
                        BoxSet { label: 'May'; values: [4, 5, 5.2, 6, 7] }
                    }
                    BoxPlotSeries {
                        name: 'Tax'
                        BoxSet { label: 'Jan'; values: [1.2, 2.1, 3.2, 3.4, 5.5] }
                        BoxSet { label: 'Feb'; values: [2, 2.2, 2.9, 3.6, 6.8] }
                        BoxSet { label: 'Mar'; values: [1.2, 2.2, 2.7, 3.9, 5.2] }
                        BoxSet { label: 'Apr'; values: [1.8, 2, 2.2, 3, 3.2] }
                        BoxSet { label: 'May'; values: [2, 1.9, 2.2, 3, 4] }
                    }
                }
                //TODO
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
                            //ScrollBar.horizontal.policy: ScrollBar.Never

                            TextArea {
                                id: outputField
                                width: ScrollView.width // Set explicit width
                                //height: parent.height * 0.5
                                height: contentHeight
                                readOnly: true
                                wrapMode: TextArea.Wrap
                                //onUpdateOutput: outputField.text += message
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
            CellBox {
            id: dragAndDropBox
            title: 'Парсинг из файла'
            property var fileModel: ListModel {}

            ColumnLayout {
                anchors.fill: parent

                Text {
                    text: "Drag and Drop Files"
                    font.pixelSize: 20
                }

                ListView {
                    id: listView
                    model: dragAndDropBox.fileModel
                    delegate: Item {
                        width: listView.width
                        height: 30
                        Text {
                            text: model.display
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }

                Rectangle {
                    id: dropAreaWrapper
                    width: parent.width
                    height: 100
                    border.color: "black"
                    border.width: 2

                    DropArea {
                        id: dropArea
                        anchors.fill: parent

                        onDropped: {
                            for (var i = 0; i < dropArea.data.length; i++) {
                                dragAndDropBox.fileModel.append({display: dropArea.data[i]})
                            }
                        }
                    }
                }

                MouseArea {
                    width: parent.width
                    height: 100
                    drag.target: dragArea

                    Rectangle {
                id: dragArea
                width: parent.width
                height: parent.height
                color: dragArea.containsMouse ? "lightgray" : "white"
                border.color: "black"
                border.width: 2

                Item {
                    width: parent.width
                    height: parent.height

                    Text {
                        text: "Drag Files Here"
                        font.pixelSize: 20
                        anchors.centerIn: parent
                    }
                }
            }

            onReleased: {
                var fileList = []
                for (var i = 0; i < dragArea.data.length; i++) {
                    fileList.push(dragArea.data[i].toLocalFile())
                }
                dragArea.model.clear()
                dragArea.startDrag(fileList)
            }
                }
            }
        }
        //}
//        Connections {
//                        target: frontend_handler
//                        function onDataChanged() {
//                            var out_text = frontend_handler.out_text
//                            outputField.text = out_text
//                        }
//                    }

        }
    }
}