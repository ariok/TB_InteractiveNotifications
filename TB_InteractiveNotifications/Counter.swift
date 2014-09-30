//
//  Counter.swift
//  TB_InteractiveNotifications
//
//  Created by Yari D'areglia on 29/09/14.
//  Copyright (c) 2014 Yari D'areglia. All rights reserved.
//

import Foundation

class Counter {
    
    var UD_KEY:String {
        return "TotalCount"
    }
    
    var currentTotal:Int {
        get{
            let userDefault = NSUserDefaults.standardUserDefaults()
            return userDefault.integerForKey(UD_KEY)
        }
        set(newValue){
            let userDefault = NSUserDefaults.standardUserDefaults()
            userDefault.setInteger(newValue, forKey: UD_KEY)
            userDefault.synchronize()
            
            // Post a notification to let observers know about the new value
            let notificationCenter = NSNotificationCenter.defaultCenter()
            let notification = NSNotification(name: "COUNTER_UPDATED", object: nil)
            notificationCenter.postNotification(notification)
        }
    }
}

postfix func ++ (counter:Counter){
    counter.currentTotal += 1
}

postfix func -- (counter:Counter){
    counter.currentTotal -= 1
}