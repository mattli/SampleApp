//
//  SecondViewController.swift
//  SampleApp
//
//  Created by Mathew Thomas Li on 9/13/21.
//

import Foundation
import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var reportsTableView: UITableView!
    
    let reports = ["Report 1", "Report 2", "Report 3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        reportsTableView.delegate = self
        reportsTableView.dataSource = self
        
        reportsTableView.backgroundColor = .clear
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReportCell", for: indexPath) as! ReportTableViewCell
        cell.selectionStyle = .none
        cell.configure(name: reports[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("cell tapped")
        
        let confettiView = ConfettiView()
        view.insertSubview(confettiView, belowSubview: reportsTableView)
        confettiView.emit()
    }


}

