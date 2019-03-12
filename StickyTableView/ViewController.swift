//
//  ViewController.swift
//  StickyTableView
//
//  Created by Jonathan French on 11/03/2019.
//  Copyright © 2019 Jaypeeff. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate {
    
    @IBOutlet weak var tblSticky: UITableView!
    
    let dataSource = StickyTableDatasource()
    var myStickyCell : StickyTableCell? = nil
    var myPosView : StickyTableCell?
    var myPoint : CGPoint?
    var mySize : CGSize?
    var myWidth : CGFloat?
    var myPos :CGRect?
    var myRank : Int = 20 // Position on the sticky cell
    var myRowHeight: CGFloat = 70
    var myRankPos : CGFloat?
    private var tableObserver: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up tableView
        tblSticky.register( UINib(nibName: "StickyTableCell",bundle : nil), forCellReuseIdentifier: "StickyTableCell")
        tblSticky.dataSource = dataSource
        dataSource.mypos = myRank
        tblSticky.delegate = self
        tblSticky.rowHeight = myRowHeight
        tblSticky.tableFooterView = nil
        tblSticky.allowsSelection = false
        tblSticky.separatorStyle = .none
        tableObserver = tblSticky.layer.observe(\.bounds) { object, _ in
            self.setMyPosView(y: self.tblSticky.contentOffset.y)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tblSticky.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myWidth = tblSticky.frame.width
        SetMyPos()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tableObserver?.invalidate()
    }
    
    private func setMyPosView (y : CGFloat)
    {
        if let myPosView = myPosView, let myRankPos = myRankPos, var myPos = myPos, var myPoint = myPoint {
            var yPos = y
            if yPos < 0 { yPos = 0 }
            let tableHeight = tblSticky.frame.height
            
            if (myRankPos == 0 && y < 0) {
                myPosView.isHidden = true
                return
            }
            
            if (yPos >= myRankPos) {
                myPoint.y = yPos;
                myPosView.isHidden = false
            } else if (yPos + tableHeight - myRowHeight <= myRankPos) {
                myPoint.y = yPos + tableHeight - myRowHeight
                myPosView.isHidden = false
            } else {
                //hide it as it's already on the screen
                myPosView.isHidden = true
            }
            myPos.origin = myPoint
            myPosView.frame = myPos
        } else {
            SetMyPos ();
        }
    }
    
    private func SetMyPos ()
    {
        guard myWidth != nil && myPosView == nil else { return }
        
        myRankPos = CGFloat(myRank) * myRowHeight
        myPoint = CGPoint (x: 0, y: myRankPos!)
        mySize = CGSize (width : myWidth!, height : myRowHeight )
        myPos = CGRect (origin: myPoint!,size: mySize!);
        
        myStickyCell = (tblSticky.dequeueReusableCell(withIdentifier: "StickyTableCell") as! StickyTableCell)
        if let myStickyCell = myStickyCell {
            myStickyCell.selectionStyle = UITableViewCell.SelectionStyle.none
            myStickyCell.lblPos.text = String(myRank+1)
            myStickyCell.lblPos?.textColor = .black
            myStickyCell.vwBackGround.backgroundColor = UIColor.yellow
            myStickyCell.frame.size = mySize!
            myStickyCell.layoutSubviews()
            myPosView = myStickyCell
            tblSticky.addSubview(myPosView!)
            setMyPosView (y: 0.0)
            print("Setting Cell")
        }
    }
    
}

