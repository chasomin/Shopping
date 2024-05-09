//
//  ViewModelType.swift
//  Shopping
//
//  Created by 차소민 on 5/9/24.
//

import SwiftUI
import Combine

protocol ViewModelType: AnyObject, ObservableObject {
    associatedtype Input
    associatedtype Output
    
    var cancellables: Set<AnyCancellable> { get }
    var input: Input { get }
    var output: Output { get }
    
    func transform()
}
