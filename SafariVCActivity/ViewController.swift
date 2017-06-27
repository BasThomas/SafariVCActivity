//
//  ViewController.swift
//  SafariVCActivity
//
//  Created by Bas Broek on 27/06/2017.
//  Copyright © 2017 Bas Broek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  @IBAction func buttonTap(_ sender: Any) {
    let url = URL(string: "https://github.com")!
    let activity = SafariVCActivity()
    let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: [activity])
    present(activityVC, animated: true)
  }

}

