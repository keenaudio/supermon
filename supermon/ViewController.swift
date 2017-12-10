//
//  ViewController.swift
//  ndimon
//
//  Created by Aaron Granick on 12/6/17.
//  Copyright © 2017 Aaron Granick. All rights reserved.
//

import Cocoa
import NDIKit

class ViewController: NSViewController {
    
    @IBOutlet weak var tableView: NSTableView!
    
    var sources: [NDISource]?
    let ndiWrapper: NDIWrapper! = NDIWrapper()
    let ndiFinder: NDIFinder = NDIFinder()
    
    func didFindSource(_src:NDISource?) {
        let src = _src!
        print("have a source: \(src.name), \(src.ip)")
        
        sources?.append(src);
        tableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
        sources = [NDISource]()
        ndiFinder.find(didFindSource);
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
}

extension ViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return sources?.count ?? 0
    }
    
}

extension ViewController: NSTableViewDelegate {
    
    fileprivate enum CellIdentifiers {
        static let NameCell = "NameCellID"
        static let DetailseCell = "DetailsCellID"
        static let StatusCell = "StatusCellID"
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var image: NSImage?
        var text: String = ""
        var cellIdentifier: String = ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .long
        
        // 1
        guard let item = sources?[row] else {
            return nil
        }
        
        // 2
        if tableColumn == tableView.tableColumns[0] {
            text = item.name
            cellIdentifier = CellIdentifiers.NameCell
        } else if tableColumn == tableView.tableColumns[1] {
            text = "NA"
            cellIdentifier = CellIdentifiers.DetailseCell
        } else if tableColumn == tableView.tableColumns[2] {
            text = "?"
            cellIdentifier = CellIdentifiers.StatusCell
        }
        
        // 3
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(cellIdentifier), owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
            cell.imageView?.image = image ?? nil
            return cell
        }
        return nil
    }
    
}
