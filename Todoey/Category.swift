//
//  Category.swift
//  Todoey
//
//  Created by Shah, Raj Kumar-CW on 2/12/18.
//  Copyright © 2018 Shah, Raj Kumar-CW. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    
    @objc dynamic var name : String = ""
    
    let items = List<Item>()
}
