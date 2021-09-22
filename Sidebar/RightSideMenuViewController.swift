//
//  RightSideMenuViewController.swift
//  Sidebar
//
//  Created by Tashreque Mohammed Haq on 23/9/21.
//

import UIKit

class RightSideMenuViewController: UIViewController {
    
    // IBOutlet connections.
    @IBOutlet weak var sideMenuViewRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var sideMenuView: UIView!
    
    // Side menu properties.
    let sideMenuWidth: CGFloat = 250
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    private func setupUI() {
        // Perform any initial UI setup.
        
        // Set background color to black with an alpha of your choice so that previous view controller can be seen behind this view controller.
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        DispatchQueue.main.async { [weak self] in
            self?.animateAndShowSideMenu()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if let view = touch.view, view != sideMenuView {
                DispatchQueue.main.async { [weak self] in
                    self?.animateAndDismissSideMenu()
                }
            }
        }
    }
    
    private func animateAndShowSideMenu() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) { [weak self] in
            guard let self = self else { return }
            self.sideMenuViewRightConstraint.constant -= self.sideMenuWidth
            self.view.layoutIfNeeded()
        }
    }
    
    private func animateAndDismissSideMenu() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) { [weak self] in
            guard let self = self else { return }
            self.sideMenuViewRightConstraint.constant += self.sideMenuWidth
            self.view.layoutIfNeeded()
        } completion: { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }

    }

}
