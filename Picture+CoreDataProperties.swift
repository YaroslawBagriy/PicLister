//
//  Picture+CoreDataProperties.swift
//  PicLister
//
//  Created by Yaroslaw Bagriy on 1/31/16.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Picture {

    @NSManaged var image: NSData?
    @NSManaged var title: String?
    @NSManaged var location: String?

}
