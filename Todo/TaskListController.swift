//
//  TaskListController.swift
//  Todo
//
//  Created by Will on 30/09/2014.
//  Copyright (c) 2014 willrax. All rights reserved.
//

import UIKit
import CoreData

class TaskListController: UITableViewController, NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "To Do"
        self.navigationItem.rightBarButtonItem = newTaskButton()
        
        self.tableView.registerClass(MyCell.self, forCellReuseIdentifier: "Cell")
        
        fetchedResultController = getFetchedResultController()
        fetchedResultController.delegate = self
        fetchedResultController.performFetch(nil)
    }
    
    func newTaskButton() -> UIBarButtonItem {
        return UIBarButtonItem(title: "New", style: .Plain, target: self, action: "triggerNewTask")
    }

    func triggerNewTask() {
        var formController = NewTaskController()
        self.navigationController?.pushViewController(formController, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getFetchedResultController() -> NSFetchedResultsController {
        fetchedResultController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }
    
    func taskFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "Task")
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let numberOfSections = fetchedResultController.sections?.count {
            return numberOfSections
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let numberOfRowsInSection = fetchedResultController.sections?[section].numberOfObjects {
            return numberOfRowsInSection
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell!
        
        if cell != nil {
            cell = UITableViewCell(style: .Value1, reuseIdentifier: "Cell")
        }
        
        let task = fetchedResultController.objectAtIndexPath(indexPath) as Task
        cell.textLabel?.text = task.body
        let dateFormatter =  NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-YY 'at' h:mm a"
        cell.detailTextLabel?.text = dateFormatter.stringFromDate(task.createdAt)
        return cell
    }
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let managedObject:NSManagedObject = fetchedResultController.objectAtIndexPath(indexPath) as NSManagedObject
        managedObjectContext?.deleteObject(managedObject)
        managedObjectContext?.save(nil)
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController!) {
        tableView.reloadData()
    }

}

