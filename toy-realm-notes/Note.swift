//
//  Note.swift
//  toy-realm-notes
//
//  Created by Faiz Mokhtar on 13/05/2018.
//  Copyright © 2018 Faiz Mokhtar. All rights reserved.
//

import Foundation
import RealmSwift

class Note: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var content: String = ""

}
