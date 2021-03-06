//
//  LoggingIn.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 6/26/20.
//  Copyright © 2020 Sun Asterisk. All rights reserved.
//

import UIKit
import RxSwift

protocol LoggingIn {
    
}

extension LoggingIn {
    func login(dto: LoginDto) -> Observable<Void> {
        if let error = dto.validationError {
            return Observable.error(error)
        }
        
        return Observable.create { observer in
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.5, execute: {
                observer.onNext(())
                observer.onCompleted()
            })
            return Disposables.create()
        }
    }
}
