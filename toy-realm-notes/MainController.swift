//
//  MainController.swift
//  toy-realm-notes
//
//  Created by Faiz Mokhtar on 13/05/2018.
//  Copyright © 2018 Faiz Mokhtar. All rights reserved.
//

import UIKit
import RealmSwift

class MainController: UIViewController {

    @IBOutlet var tableView: UITableView!

    let realm = try! Realm()
    var notificationToken: NotificationToken? = nil

    var notes: Results<Note> {
        get {
            return realm.objects(Note.self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Notes"

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "NoteCell", bundle: nil), forCellReuseIdentifier: "NoteCell")

        notificationToken = notes.observe({ [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update:
                tableView.reloadData()
            case .error(let error):
                fatalError("ERROR: \(error.localizedDescription)")
            }
        })
    }

    deinit {
        notificationToken?.invalidate()
    }

    @IBAction func tapAddNoteBarButtonItem(_ sender: UIBarButtonItem) {
        let vc = NoteController(nibName: "NoteController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteCell

        let note = notes[indexPath.row]
        cell.nameLabel.text = note.title
        cell.contentLabel.text = note.content

        return cell
    }
}

extension MainController: UITableViewDelegate {

}
