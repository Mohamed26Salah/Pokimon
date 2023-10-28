//
//  ContentView.swift
//  Pokimon
//
//  Created by Mohamed Salah on 28/10/2023.
//

import SwiftUI

struct ContentView: View {
    @State var salah: Bool = false
    @State var searchText: String = ""
    @StateObject var pokimonViewModel: PokimonViewModel = PokimonViewModel()
    var body: some View {
        ScrollView {
            VStack {
                    HStack {
                        Text("Pokedex")
                            .font(.title)
                            .bold()
                        Spacer()
                    }
                    HStack {
                        Text("Mohamed Salah Abd Elhalim Omran, djshkadjas")
                            .fontWeight(.medium)
                            .foregroundStyle(.gray)
                        Spacer()
                    }
                    SearchBar(isRefrehDisabled: $salah, searchText: $searchText)
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 17), count: 2), spacing: 43) {
                        ForEach(pokimonViewModel.secoundList, id: \.self) { row in
                            PokimonCard(pokimonName: row)
                        }
                    }
                }
                .padding()
                .onAppear{
                    pokimonViewModel.getResturantMenu()
                }
            }
    }
}
struct SearchBar: View {
    @Binding var isRefrehDisabled: Bool
    @Binding var searchText: String
    var body: some View {
        HStack {
            HStack {
                TextField("Search", text: $searchText)
                    .padding(.leading, 8)
                    .frame(height: 35)
                Spacer()
                Button(action: {
                    searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
                .padding(.trailing, 8)
                
            }
            .background(Color(.systemGray5))
            .cornerRadius(8)
            Button {
              
            } label: {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
            }
            .padding(.trailing, 8)
            if isRefrehDisabled {
                ProgressView()
                    .font(.body)
                    .padding(.trailing, 8)
            } else {
                Button {
                } label: {
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(.gray)
                }
                .disabled(isRefrehDisabled)
                .opacity(isRefrehDisabled ? 0.2 : 1.0)
                .padding(.trailing, 8)
            }
        }
        
    }
}
#Preview {
    ContentView()
}
