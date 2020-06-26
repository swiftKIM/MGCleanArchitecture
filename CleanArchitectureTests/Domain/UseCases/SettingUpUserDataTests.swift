//
//  SettingUpUserDataTests.swift
//  CleanArchitectureTests
//
//  Created by Tuan Truong on 6/26/20.
//  Copyright © 2020 Sun Asterisk. All rights reserved.
//

@testable import CleanArchitecture
import XCTest
import RxTest

final class SettingUpUserDataTests: XCTestCase, SettingUpUserData {
    var appGateway: AppGatewayType {
        return appGatewayMock
    }
    
    var userGateway: UserGatewayType {
        return userGatewayMock
    }
    
    private var appGatewayMock: AppGatewayMock!
    private var userGatewayMock: UserGatewayMock!
    private var disposeBag: DisposeBag!
    
    // Output Observers
    private var addUserDataOutput: TestableObserver<Void>!

    override func setUpWithError() throws {
        appGatewayMock = AppGatewayMock()
        userGatewayMock = UserGatewayMock()
        disposeBag = DisposeBag()
        
        let testScheduler = TestScheduler(initialClock: 0)
        addUserDataOutput = testScheduler.createObserver(Void.self)
    }
    
    func test_addUserData_firstRun() {
        // arrange
        appGatewayMock.checkFirstRunReturnValue = true

        // act
        self.addUserData().subscribe(addUserDataOutput).disposed(by: disposeBag)

        // assert
        XCTAssert(appGatewayMock.checkFirstRunCalled)
        XCTAssert(userGatewayMock.addCalled)
        XCTAssert(appGatewayMock.setFirstRunCalled)
    }
    
    func test_addUserData_not_firstRun() {
        // arrange
        appGatewayMock.checkFirstRunReturnValue = false

        // act
        self.addUserData().subscribe(addUserDataOutput).disposed(by: disposeBag)

        // assert
        XCTAssert(appGatewayMock.checkFirstRunCalled)
        XCTAssertFalse(userGatewayMock.addCalled)
        XCTAssertFalse(appGatewayMock.setFirstRunCalled)
    }
}
