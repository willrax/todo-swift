//
//  NewTaskController.swift
//  Todo
//
//  Created by Will on 30/09/2014.
//  Copyright (c) 2014 willrax. All rights reserved.
//

import UIKit
import CoreData

class NewTaskController: FXFormViewController, FXFormControllerDelegate {
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    let form = NewTaskForm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: "submitNewTask")
        self.formController.delegate = self
        self.formController.form = form
    }
    
    func submitNewTask() {
        let entityDescripition = NSEntityDescription.entityForName("Task", inManagedObjectContext: managedObjectContext!)
        let task = Task(entity: entityDescripition!, insertIntoManagedObjectContext: managedObjectContext)
        task.body = form.body!
        task.createdAt = NSDate.date()
        managedObjectContext?.save(nil)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}
