//
//  ViewController.swift
//  stm
//
//  Created by 申潤五 on 2021/11/10.
//

import UIKit
import ReplayKit

class ViewController: UIViewController {
//    func broadcastActivityViewController(_ broadcastActivityViewController: RPBroadcastActivityViewController, didFinishWith broadcastController: RPBroadcastController?, error: Error?) {
//        print(error?.localizedDescription)
//    }
    @IBOutlet weak var information: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let systemBroadcastPickerView = RPSystemBroadcastPickerView(frame: CGRect(x: 100, y: 80, width: 60, height: 60))
        systemBroadcastPickerView.layer.borderColor = UIColor.black.cgColor
        systemBroadcastPickerView.layer.borderWidth = 1
        systemBroadcastPickerView.layer.cornerRadius = 5
        self.view.addSubview(systemBroadcastPickerView)
        let id = Int.random(in: 10000...99999)
//        UserDefaults.standard.set(id, forKey: "appcode")
//        UserDefaults.standard.synchronize()
        information.text = "\(id)"
        UIPasteboard.general.string = "\(id)"
        
//        let id2 = UserDefaults.standard.value(forKey: "appcode") as? Int //set(id, forKey: "appcode")
        print("formVC:\(UIPasteboard.general.string)")
    }

    @IBAction func actionOne(_ sender: Any) {
        
//        print("只用這個 APP 時用")
//        RPBroadcastActivityViewController.load { broadcastAVC, error in
//            print(error?.localizedDescription)
//            if let broadcastAVC = broadcastAVC {
//                broadcastAVC.delegate = self
//                broadcastAVC.modalPresentationStyle = .popover
//                self.present(broadcastAVC, animated: true) {
//                    print("down")
//                    print("down")
//                }
//            }
//        }
    }
    
}

