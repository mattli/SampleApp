//
//  JournalTableViewCell.swift
//  SampleApp
//
//  Created by Mathew Thomas Li on 9/13/21.
//

import Foundation
import UIKit

class JournalTableViewCell: UITableViewCell {

    @IBOutlet weak var journalName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization code
//        headerTitle.textColor = .white
//        headerTitle.font = App.Fonts.heading
    }
    
    func configure(name: String) {
        journalName.text = name
    }
    
}
