//
//  ViewController.swift
//  CameraRollSwift
//
//  Created by Namit on 7/13/16.
//  Copyright © 2016 Namit. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let picker = UIImagePickerController()
    var selectedImage:UIImage?{
        didSet{
            imageView.image = selectedImage
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func fromCameraClicked(sender: AnyObject) {
        guard UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) else{
            showAlertWithTitle("Error", message: "No camera availabe.")
            return
        }
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(picker, animated: true, completion: nil)
    }
    
    @IBAction func fromLibraryClicked(sender: AnyObject) {
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(picker, animated: true, completion: nil)
    }
    
    @IBAction func saveToLibraryClicked(sender: AnyObject) {
        if let selectedImage = selectedImage {
            UIImageWriteToSavedPhotosAlbum(selectedImage, self,#selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }
    
   func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafePointer<Void>){
        guard error == nil else{
            showAlertWithTitle("Error", message: error!.localizedDescription)
            return
        }
     showAlertWithTitle(nil, message: "Image Saved")
    }
    
    func showAlertWithTitle(title:String?, message:String?){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    //Mark: UIImagePickerControllerDelegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let selectedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        self.selectedImage = selectedImage
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}

