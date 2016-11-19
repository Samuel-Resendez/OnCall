//
//  shipIDViewController.swift
//  OnCall(Manager)
//
//  Created by Samuel Resendez on 11/19/16.
//  Copyright © 2016 Samuel Resendez. All rights reserved.
//

import UIKit

class shipIDViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    @IBAction func submitPressed(_ sender: Any) {
        performSegue(withIdentifier: "shipIDtoList", sender: sender);
    }

}
