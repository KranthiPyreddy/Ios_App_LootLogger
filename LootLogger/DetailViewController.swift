import UIKit
class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialNumber: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    //Setting the navigation item’s title
    var item: Item!{
        didSet {
            navigationItem.title = item.name
        }
    }
    var imageStore: ImageStore!
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
        // Get the item key
            let key = item.itemKey
            // If there is an associated image with the item, display it on the image view
            let imageToDisplay = imageStore.image(forKey: key)
            imageView.image = imageToDisplay
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
    
    //Creating an alert controller
    @IBAction func choosePhotoSource(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        //Setting the modal presentation style
        alertController.modalPresentationStyle = .popover
        //Indicating where the popover should point
        alertController.popoverPresentationController?.barButtonItem = sender
        //Adding actions to the action sheet
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default)
            { _ in
                let imagePicker = self.imagePicker(for: .camera)
                self.present(imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(cameraAction)
        }
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default)
        { _ in
            let imagePicker = self.imagePicker(for: .photoLibrary)
            //Presenting the photo library in a popover
            imagePicker.modalPresentationStyle = .popover
            imagePicker.popoverPresentationController?.barButtonItem = sender
            self.present(imagePicker, animated: true, completion: nil)
        }
        alertController.addAction(photoLibraryAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        //Presenting the view controller modally
        present(alertController, animated: true, completion: nil)
    }
    //Adding an image picker controller creation method
    func imagePicker(for sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        return imagePicker
    }
    //Accessing theselected image
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey: Any]) {
        // Get picked image from info dictionary
        let image = info[.originalImage] as! UIImage
      // Store the image in the ImageStore for the item's key
            imageStore.setImage(image, forKey: item.itemKey)
        // Put that image on the screen in the image view
        imageView.image = image
        // Take image picker off the screen - you must call thisdismiss method
        dismiss(animated: true, completion: nil)}
}
