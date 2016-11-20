//
//  GraphListViewController.swift
//  OnCall(Manager)
//
//  Created by Samuel Resendez on 11/19/16.
//  Copyright © 2016 Samuel Resendez. All rights reserved.
//

import UIKit
import Toast_Swift

class GraphListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var vesselName = ""
    
    let fakeGraphList = ["Container Size Type", "Shipment Type", "Cargo Destinations"]
    @IBOutlet weak var graphTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("We are here")

        // Do any additional setup after loading the view.
        self.graphTableView.register(UITableViewCell.self, forCellReuseIdentifier: "graphCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // --- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fakeGraphList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.graphTableView.dequeueReusableCell(withIdentifier: "graphCell")! as UITableViewCell
        cell.textLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 40)
        cell.textLabel?.text = fakeGraphList[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryType.detailDisclosureButton
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = graphTableView.cellForRow(at: indexPath)
        performSegue(withIdentifier: "listtoGraphSegue", sender: cell)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as? UITableViewCell
        if let dest = segue.destination as? GraphViewController {
            dest.titleString = (cell!.textLabel?.text)!
            dest.vesselName = self.vesselName
            let params = ["vessel":vesselName]
            if(dest.titleString == "Container Size Type") {
                DataHandler.makePostRequest(endpoint:"vessel", params: params)
            }
            else if(dest.titleString == "Cargo Destinations") {
                DataHandler.makePostRequest(endpoint: "destinations", params: params)
            }
            else if(dest.titleString == "Shipment Type") {
                DataHandler.makePostRequest(endpoint: "locality", params: params)
            }
            
        }
    }

    @IBAction func commissionPressed(_ sender: Any) {
        DataHandler.sendText()
        let params = ["vessel":vesselName]
        print("VesselName: " + vesselName)
        let didSucceed = DataHandler.makeCommission(params: params, toastView:self.view)
    
        if(didSucceed) {
            print("We did it squad!")
        }
        else {
            print("We didn't do it squad")
        }
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
