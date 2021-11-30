//
//  ViewController.swift
//  stm
//
//  Created by 申潤五 on 2021/11/10.
//

import UIKit
import ReplayKit

class ViewController: UIViewController {

    @IBOutlet weak var information: UILabel!
    
    var timer:Timer!
    var counter = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let systemBroadcastPickerView = RPSystemBroadcastPickerView(frame: CGRect(x: 100, y: 120, width: 60, height: 60))
        systemBroadcastPickerView.layer.borderColor = UIColor.black.cgColor
        systemBroadcastPickerView.layer.borderWidth = 1
        systemBroadcastPickerView.layer.cornerRadius = 5
        self.view.addSubview(systemBroadcastPickerView)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let newView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        newView.center = self.view.center
        newView.clipsToBounds = true
        newView.layer.cornerRadius = 20
        newView.backgroundColor = UIColor.red
        self.view.addSubview(newView)
        timer = Timer.scheduledTimer(withTimeInterval: (1.0/60), repeats: true, block: { timer in
            let angle =  self.counter * M_PI / 180
            newView.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
            self.counter += 1
        })
    }
    
}

