//
//  Network.swift
//  Shopping
//
//  Created by 차소민 on 5/9/24.
//

import Foundation

enum RequestError: String, Error {
    case failedRequest = "데이터 요청에 실패했습니다"
    case noData = "알맞는 데이터가 존재하지 않습니다"
    case invaildData = "유효하지 않은 데이터입니다"
    case invaildResponse = "유효하지 않은 응답값입니다"
}

final class Network {
    static let shared = Network()
    private init() { }
    
    func callRequest(text: String, start: Int, sort: String) async throws -> Shopping {
        guard let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return Shopping.init(total: 0, start: 0, display: 0, items: [])
        }
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "openapi.naver.com"
        components.path = "/v1/search/shop.json"
        components.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "display", value: "30"),
            URLQueryItem(name: "start", value: "\(start)"),
            URLQueryItem(name: "sort", value: sort)
        ]
        
        guard let url = components.url else {
            print("!@!@에러11")
            throw RequestError.failedRequest
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue(APIKey.clientID, forHTTPHeaderField: "X-Naver-Client-Id")
        urlRequest.setValue(APIKey.clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")

        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
            print("!@!@에러22",response)
            throw RequestError.failedRequest
        }
        
        do {
            let result = try JSONDecoder().decode(Shopping.self, from: data)
            dump(result)
            return result
        } catch {
            throw RequestError.invaildData
        }
    }
}
