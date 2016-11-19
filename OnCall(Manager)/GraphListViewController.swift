//
//  GraphListViewController.swift
//  OnCall(Manager)
//
//  Created by Samuel Resendez on 11/19/16.
//  Copyright © 2016 Samuel Resendez. All rights reserved.
//

import UIKit

class GraphListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    let fakeGraphList = ["Container Size Type", "Chassis Graph", "Who knows what else"]
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
        print("Alright we're here!")
        return fakeGraphList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.graphTableView.dequeueReusableCell(withIdentifier: "graphCell")! as UITableViewCell
        cell.textLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 40)
        cell.textLabel?.text = fakeGraphList[indexPath.row];
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "listtoGraphSegue", sender: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
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
