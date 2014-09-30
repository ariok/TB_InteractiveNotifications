//
//  ViewController.swift
//  TB_InteractiveNotifications
//
//  Created by Yari D'areglia on 29/09/14.
//  Copyright (c) 2014 Yari D'areglia. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    let counter = Counter()
    
    @IBOutlet weak var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set the label value
        totalLabel.text = "\(counter.currentTotal)"
        
        // Register for Counter notifications
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateUI:", name: "COUNTER_UPDATED", object: nil)
    }

    // MARK: UI Functions
    @IBAction func resetCount() {
        counter.currentTotal = 0
    }
    
    @IBAction func incrementTotal(){
        counter++
    }
    
    @IBAction func decrementTotal(){
        counter--
    }
    
    func updateUI(notification:NSNotification){
        totalLabel.text = "\(counter.currentTotal)"
    }
}

