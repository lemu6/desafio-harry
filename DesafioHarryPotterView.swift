//
//  DesafioHarryPotterView.swift
//  harry
//
//  Created by Turma02-22 on 03/06/26.
//

import SwiftUI

struct DesafioHarryPotterView: View {
    // Instanciando a nossa ViewModel padrão MVVM (pág. 15) [cite: 126, 230]
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        // Ativa a capacidade de navegar entre telas no iOS
        NavigationStack {
            ZStack {
                // Fundo vermelho escuro da Grifinória
                Color(red: 0.45, green: 0.08, blue: 0.12)
                    .ignoresSafeArea()
                
                VStack {
                    // Logo no topo do app [cite: 144, 191]
                    Image("logo_harry")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .padding(.top, 10)
                    
                    if viewModel.personagens.isEmpty {
                        Spacer()
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        Text("Carregando com Combine...")
                            .foregroundColor(.white.opacity(0.6))
                            .padding()
                        Spacer()
                    } else {
                        // A List lê os dados da ViewModel [cite: 133, 232]
                        List(viewModel.personagens) { personagem in
                            
                            // O NavigationLink transforma o card em um botão clicável que leva para a tela de detalhes
                            NavigationLink(destination: DetalheBruxoView(personagem: personagem)) {
                                HStack(spacing: 15) {
                                    
                                    // CORRIGIDO: personagem (com "gm") em todos os lugares
                                    AsyncImage(url: URL(string: personagem.image ?? "")) { phase in
                                        switch phase {
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFill()
                                        case .failure, .empty:
                                            Image(systemName: "person.circle.fill")
                                                .resizable()
                                                .foregroundColor(.white.opacity(0.3))
                                        @unknown default:
                                            EmptyView()
                                        }
                                    }
                                    .frame(width: 75, height: 75)
                                    .clipShape(Circle())
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(personagem.name ?? "Sem Nome")
                                            .font(.title3)
                                            .fontWeight(.bold)
                                            .foregroundColor(.orange)
                                        
                                       
                                    }
                                    
                                    Spacer()
                                }
                                .padding(.vertical, 16)
                                .padding(.horizontal, 12)
                            }
                            // Estilização em formato de Card Arredondado
                            .listRowBackground(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.white.opacity(0.08))
                                    .padding(.vertical, 6)     // Espaçamento entre cards
                                    .padding(.horizontal, 10)   // Distância das bordas
                            )
                            .listRowSeparator(.hidden) // Esconde a linha divisória nativa
                        }
                        .listStyle(PlainListStyle()) // Remove margens cinzas da lista
                        .scrollContentBackground(.hidden) // Mostra o vermelho de fundo no scroll
                    }
                }
            }
            // Quando a tela aparece, roda o fetch da ViewModel (pág. 15) [cite: 235, 236]
            .onAppear {
                viewModel.fetch()
            }
        }
        // Deixa a setinha de voltar e os botões de navegação na cor branca
        .accentColor(.white)
    }
}

struct DesafioHarryPotter_Previews: PreviewProvider {
    static var previews: some View {
        DesafioHarryPotterView()
    }
}
