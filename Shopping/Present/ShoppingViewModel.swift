//
//  ShoppingViewModel.swift
//  Shopping
//
//  Created by 차소민 on 5/9/24.
//

import Foundation
import Combine

final class ShoppingViewModel: ViewModelType {
    
    var cancellables = Set<AnyCancellable>()
    var input = Input()
    @Published var output = Output()
    
    init() {
        transform()
    }
}

extension ShoppingViewModel {
    struct Input {
        let viewOnAppear = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var shoppingData: Shopping = .init(total: 0, start: 0, display: 0, items: [])
    }
    
    func transform() {
        input.viewOnAppear
            .sink { [weak self] _ in
                guard let self else { return }
                Task {
                    try? await self.fetchShoppingList()
                }
            }
            .store(in: &cancellables)

    }
    
    func fetchShoppingList() async throws {
        do {
            output.shoppingData = try await Network.shared.callRequest(text: "apple", start: 1, sort: "sim")
        } catch {
            output.shoppingData = .init(total: 0, start: 0, display: 0, items: [])
            guard let error = error as? RequestError else { return }
            print(error.rawValue)
        }
    }
}
