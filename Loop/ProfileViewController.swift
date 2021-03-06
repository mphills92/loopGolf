//
//  ProfileViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/9/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIScrollViewDelegate {
    
    // Reference to database class which communicates with Firebase.
    let usersDB = UsersDatabase()
    
    /*
    // Local variables to be populated by database class.
    var firstName = String()
    var lastName = String()
    var membershipHistory = String()
    var lifetimeRounds = Int()
    var credit = Int()
    */

    let screenSize: CGRect = UIScreen.mainScreen().bounds
    var selectedIndex = Int()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var stickySegmentedTab: UIView!
    @IBOutlet weak var constrainedStickyTabToNavBar: NSLayoutConstraint!
    @IBOutlet weak var upcomingReservationsContainer: UIView!
    @IBOutlet weak var pastCaddiesContainer: UIView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var membershipHistoryLabel: UILabel!
    @IBOutlet weak var lifetimeRoundsLabel: UILabel!
    @IBOutlet weak var currentCreditLabel: UILabel!
    
    let userName = UserName()
    let userAccount = UserAccount()
    
    @IBAction func closeViewButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        navigationController?.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!]
        
        self.userProfileImage.layer.cornerRadius = 50

        self.stickySegmentedTab.layer.shadowOpacity = 0.25
        self.stickySegmentedTab.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        
        let distBetweenScrollSectionAndNavBar : CGFloat = 300 - 64
        let screenSizeAdjustment = 1 + (distBetweenScrollSectionAndNavBar / screenSize.height)
        self.scrollView.contentSize.height = screenSize.height * screenSizeAdjustment
        self.scrollView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0)
        
        
        // Sets up observer to receive notifications from segmented control when new index has been selected.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "notifyWithSelectedIndex:", name: "selectedIndexNotification", object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        // Populate the view labels with user information from 'Database.swift'.
        userNameLabel.text = "\(usersDB.firstName)" + " \(usersDB.lastName)"
        membershipHistoryLabel.text = "Member since \(usersDB.membershipHistory)"
        lifetimeRoundsLabel.text = "\(usersDB.lifetimeRounds)"
        currentCreditLabel.text = "$\(usersDB.credit)"
    }
    
    func notifyWithSelectedIndex (notification: NSNotification) {
        selectedIndex = notification.object! as! Int
        
        if (selectedIndex == 0) {
            self.upcomingReservationsContainer.hidden = false
            self.pastCaddiesContainer.hidden = true
        } else if (selectedIndex == 1) {
            self.upcomingReservationsContainer.hidden = true
            self.pastCaddiesContainer.hidden = false
        }
    }
}

extension ProfileViewController {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let scrollOffset = scrollView.contentOffset.y
        
        if (scrollOffset >= 300) {
            constrainedStickyTabToNavBar.constant = 300 + (scrollOffset - 300)
        } else {
            constrainedStickyTabToNavBar.constant = 300
        }
    }
}
