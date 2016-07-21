//
//  OurViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 4/6/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class LandingPageViewController: UIViewController {
    
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var findCaddyButton: UIButton!
    @IBOutlet weak var sloganLabel: UILabel!
    @IBOutlet weak var activeLoopButton: UIButton!
    
    var screenSize = UIScreen.mainScreen().bounds
    var nextReservation = NextReservation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true
        
        showOrHideActiveLoopButton()
        
        let navBarLogo = UIImage(named: "LoopLogoNavBarWhite")! as UIImage
        let imageView = UIImageView(image: navBarLogo)
        imageView.frame.size.width = 35.0
        imageView.frame.size.height = 35.0
        self.navigationItem.titleView = imageView
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        let imageViewBackground = UIImageView(frame: CGRectMake(0, 0, screenSize.width, screenSize.height))
        imageViewBackground.image = UIImage(named: "LandingPageBackground")
        imageViewBackground.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(imageViewBackground)
        self.view.sendSubviewToBack(imageViewBackground)
        
        activeLoopButton.layer.borderColor = UIColor.yellowColor().CGColor
        activeLoopButton.layer.borderWidth = 1
        activeLoopButton.layer.cornerRadius = 20
        activeLoopButton.layer.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2).CGColor

        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        findCaddyButton.layer.cornerRadius = 20 //findCaddyButton.bounds.height / 2
        findCaddyButton.layer.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2).CGColor
        findCaddyButton.layer.borderColor = UIColor.whiteColor().CGColor
        findCaddyButton.layer.borderWidth = 1
        findCaddyButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
 
    }
    
    @IBAction func findCaddyButtonPressed(sender: AnyObject) {
    }
    
}

extension LandingPageViewController {
    
    func showOrHideActiveLoopButton() {
        if (nextReservation.reservationIsWithinOneHour == true) {
            activeLoopButton.hidden = false
        } else {
            activeLoopButton.hidden = true
        }
    }
}


