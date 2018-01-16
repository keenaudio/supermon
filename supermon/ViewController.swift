//  ViewController.swift
//  ndimon
//
//  Created by Aaron Granick on 12/6/17.
//  Copyright © 2017 Aaron Granick. All rights reserved.
//

import Cocoa
import NDIKit
import ReSwift

class ViewController: NSViewController, StoreSubscriber {
    typealias StoreSubscriberStateType = AppState

    @IBOutlet weak var tableView: NSTableView!
    
    var sources: [NDISource]?
    let ndiWrapper: NDIWrapper! = NDIWrapper()
    let ndiFinder: NDIFinder = NDIFinder()
    private var timer: Timer?
    
    func newState(state: AppState) {
        // when the state changes, the UI is updated to reflect the current state
        //counterLabel.text = "\(mainStore.state.counter)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        // subscribe to state changes
        mainStore.subscribe(self)

        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
        sources = [NDISource]()
        //ndiFinder.find(didFindSource);
        
//        DispatchQueue.global(qos: .userInitiated).async { // 1
//            //let overlayImage = self.faceOverlayImageFromImage(self.image)
//            DispatchQueue.main.async { // 2
//                print("oh hello");
//                self.ndiFinder.find(self.didFindSource);// 3
//            }
//        }
        
//        let delayInSeconds = 5.0 // 1
//        DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds) { // 2
//            self.ndiFinder.find(self.didFindSource);
//        }
        
        
        timer = Timer.scheduledTimer(timeInterval: 1,
                             target: self,
                             selector: #selector(self.onTimer),
                             userInfo: nil,
                             repeats: true)

    }
    
    @objc func onTimer() {
        // Code here
        print("refresh data bro");
        ndiFinder.find(didFindSource);
        tableView.reloadData()

    }

    @objc func didFindSource(_src:NDISource?) {
        let src = _src!
        print("have a source: \(src.name), \(src.ip)")
        
        sources?.append(src);
        
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
            text = item.ip
            cellIdentifier = CellIdentifiers.DetailseCell
        } else if tableColumn == tableView.tableColumns[2] {
            text = "?"
            cellIdentifier = CellIdentifiers.StatusCell
        }
        
        //NSTableCellView *result = [tableView makeViewWithIdentifier:@NSUserInterfaceItemIdentifier(cellIdentifier) owner:self];
        
        // 3
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(cellIdentifier), owner: self) as? NSTableCellView {
            cell.textField?.stringValue = text
            cell.imageView?.image = image ?? nil
            return cell
        }
        return nil
    }
    
}
