//
//  DetalheBruxoView.swift
//  harry
//
//  Created by Turma02-22 on 03/06/26.
//


//
//  DetalheBruxoView.swift
//  harry
//
//  Created by Turma02-22 on 03/06/26.
//

import SwiftUI

struct DetalheBruxoView: View {
    // Recebe o personagem selecionado que veio da lista anterior [cite: 140]
    let personagem: HaPo
    
    var body: some View {
        ZStack {
            // Mantém a identidade visual com o mesmo fundo vermelho
            Color(red: 0.45, green: 0.08, blue: 0.12)
                .ignoresSafeArea()
            
            VStack(spacing: 25) {
                // Foto do personagem grande e arredondada (Conforme pág. 10 do slide) [cite: 191]
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
                .frame(width: 200, height: 200) // Foto expandida
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.yellow.opacity(0.5), lineWidth: 3)) // Borda dourada
                .shadow(radius: 10)
                
                // Card de Informações detalhadas (Mapeando os dados da pág. 10 e 13 do slide) [cite: 197]
                VStack(alignment: .leading, spacing: 14) {
                    Group {
                        Text("**House:** \(personagem.house ?? "Nenhuma")")
                        Text("**Name:** \(personagem.name ?? "Desconhecido")")
                        Text("**Birth:** \(personagem.dateOfBirth ?? "Não informada")")
                        Text("**Eyes:** \(personagem.eyeColour ?? "Não informado")")
                    }
                    .font(.title3)
                    .foregroundColor(.white)
                }
                .padding(25)
                .frame(maxWidth: .infinity, alignment: .leading)
                // Um fundo vermelho um pouco mais escuro para destacar o bloco de texto
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color(red: 0.35, green: 0.05, blue: 0.08))
                )
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .padding(.top, 30)
        }
        // Coloca o nome do próprio bruxo no título do topo
        .navigationBarTitleDisplayMode(.inline)
    }
}
