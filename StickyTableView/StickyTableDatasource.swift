//
//  StickyTableDatasource
//  StickyTableView
//
//  Created by Jonathan French on 11/03/2019.
//  Copyright © 2016 Jonathan French. All rights reserved.
//

import UIKit

class StickyTableDatasource: NSObject, UITableViewDataSource {
    
    public var mypos : Int = 0
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : StickyTableCell = tableView.dequeueReusableCell(withIdentifier: "StickyTableCell", for: indexPath as IndexPath) as! StickyTableCell
        cell.lblPos.text =  String(indexPath.row + 1)
        if indexPath.row == mypos
        {
            cell.vwBackGround.backgroundColor = UIColor.yellow
            cell.lblPos.textColor = .black
        }
        else
        {
            cell.vwBackGround.backgroundColor = indexPath.row % 2 == 0 ? UIColor.red : UIColor.purple
            cell.lblPos.textColor = .white
        }
        return cell
    }
    
    
    
}
