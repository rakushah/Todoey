//
//  Item.swift
//  Todoey
//
//  Created by Shah, Raj Kumar-CW on 2/12/18.
//  Copyright © 2018 Shah, Raj Kumar-CW. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    var parentCategory = LinkingObjects(fromType : Category.self, property: "items")
}
