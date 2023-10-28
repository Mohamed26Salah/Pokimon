//
//  PokimonCard.swift
//  Pokimon
//
//  Created by Mohamed Salah on 28/10/2023.
//

import SwiftUI

struct PokimonCard: View {
    var color: Color = .green
    var pokimonName: String
    var body: some View {
        ZStack {
            color
            VStack {
                HStack {
                    Text(pokimonName)
                        .padding()
                        .foregroundStyle(.white)
                        .font(.title2)
                    Spacer()
                    Text("Noor")
                        .padding()
                        .foregroundStyle(.white)
                        .font(.title2)
                }
                HStack {
                    
                    Image(systemName: "home")
                }
            }
        }
        .cornerRadius(5)
    }
}
struct GridItemView: View {
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                Color.clear
                ZStack(alignment:.leading) {
                    
                    
                    VStack(alignment: .leading) {
                        HStack(spacing: 2) {
                            Spacer()
                        }
                        .padding(.top, 38)
                        .padding(.leading, 14)
                    }
                    
                }
                .frame(width: 177, height: 167)
            }
        }
    }
}

#Preview {
    PokimonCard(pokimonName: "Charzard")
}
