//
//  Meme_2_0UITests.swift
//  Meme-2.0UITests
//
//  Created by Mayuresh Rao on 11/21/21.
//

import XCTest

class Meme_2_0UITests: XCTestCase {

    func testUserTransitionPlaySoundViewController() throws {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.staticTexts["Tap to record"].exists)
        app.staticTexts["Tap to record"].tap()
        app.buttons["Record"].tap()
        XCTAssertTrue(app.staticTexts["Stop recording..."].exists)

        app.buttons["Stop"].tap()
        
        // Go to play sound screen
        XCTAssertTrue(app.buttons["Slow"].exists)
        XCTAssertTrue(app.buttons["Fast"].exists)
        XCTAssertTrue(app.buttons["HighPitch"].exists)
        XCTAssertTrue(app.buttons["LowPitch"].exists)
        XCTAssertTrue(app.buttons["Echo"].exists)
        XCTAssertTrue(app.buttons["Reverb"].exists)

    }
}
