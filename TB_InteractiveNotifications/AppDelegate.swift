//
//  AppDelegate.swift
//  TB_InteractiveNotifications
//
//  Created by Yari D'areglia on 29/09/14.
//  Copyright (c) 2014 Yari D'areglia. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    enum Actions:String{
        case increment = "INCREMENT_ACTION"
        case decrement = "DECREMENT_ACTION"
        case reset = "RESET_ACTION"
    }
    
    var categoryID:String {
        get{
            return "COUNTER_CATEGORY"
        }
    }
    
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Todo: Check if settings are already registered
        registerNotification()
        
        return true
    }

    // Register notification settings
    func registerNotification() {
        
        // 1. Create the actions **************************************************
        
        // increment Action
        let incrementAction = UIMutableUserNotificationAction()
        incrementAction.identifier = Actions.increment.toRaw()
        incrementAction.title = "ADD +1!"
        incrementAction.activationMode = UIUserNotificationActivationMode.Background
        incrementAction.authenticationRequired = true
        incrementAction.destructive = false

        // decrement Action
        let decrementAction = UIMutableUserNotificationAction()
        decrementAction.identifier = Actions.decrement.toRaw()
        decrementAction.title = "SUB -1"
        decrementAction.activationMode = UIUserNotificationActivationMode.Background
        decrementAction.authenticationRequired = true
        decrementAction.destructive = false
        
        // reset Action
        let resetAction = UIMutableUserNotificationAction()
        resetAction.identifier = Actions.reset.toRaw()
        resetAction.title = "RESET"
        resetAction.activationMode = UIUserNotificationActivationMode.Foreground
        // NOT USED resetAction.authenticationRequired = true
        resetAction.destructive = true
        
        
        // 2. Create the category ***********************************************
        
        // Category
        let counterCategory = UIMutableUserNotificationCategory()
        counterCategory.identifier = categoryID
        
        // A. Set actions for the default context
        counterCategory.setActions([incrementAction, decrementAction, resetAction],
            forContext: UIUserNotificationActionContext.Default)
        
        // B. Set actions for the minimal context
        counterCategory.setActions([incrementAction, decrementAction],
            forContext: UIUserNotificationActionContext.Minimal)
        
        
        // 3. Notification Registration *****************************************
        
        let types = UIUserNotificationType.Alert | UIUserNotificationType.Sound
        let settings = UIUserNotificationSettings(forTypes: types, categories: NSSet(object: counterCategory))
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
    }

    // Schedule the Notifications with repeat
    func scheduleNotification() {
        //UIApplication.sharedApplication().cancelAllLocalNotifications()
        
        // Schedule the notification ********************************************
        if UIApplication.sharedApplication().scheduledLocalNotifications.count == 0 {

            let notification = UILocalNotification()
            notification.alertBody = "Hey! Update your counter ;)"
            notification.soundName = UILocalNotificationDefaultSoundName
            notification.fireDate = NSDate()
            notification.category = categoryID
            notification.repeatInterval = NSCalendarUnit.CalendarUnitMinute
            
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
        }
    }
    
    
    // MARK: Application Delegate 
    
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        scheduleNotification()
    }
    
    func application(application: UIApplication,
        handleActionWithIdentifier identifier: String?,
        forLocalNotification notification: UILocalNotification,
        completionHandler: () -> Void) {
        
        // Handle notification action *****************************************
        if notification.category == categoryID {
            
            let action:Actions = Actions.fromRaw(identifier!)!
            let counter = Counter();
            
            switch action{
                
                case Actions.increment:
                counter++
                
                case Actions.decrement:
                counter--
                
                case Actions.reset:
                counter.currentTotal = 0

            }
        }
        
        completionHandler()
    }
}

