//
//  RecordSoundViewController.swift
//  Meme-2.0
//
//  Created by Mayuresh Rao on 11/21/21.
//

import UIKit
import AVFoundation
class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {

    // MARK: Outlets

    @IBOutlet var stopRecordingButton: UIButton!
    @IBOutlet var recordButton: UIButton!
    @IBOutlet var recordingLabel: UILabel!
    
    // MARK: Properties
    
    var audioRecorder: AVAudioRecorder!
    let segueIdentifier = "stopRecording"

    // MARK: LifeCycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: Actions
    
    @IBAction func recordButton(_ sender: Any) {

        enableStopRecordButton()
    
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))

        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)

        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    

    @IBAction func stopRecordingButton(_ sender: Any) {
        
        enableRecordButton()
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)


    }
    
    // MARK: Helper functions
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: segueIdentifier , sender: audioRecorder.url)
        } else {
            showAlert(Alerts.AudioRecorderError, message: Alerts.RecordingFailedMessage)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            let playSoundVC = segue.destination as! PlaySoundViewController
            let recordedAudioURL = sender as! URL
            playSoundVC.recordedAudioURL =  recordedAudioURL
        }
    }
    
    func configureUI() {
        stopRecordingButton.isEnabled = false
        recordingLabel.text = Alerts.tapToRecord
    }
    
    func enableStopRecordButton(){
        stopRecordingButton.isEnabled = true
        recordButton.isEnabled = false
        recordingLabel.text = Alerts.stopRecording
    }
    
    func enableRecordButton(){
        stopRecordingButton.isEnabled = false
        recordButton.isEnabled = true
        recordingLabel.text = Alerts.startRecording
    }
}

// MARK: RecordSoundViewController Extensiong

extension RecordSoundViewController {
    
    // MARK: Alerts
    
    struct Alerts {
        static let DismissAlert = "Dismiss"
        static let RecordingFailedMessage = "Something went wrong with your recording."
        static let AudioRecorderError = "Audio Recorder Error"
        static let tapToRecord = "Tap to record"
        static let stopRecording = "Stop recording..."
        static let startRecording = "Tap to record"

    }
    
    func showAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Alerts.DismissAlert, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

