import UIKit
//define a UITableViewController subclass named ItemsViewController.
class ItemsViewController: UITableViewController {
    //Adding an ItemStore property
    var itemStore: ItemStore!
    
    override func tableView(_ tableView:UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    override func tableView(_ tableView: UITableView,
            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create an instance of UITableViewCell with default appearance
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
         // Set the text on the cell with the description of the item
            // that is at the nth index of items, where n = row this cell
            // will appear in on the table view
            let item = itemStore.allItems[indexPath.row]

        cell.textLabel?.text = item.name
            cell.detailTextLabel?.text = "$\(item.valueInDollars)"
            return cell
        }
    }

