//
//  LexiconViewController.swift
//  ScienceLexicon
//
//  Created by Rudd Fawcett on 1/26/16.
//  Copyright © 2016 Rudd Fawcett. All rights reserved.
//

import UIKit

class LexiconViewController: UITableViewController {
    var lexicon: Lexicon!
    var keys: [String] {
        get {
            let letters = Array(lexicon.indexed[language]!.keys)
            return letters.sort({
                $0 < $1
            })
        }
    }
    var language: Language = .Arabic
    
    let EntryCellIdentifier = "EntryCellIdentifier"
    
    // MARK: - Initializers
    
    init() {
        super.init(style: .Plain)
        lexicon = Parser.parse("lexicon")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Science Lexicon"
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: EntryCellIdentifier)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "A", style: .Done, target: self, action: "translate")
    }

    func translate() {
        if language == .Arabic {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "ق", style: .Done, target: self, action: "translate")
            language = .English
        }
        else {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "A", style: .Done, target: self, action: "translate")
            language = .Arabic
        }
        
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return (lexicon.indexed[language]?.keys.count)!
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let letter = keys[section]
        
        return (lexicon.indexed[language]![letter]?.count)!
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return keys[section]
    }
    
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return keys
    }
    
    override func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        return keys.indexOf(title)!
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(EntryCellIdentifier)
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: EntryCellIdentifier)
        
        let entry: Entry = lexicon.indexed[language]![keys[indexPath.section]]![indexPath.row]
        
        cell?.textLabel?.text = entry.terms[language]
        cell?.detailTextLabel?.text = entry.terms[language.opposite()]
        
        cell?.accessoryType = .DisclosureIndicator

        return cell!
    }
    
    // MARK: - Table view delegate methods
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }

}
