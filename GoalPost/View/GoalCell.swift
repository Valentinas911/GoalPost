//
//  GoalCell.swift
//  GoalPost
//
//  Created by Valentinas Mirosnicenko on 5/5/18.
//  Copyright © 2018 Valentinas Mirosnicenko. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {
    
    @IBOutlet weak var goalDescriptionLabel: UILabel!
    @IBOutlet weak var goalTypeLabel: UILabel!
    @IBOutlet weak var goalProgressLabel: UILabel!
    @IBOutlet weak var completedView: UIView!
    
    func configureCell(goal: Goal) {
        goalDescriptionLabel.text = goal.goalDescription
        goalTypeLabel.text = goal.goalTerm
        goalProgressLabel.text = "\(goal.progress)"
        
        if goal.progress >= goal.completionValue {
            completedView.isHidden = false
        } else {
            completedView.isHidden = true
        }
        
    }

}
