//
//  Meme_2_0Tests.swift
//  Meme-2.0Tests
//
//  Created by Mayuresh Rao on 11/21/21.
//

import XCTest
@testable import Meme_2_0

class Meme_2_0Tests: XCTestCase {

    var recordVCTest: RecordSoundViewController!

    override func setUp() {

        super.setUp()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.recordVCTest = storyboard.instantiateViewController(withIdentifier: "RecordVC") as? RecordSoundViewController
        
        self.recordVCTest.loadView()
        self.recordVCTest.viewDidLoad()
    }
    
    override class func tearDown() {
    }

    func testRecordLabelInitialText(){
        XCTAssertEqual(recordVCTest.recordingLabel.text, "Tap to record")
        XCTAssertEqual(recordVCTest.stopRecordingButton.isEnabled, false)
    }
    
    func testRecordLabelTextWhenRecordingStarted(){
        let button: UIButton = UIButton()
        recordVCTest.recordButton(button)
        XCTAssertEqual(recordVCTest.recordingLabel.text, "Stop recording...")
        XCTAssertEqual(recordVCTest.recordButton.isEnabled, false)
    }
    
    override func tearDown() {
        super.tearDown()
    }
}
