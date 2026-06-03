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
        ZStack {
            // Fundo vermelho escuro da Grifinória
            Color(red: 0.45, green: 0.08, blue: 0.12)
                .ignoresSafeArea()
            
            VStack {
                // Logo no topo do app
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
                    // O ForEach lê direto de dentro da ViewModel (pág. 15) [cite: 232]
                    List(viewModel.personagens) { personagem in
                        HStack(spacing: 15) {
                            
                            // Baixa a imagem se ela existir
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
                            // Aumentado de 50 para 75 para acompanhar o novo tamanho do card
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
                        // Ajuste dos Paddings para aumentar o tamanho interno do Card
                        .padding(.vertical, 16)
                        .padding(.horizontal, 12)
                        // Transforma a linha em um card arredondado e estilizado
                        .listRowBackground(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.white.opacity(0.08))
                                .padding(.vertical, 6)     // Espaçamento externo entre cards
                                .padding(.horizontal, 10)   // Distância das bordas da tela
                        )
                        .listRowSeparator(.hidden) // Remove as linhas nativas de divisão do iOS
                    }
                    .listStyle(PlainListStyle()) // Remove as margens cinzas automáticas da List
                    .scrollContentBackground(.hidden) // Força o fundo vermelho a aparecer no scroll
                }
            }
        }
        // Quando a tela aparece, roda o fetch da ViewModel (pág. 15) [cite: 235, 236]
        .onAppear {
            viewModel.fetch()
        }
    }
}

struct DesafioHarryPotter_Previews: PreviewProvider {
    static var previews: some View {
        DesafioHarryPotterView()
    }
}
