//
//  SafariVCActivity.swift
//  SafariVCActivity
//
//  Created by Bas Broek on 27/06/2017.
//  Copyright © 2017 Bas Broek. All rights reserved.
//

import UIKit
import SafariServices

class SafariVCActivity: UIActivity, ActivityFinishing, SFSafariViewControllerDelegate {
  
  var url: URL?
  
  override var activityType: UIActivityType? {
    return UIActivityType(rawValue: String(describing: self))
  }
  
  override var activityTitle: String? {
    return "Open in Safari View Controller"
  }
  
  override var activityImage: UIImage? {
    return nil
  }
  
  override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
    return !activityItems.filter { $0 is URL && UIApplication.shared.canOpenURL($0 as! URL) }.isEmpty
  }
  
  override func prepare(withActivityItems activityItems: [Any]) {
    self.url = activityItems.flatMap { $0 as? URL }.first
  }
  
  override class var activityCategory: UIActivityCategory {
    return .action
  }
  
  override var activityViewController: UIViewController? {
//    let vc = SafariVC()
//    vc.url = url
//    vc.delegate = self
//    return vc
    guard let url = url else { return nil }
    let svc = SFSafariViewController(url: url)
    svc.delegate = self
    return svc
  }
  
  func _activityDidFinish(_ completed: Bool) {
    activityDidFinish(completed)
  }
  
  func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
    activityDidFinish(true)
  }
}

protocol ActivityFinishing: class {
  func _activityDidFinish(_ completed: Bool)
}

class SafariVC: UIViewController, SFSafariViewControllerDelegate {
  
  var url: URL?
  weak var delegate: ActivityFinishing?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    guard let url = url else { return }
    let safariVC = SFSafariViewController(url: url)
    safariVC.delegate = self
    present(safariVC, animated: animated)
  }
  
  func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
      self?.delegate?._activityDidFinish(true) // Do this after the SafariVC is dismissed
    }
  }
}
