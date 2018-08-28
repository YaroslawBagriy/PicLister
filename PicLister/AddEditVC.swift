//
//  AddEditVC.swift
//  PicLister
//
//  Created by Yaroslaw Bagriy on 1/31/16.
//

import UIKit
import CoreData

class AddEditVC: UIViewController, NSFetchedResultsControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var picture : Picture? = nil
    
    @IBOutlet weak var picTitle: UITextField!
    @IBOutlet weak var picLocation: UITextField!
    @IBOutlet weak var placeholderImage: UIImageView!
    
    let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if picture != nil {
            
            picTitle.text = picture?.title
            picLocation.text = picture?.location
            placeholderImage.image = UIImage(data: (picture?.image)!)
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancelTapped(sender: AnyObject) {
        
        dismissVC()
        
    }

    @IBAction func saveTapped(sender: AnyObject) {
        
        if picture != nil {
            editPicture()
        } else {
            createNewPicture()
        }
        
        dismissVC()
        
    }
    
    @IBAction func addImageFromDevice(sender: AnyObject) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        pickerController.allowsEditing = true
        
        self.presentViewController(pickerController, animated: true, completion: nil)
        
    }
    
    @IBAction func addImageFromCamera(sender: AnyObject) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.Camera
        pickerController.allowsEditing = true
        
        self.presentViewController(pickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        self.placeholderImage.image = image
    }
    
    func dismissVC() {
        
        navigationController?.popToRootViewControllerAnimated(true)
        
    }
    
    func createNewPicture() {
        
        let entityDescription = NSEntityDescription.entityForName("Picture", inManagedObjectContext: moc)
        
        let picture = Picture(entity: entityDescription!, insertIntoManagedObjectContext: moc)
        
        picture.title = picTitle.text
        picture.location = picLocation.text
        picture.image = UIImagePNGRepresentation(placeholderImage.image!)
        
        do {
            try moc.save()
        } catch {
            print("Error saving picture.")
            return
        }
        
    }
    
    func editPicture() {
        
        picture?.title = picTitle.text
        picture?.location = picLocation.text
        picture?.image = UIImagePNGRepresentation(placeholderImage.image!)
        
        do {
            try moc.save()
        } catch {
            print("Error saving picture.")
            return
        }
        
    }
    
}













