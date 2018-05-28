//
//  ViewController.swift
//  Events
//
//  Created by Rayan Aldafas on 22/05/2018.
//  Copyright © 2018 RayanAldafas. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    var events:[Event]? = nil
    
    var filteredEvents:[Event]? = nil
    var isSearching = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // to reload tableView from any class
        Singleton.shared.tableViewScreen = self
        
        refreshTableView()
        
        for e in events! {
            print( e.name! )
        }
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
    }
    
    func refreshTableView() {
        events = CoreDataHandler.fetchEvents()
        self.tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return (filteredEvents?.count)!
        }
        return (events?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
        
        
        if isSearching {
            cell.nameLabel?.text = filteredEvents![indexPath.row].name
            cell.dateLabel?.text = filteredEvents![indexPath.row].date
            cell.descriptionLabel?.text = filteredEvents![indexPath.row].eventDescription
            let bgImage = filteredEvents![indexPath.row].image! as NSData
            cell.backgroundImage.image = UIImage(data: bgImage as Data)
        } else {
            cell.nameLabel?.text = events![indexPath.row].name
            cell.dateLabel?.text = events![indexPath.row].date
            cell.descriptionLabel?.text = events![indexPath.row].eventDescription
            let bgImage = events![indexPath.row].image! as NSData
            cell.backgroundImage.image = UIImage(data: bgImage as Data)
        }
        
        cell.backgroundColor = UIColor.clear
        
        // disable default selected effect
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell
    }
    
    // delete an events
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CoreDataHandler.deleteEvent(event: events![indexPath.row])
            self.events?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    // searchBar textDidChange
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            refreshTableView()
        } else {
            isSearching = true
            filteredEvents = events?.filter({($0.name?.lowercased().contains(searchBar.text!.lowercased()))! })
            refreshTableView()
        }
    }

    
    
    // to hide keyboard when user focus changes
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    // change status bar style
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }


}

