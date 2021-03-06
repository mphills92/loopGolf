//
//  UpcomingReservationsViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/17/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class UpcomingReservationsViewController: UITableViewController {
    
    var dataExistsForTableView = false
    let upcomingReservations = UpcomingReservations()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.contentInset = UIEdgeInsetsMake(-36, 0, -200, 0)
    }
}

extension UpcomingReservationsViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if (upcomingReservations.reservationDataExists == true) {
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
            numOfSections = 1
            tableView.backgroundView = nil
        } else {
            let noDataLabel: UILabel = UILabel(frame: CGRectMake(0, 0, tableView.bounds.size.width, tableView.bounds.size.height))
            noDataLabel.text = "You have no upcoming reservations."
            noDataLabel.font = UIFont(name: "AvenirNext-Regular", size: 17)
            noDataLabel.textColor = UIColor.darkGrayColor()
            noDataLabel.textAlignment = NSTextAlignment.Center
            tableView.backgroundView = noDataLabel
            tableView.backgroundColor = UIColor.groupTableViewBackgroundColor()
            tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        }
        return numOfSections
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcomingReservations.numberOfUpcomingReservationsCells
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reservationRecapCell", forIndexPath: indexPath) as! ReservationRecapCell
        cell.userProfileImage.layer.cornerRadius = 50
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("toUpcomingReservationOverviewSegue", sender: self)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
        
}