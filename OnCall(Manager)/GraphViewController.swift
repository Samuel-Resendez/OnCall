//
//  GraphViewController.swift
//  OnCall(Manager)
//
//  Created by Samuel Resendez on 11/19/16.
//  Copyright © 2016 Samuel Resendez. All rights reserved.
//

import Charts
import UIKit

class GraphViewController: UIViewController,IAxisValueFormatter {
    
    //Should be set by segue
    var titleString = ""
    var vesselName = ""
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var barChartView: BarChartView!
    
    var xVals = [Int]()
    var yVals = [Double]()
    var xLabels = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        barChartView.chartDescription?.text = ""
        barChartView.drawBarShadowEnabled = false
        barChartView.xAxis.drawAxisLineEnabled = false
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.leftAxis.drawGridLinesEnabled = false
        barChartView.rightAxis.drawGridLinesEnabled = false
        barChartView.rightAxis.drawAxisLineEnabled = false
        barChartView.noDataFont = UIFont(name: "HelveticaNeue-Thin", size: 50)
        barChartView.noDataText = "Sorry, haven't loaded data yet!"
        titleLabel.text = titleString
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(GraphViewController.notificationReceived(notification:)), name: NSNotification.Name(rawValue: "gotArrayFromServer"), object: nil)
    }
    
    func setupChart(names:[Int],values:[Double]) {
        var entryList = [BarChartDataEntry]()
        for value in names {
            entryList.append(BarChartDataEntry(x: Double(names[value]), y: values[value]))
        }
        let bSet = BarChartDataSet(values: entryList, label: "Frequency")
        //bSet.colors = [UIColor.red,UIColor.blue]
        bSet.setColor(UIColor.blue, alpha: 0.5)
        bSet.valueFont = UIFont(name: "HelveticaNeue-Thin", size: 30)!
        print("This is the titleString: " + titleString)
        if(titleString == "Container Size Type") {
            xLabels = ["20","40","45"]
            print("We have set xLabels")
        }
        barChartView.xAxis.labelCount = xVals.count
        barChartView.xAxis.valueFormatter = self
        barChartView.xAxis.labelFont = UIFont(name: "HelveticaNeue-Thin", size: 20)!
        barChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        
        let bData = BarChartData(dataSets: [bSet])
        barChartView.data = bData
        
        barChartView.animate(yAxisDuration: 1.5)
        
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        if(Int(value) >= xLabels.count || Int(value) < 0) {
            return "X-axis Label"
        }
        return xLabels[Int(value)]
    }
    
    func notificationReceived(notification:Notification) {
        print("We made it here!")
        if let datArray = notification.userInfo as? [Int:Int] {
            print(datArray)
            
            for index in 0..<datArray.count {
                xVals.append(index)
                yVals.append(Double(datArray[index]!))
            }
            setupChart(names: xVals, values: yVals)
        }
        else if let geoArray = notification.userInfo as? [String:Int] {
            xLabels.removeAll()
            for (key, _) in geoArray {
                xLabels.append(key)
            }
            print(xLabels)
            for index in 0..<geoArray.count {
                xVals.append(index)
                yVals.append(Double(geoArray[xLabels[index]]!))
            }
            setupChart(names: xVals, values: yVals)
            
        }
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? GraphListViewController {
            dest.vesselName = self.vesselName
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
