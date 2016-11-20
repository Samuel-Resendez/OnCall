//
//  DataHandler.swift
//  
//
//  Created by Samuel Resendez on 11/19/16.
//
//

import Alamofire
import SwiftyJSON
import UIKit
import Toast_Swift

class DataHandler: NSObject {
    
    class func makeGetRequest() {
        Alamofire.request("http://oncallbackend.herokuapp.com/vessel",method:.get).responseJSON { response in
            
            var dataArray = [0:10,1:20,2:30,3:40]
           /* let notificationName = Notification.Name("gotArrayFromServer")
            NotificationCenter.default.post(name: notificationName, object: nil, userInfo: dataArray) */
            
        }

    }
    
    class func makeCommission(params:Parameters,toastView:UIView) -> Bool {
        var didSucceed = false
        
        Alamofire.request("http://oncallbackend.herokuapp.com/jobGen",method:.post, parameters:params).validate().responseJSON { response in
            print(response.response)
            print("------------")
            print(response.result.value)
            print("------------")
            if let data =  response.result.value as? String {
                print(data)
                print("We are inside the thing")
                if data == "Success" {
                    toastView.makeToast("Shipment has been successfully commissioned!",duration:1.5,position:.center)
                    didSucceed = true
                }
                else {
                    toastView.makeToast("Shipment failed to be commissioned",duration:1.5,position:.center)
                }
            }
        }
        return didSucceed
    }
    
    class func makePostRequest(endpoint:String, params:Parameters) {
        Alamofire.request("http://oncallbackend.herokuapp.com/"+endpoint, method:.post , parameters:params).validate().responseJSON { response in
            
            if let dataArray = response.result.value as? [Int] {
                var datDict = [Int:Int]()
                for index in 0..<dataArray.count {
                    datDict[index] = dataArray[index]
                }
                let notificationName = Notification.Name("gotArrayFromServer")
                NotificationCenter.default.post(name: notificationName, object: nil, userInfo: datDict)
            }
            else if endpoint == "locality" {
                if let data = JSON(response.result.value) as? JSON {
                    var datDict = [String:Int]()
                    for(locality,count) in data {
                        datDict[locality] = Int(count.stringValue)
                    }
                    let notificationName = Notification.Name("gotArrayFromServer")
                    NotificationCenter.default.post(name:notificationName, object:nil,userInfo:datDict)
                }
            }
            else if let dataJSON = JSON(response.result.value) as? JSON {
                print("Hello world!")
                var datDict = [String:Int]()
                for (location,count) in dataJSON {
                    print(location)
                    let count = count.stringValue
                    print(count)
                    datDict[location] = Int(count)
                }
                let notificationName = Notification.Name("gotArrayFromServer")
                NotificationCenter.default.post(name:notificationName, object:nil, userInfo:datDict)
                
            }
            
        }
            
    }
}

