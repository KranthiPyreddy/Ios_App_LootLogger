import UIKit
class DetailViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialNumber: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    //Setting the navigation item’s title
    var item: Item!{
    didSet {
            navigationItem.title = item.name
    }
    }
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()

    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

            nameField.text = item.name
            serialNumber.text = item.serialNumber
            //valueField.text = "\(item.valueInDollars)"
            valueField.text = numberFormatter.string(from: NSNumber(value: item.valueInDollars))
            //dateLabel.text = "\(item.dateCreated)"
            dateLabel.text = dateFormatter.string(from: item.dateCreated)
        }
        override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Clear first responder
                view.endEditing(true)
    
        // "Save" changes to item
        item.name = nameField.text ?? ""
        item.serialNumber = serialNumber.text

        if let valueText = valueField.text,
            let value = numberFormatter.number(from: valueText) {
            item.valueInDollars = value.intValue
        } else {
            item.valueInDollars = 0
        }
    }
    //Dismissing the keyboard upon tapping Return
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
