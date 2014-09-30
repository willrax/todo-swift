//
//  Task.swift
//  Todo
//
//  Created by Will on 30/09/2014.
//  Copyright (c) 2014 willrax. All rights reserved.
//

import Foundation
import CoreData

class Task: NSManagedObject {

    @NSManaged var body: String
    @NSManaged var createdAt: NSDate

}
