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
      title: '&Help'
      Action { text: '&About' }
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
  title: 'Buttons'
  ColumnLayout {
    anchors.fill: parent

    SpinBox {
      id: spinBox1
      value: 50
      editable: true
      Layout.fillWidth: true
    }

    SpinBox {
      id: spinBox2
      value: Math.min(spinBox1.value, spinBox2.value)
      editable: true
      Layout.fillWidth: true
      property int maxSpinBox1Value: spinBox1.value

      onMaxSpinBox1ValueChanged: {
        if (spinBox2.value > maxSpinBox1Value) {
          spinBox2.value = maxSpinBox1Value
        }
      }
    }

    Switch {
      Layout.alignment: Qt.AlignHCenter
    }
  }

  Connections {
    target: spinBox1
    onValueChanged: {
      spinBox2.maxSpinBox1Value = spinBox1.value
      if (spinBox2.value > spinBox2.maxSpinBox1Value) {
        spinBox2.value = spinBox2.maxSpinBox1Value-1
      }
    }
  }
}


      CellBox {
        title: 'Check Boxes'
        ColumnLayout {
          anchors.fill: parent
          DelayButton {
            text: 'Сброс'
            delay: 1000
            Layout.fillWidth: true
          }
          DelayButton {
            text: 'Пуск'
            delay: 3000
            Layout.fillWidth: true
          }
        }
      }

      CellBox {
        title: 'Output Field'
        ColumnLayout {
            anchors.fill: parent

            ScrollView {
                Layout.fillWidth: true
                Layout.preferredHeight: parent.height * 0.6
                clip: true
                ScrollBar.vertical.policy: ScrollBar.AlwaysOn
                ScrollBar.vertical.implicitWidth: 20
                //ScrollBar.horizontal.policy: ScrollBar.Never

                TextArea {
                    id: outputField
                    width: ScrollView.width // Set explicit width
                    height: contentHeight
                    readOnly: true
                    wrapMode: TextArea.Wrap
                }
            }

            Button {
                text: "Update Output"
                Layout.alignment: Qt.AlignHCenter
                onClicked: {
                    // Update the output text here
                    outputField.text += "New data\n"
                }
            }
        }
      }


    CellBox {
    id: dragAndDropBox
    title: 'Drag and Drop'
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
      CellBox {
        Layout.rowSpan: 2; Layout.minimumWidth: 700
        title: 'Tabs'
        Layout.preferredWidth: parent.width * 0.5 // Keep the ratio right!
        TabBar {
          id: bar
          width: parent.width
          TabButton { text: 'Area' }
          TabButton { text: 'Bar' }
          TabButton { text: 'Box' }
          TabButton { text: 'Candlestick' }
          TabButton { text: 'Polar' }
          TabButton { text: 'Scatter' }
          TabButton { text: 'Spine' }
          TabButton { text: 'Pie' }
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
          LargeChartView {
            CandlestickSeries {
              name: 'Acme Ltd.'
              increasingColor: 'green'
              decreasingColor: 'red'
              CandlestickSet { timestamp: 1435708800000; open: 690; high: 694; low: 599; close: 660 }
              CandlestickSet { timestamp: 1435795200000; open: 669; high: 669; low: 669; close: 669 }
              CandlestickSet { timestamp: 1436140800000; open: 485; high: 623; low: 485; close: 600 }
              CandlestickSet { timestamp: 1436227200000; open: 589; high: 615; low: 377; close: 569 }
              CandlestickSet { timestamp: 1436313600000; open: 464; high: 464; low: 254; close: 254 }
            }
          }
          PolarChartView {
            animationOptions: ChartView.SeriesAnimations
            legend.visible: false
            antialiasing: true
            theme: ChartView[qtquickChartsThemes.currentText]
            ValueAxis {
              id: axisAngular
              min: 0
              max: 20
              tickCount: 9
            }
            ValueAxis {
              id: axisRadial
              min: -0.5
              max: 1.5
            }
            SplineSeries {
              id: series1
              axisAngular: axisAngular
              axisRadial: axisRadial
              pointsVisible: true
            }
            ScatterSeries {
              id: series2
              axisAngular: axisAngular
              axisRadial: axisRadial
              markerSize: 10
            }
          }
          // Add data dynamically to the series
          Component.onCompleted: {
            for (var i = 0; i <= 20; i++) {
              series1.append(i, Math.random());
              series2.append(i, Math.random());
            }
          }
          LargeChartView {
            ScatterSeries {
              name: 'Scatter1'
              XYPoint { x: 0.51; y: 1.5 }
              XYPoint { x: 0.56; y: 1.6 }
              XYPoint { x: 0.57; y: 1.55 }
              XYPoint { x: 0.85; y: 1.8 }
              XYPoint { x: 0.96; y: 1.6 }
              XYPoint { x: 0.12; y: 1.3 }
              XYPoint { x: 0.52; y: 2.1 }
            }
            ScatterSeries {
              name: 'Scatter2'
              XYPoint { x: 0.4; y: 1.5 }
              XYPoint { x: 0.9; y: 1.6 }
              XYPoint { x: 0.7; y: 1.55 }
              XYPoint { x: 0.8; y: 1.8 }
              XYPoint { x: 0.5; y: 1.6 }
              XYPoint { x: 0.1; y: 1.3 }
              XYPoint { x: 0.6; y: 2.1 }
            }
          }
          LargeChartView {
            SplineSeries {
              name: 'BPM'
              XYPoint { x: 0; y: 0.0 }
              XYPoint { x: 1.1; y: 5.2 }
              XYPoint { x: 1.9; y: 2.4 }
              XYPoint { x: 2.1; y: 2.1 }
              XYPoint { x: 2.9; y: 2.6 }
              XYPoint { x: 3.4; y: 2.3 }
              XYPoint { x: 4.1; y: 3.1 }
            }
          }
          LargeChartView {
            PieSeries {
              PieSlice { label: 'eaten'; value: 74.7 }
              PieSlice { label: 'not yet eaten'; value: 5.1 }
              PieSlice { label: 'wut?'; value: 20.2; exploded: true }
            }
          }
        }
      }
      Popup {
        id: normalPopup
        ColumnLayout {
          anchors.fill: parent
          Label { text: 'Normal Popup' }
          CheckBox { text: 'E-mail' }
          CheckBox { text: 'Calendar' }
          CheckBox { text: 'Contacts' }
        }
      }
      Popup {
        id: modalPopup
        modal: true
        ColumnLayout {
          anchors.fill: parent
          Label { text: 'Modal Popup' }
          CheckBox { text: 'E-mail' }
          CheckBox { text: 'Calendar' }
          CheckBox { text: 'Contacts' }
        }
      }
      Dialog {
        id: dialog
        title: 'Dialog'
        Label { text: 'The standard dialog.' }
        footer: DialogButtonBox {
          standardButtons: DialogButtonBox.Ok | DialogButtonBox.Cancel
        }
      }
    }
  }
}