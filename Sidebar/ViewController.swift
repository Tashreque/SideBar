//
//  ViewController.swift
//  Sidebar
//
//  Created by Tashreque Mohammed Haq on 22/9/21.
//

import UIKit

class ViewController: UIViewController {
    
    // IBOutlet connections.
    @IBOutlet weak var containerLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftSideMenuView: UIView!
    
    // Side menu properties
    let sideMenuWidth: CGFloat = 250
    var isShowing = false
    var isAnimating = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if let view = touch.view, view != leftSideMenuView, isShowing {
                DispatchQueue.main.async { [weak self] in
                    self?.animateAndHide()
                }
            }
        }
    }
    
    private func animateAndShow() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) { [weak self] in
            guard let self = self else { return }
            self.isAnimating = true
            
            // Show side bar and slide the view to the right.
            self.containerLeftConstraint.constant += self.sideMenuWidth
            self.containerRightConstraint.constant += self.sideMenuWidth
            self.view.layoutIfNeeded()
        } completion: { [weak self] _ in
            guard let self = self else { return }
            self.isShowing = true
            self.isAnimating = false
        }
    }
    
    private func animateAndHide() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) { [weak self] in
            guard let self = self else { return }
            self.isAnimating = true
            
            // Show side bar and slide the view to the right.
            self.containerLeftConstraint.constant -= self.sideMenuWidth
            self.containerRightConstraint.constant -= self.sideMenuWidth
            self.view.layoutIfNeeded()
        } completion: { [weak self] _ in
            guard let self = self else { return }
            self.isShowing = false
            self.isAnimating = false
        }
    }

    @IBAction func leftSideMenuTriggered(_ sender: Any) {
        if !isAnimating {
            if !isShowing {
                animateAndShow()
            } else {
                animateAndHide()
            }
        }
    }
    
    @IBAction func rightSideMenuTriggered(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "RightSideMenuViewController") as? RightSideMenuViewController {
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
}

