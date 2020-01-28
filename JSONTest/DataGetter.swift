//
//  DataGetter.swift
//  JSONTest
//
//  Created by William Melrose on 1/28/20.
//  Copyright © 2020 William Melrose. All rights reserved.
//

import UIKit

class DataGetter: NSObject {
    let MYJSONURL = "https://api.myjson.com/bins/8e3i6"
        
    var dataArray = ["No data yet, Captain"]
    
    func getData(completion: @escaping (_ success: Bool) -> ()) {
        var success = true
        
        let actualURL = URL(string: MYJSONURL)
        
        let task = URLSession.shared.dataTask(with: actualURL!){
            (data, response, error) in
            
            guard let _ = data, error == nil else{
                success=false
                return
            }
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                print(jsonObj.value(forKey: "games")!)
                if let veggieArray = jsonObj.value(forKey: "games") as? Array<String> {
                    self.dataArray = veggieArray
                }
            }
            completion(success)
        }
        task.resume()
    }
}
