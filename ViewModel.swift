//
//  ViewModel.swift
//  harry
//
//  Created by Turma02-22 on 03/06/26.
//


import Foundation
import Combine

class ViewModel: ObservableObject {
    // Variável que avisa a View quando os personagens carregarem (pág. 12 e 14)
    @Published var personagens: [HaPo] = []
    
    private let service = Service()
    private var cancellables = Set<AnyCancellable>()
    
    func fetch() {
        // Endpoint da Grifinória do slide (pág. 13 e 14)
        guard let url = URL(string: "https://hp-api.onrender.com/api/characters/house/gryffindor") else {
            return
        }
        
        service.fetchHaPo(url: url)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }) { [weak self] personagens in
                self?.personagens = personagens
            }
            .store(in: &cancellables)
    }
}