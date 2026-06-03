//
//  Service.swift
//  harry
//
//  Created by Turma02-22 on 03/06/26.
//


import Foundation
import Combine

struct Service {
    // Função idêntica à página 11 do slide do Hackatruck
    func fetchHaPo(url: URL) -> AnyPublisher<[HaPo], Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [HaPo].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}