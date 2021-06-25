//
//  ViewController.swift
//  Example
//
//  Created by yousef mankoulah on 06/24/2021
//
//

import UIKit
import SpeechRecognizerButton

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: SFButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        //button.authorizationErrorHandling = .openSettings(completion: nil)
        button.resultHandler = {
            self.label.text = $1?.bestTranscription.formattedString
            self.button.play()
        }
        button.errorHandler = {
            guard let error = $0 else {
                self.label.text = "Unknown error."
                return
            }
            switch error {
            case .authorization(let reason):
                switch reason {
                case .denied:
                    self.label.text = "Authorization denied."
                case .restricted:
                    self.label.text = "Authorization restricted."
                case .usageDescription(let key):
                    self.label.text = "Info.plist \"\(key)\" key is missing."
                }
            case .cancelled(let reason):
                switch reason {
                case .notFound:
                    self.label.text = "Cancelled, not found."
                case .user:
                    self.label.text = "Cancelled by user."
                }
            case .invalid(let locale):
                self.label.text = "Locale \"\(locale)\" not supported."
            case .unknown(let unknownError):
                self.label.text = unknownError?.localizedDescription
            default:
                self.label.text = error.localizedDescription
            }
        }
    }

}
