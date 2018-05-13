//
//  NoteController.swift
//  toy-realm-notes
//
//  Created by Faiz Mokhtar on 13/05/2018.
//  Copyright © 2018 Faiz Mokhtar. All rights reserved.
//

import UIKit
import Eureka
import RealmSwift

class NoteController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()

        form +++ Section("")
            <<< TextRow() {
                $0.placeholder = "Enter title here"
                $0.tag = "TITLE_TEXT_ROW"
            }
            <<< TextAreaRow() {
                $0.placeholder = "What's on your mind?"
                $0.tag = "CONTENT_AREA_TEXT_ROW"
            }
    }

    func configureUI() {
        self.title = "Add Note"
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .done,
                                         target: self,
                                         action: #selector(tapDoneButton))
        self.navigationItem.rightBarButtonItem = doneButton
    }

    @objc func tapDoneButton() {
        guard let titleRow: TextRow = form.rowBy(tag: "TITLE_TEXT_ROW"),
              let contentRow: TextAreaRow = form.rowBy(tag: "CONTENT_AREA_TEXT_ROW") else {
                fatalError("Failed to set up rows")
        }

        if let title = titleRow.value, let content = contentRow.value {
            let note = Note()
            note.title = title
            note.content = content

            let realm = try! Realm()
            try! realm.write {
                realm.add(note)
            }
            self.navigationController?.popViewController(animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    }
