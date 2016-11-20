//
//  OnboardViewController.swift
//  
//
//  Created by Samuel Resendez on 11/19/16.
//
//

import UIKit

class OnboardViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
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
        
        if(usernameField.text == "" && passwordField.text == "") {
            self.view.makeToast("Please enter your credentials", duration: 2.0, position: CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2), title: "BlackFin Notification", image: UIImage(named: "Dolphin_Logo?"), style:nil) { (didTap: Bool) -> Void in
                if didTap {
                    print("completion from tap")
                } else {
                    print("completion without tap")
                }
            }
            return
        }
        
        performSegue(withIdentifier: "logintoshipID", sender: sender);
    }
    
}
