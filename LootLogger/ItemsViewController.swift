import UIKit
//define a UITableViewController subclass named ItemsViewController.
class ItemsViewController: UITableViewController {
    //Adding an ItemStore property
    var itemStore: ItemStore!
    //Adding two button action methods
    
    @IBAction func addNewItem(_ sender: UIButton) {
        /* Make a new index path for the 0th section, last row
         let lastRow = tableView.numberOfRows(inSection: 0)
         let indexPath = IndexPath(row: lastRow, section: 0)
         
         // Insert this new row into the table
         tableView.insertRows(at: [indexPath], with: .automatic)*/
        // Create a new item and add it to the store
        let newItem = itemStore.createItem()
        
        // Figure out where that item is in the array
        if let index = itemStore.allItems.firstIndex(of: newItem){
            let indexPath = IndexPath(row: index, section: 0)
            
            // Insert this new row into the table
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    @IBAction func toggleEditingMode(_ sender: UIButton) {
        // If you are currently in editing mode...
        if isEditing {
            // Change text of button to inform user of state
            sender.setTitle("Edit", for: .normal)
            
            // Turn off editing mode
            setEditing(false, animated: true)
        } else {
            // Change text of button to inform user of state
            sender.setTitle("Done", for: .normal)
            
            // Enter editing mode
            setEditing(true, animated: true)
        }
    }
    override func tableView(_ tableView:UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create an instance of UITableViewCell with default appearance
        //let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        // Get a new or recycled cell
        /*let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell",
                                                 for: indexPath)*/
        
        //Dequeuing ItemCell instances
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell",
                                                     for: indexPath) as! ItemCell
        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear in on the table view
        let item = itemStore.allItems[indexPath.row]
        
        // Configure the cell with the Item
            cell.nameLabel.text = item.name
            cell.serialNumberLabel.text = item.serialNumber
            cell.valueLabel.text = "$\(item.valueInDollars)"
        return cell
    }
    //“Implementing table view row deletion”
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        // If the table view is asking to commit a delete command...
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.row]
            
            // Remove the item from the store
            itemStore.removeItem(item)
            
            // Also remove that row from the table view with an animation
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    //Implementing table view row reordering
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath,to destinationIndexPath: IndexPath)
    {
        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //tableView.rowHeight = 65
        tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 65
    }
}

