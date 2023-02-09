//
//  ViewController.swift
//  AutoShot
//
//  Created by Masayuki Akamatsu on 2023/02/08.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let picker = UIImagePickerController()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        openCamera()
    }
    
    func openCamera () {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
            picker.showsCameraControls = false
            picker.allowsEditing = true
            picker.delegate = self
            self.present(picker, animated: false)
            
            NotificationCenter.default.addObserver(self, selector: #selector(self.takePicture), name: NSNotification.Name.AVCaptureSessionDidStartRunning, object: nil)
        }
    }
    
    @objc func takePicture() {
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name.AVCaptureSessionDidStartRunning, object: nil)
        DispatchQueue.main.async {
            Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: { (timer:Timer) in
                self.picker.takePicture()
            })
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
        }
        self.dismiss(animated: false)
        UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
    }
}
