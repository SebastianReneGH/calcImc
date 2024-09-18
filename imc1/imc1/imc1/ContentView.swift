//
//  ContentView.swift
//  imc1
//
//  Created by iOS Lab on 17/09/24.
//

import SwiftUI

struct ContentView: View {
    @State private var altura: String = ""
    @State private var peso: String = ""
    @State private var resultado: String = ""
    @State private var gradoObesidad: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Text("índice de masa corporal")
                    .font(.largeTitle)
                    .padding()
                
                Form {
                    Section(header: Text("Datos Personales")) {
                        TextField("Altura (metros)", text: $altura)
                            .keyboardType(.decimalPad)
                        TextField("Peso (kilogramos)", text: $peso)
                            .keyboardType(.decimalPad)
                    }
                    
                    Section {
                        Button(action: calcularIMC) {
                            Text("Calcular")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                    
                    if !resultado.isEmpty {
                        Section(header: Text("Resultado")) {
                            Text(resultado)
                                .font(.title)
                            Text(gradoObesidad)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationTitle("Calculadora IMC")
        }
    }
    
    private func calcularIMC() {
        guard let altura = Double(altura), let peso = Double(peso), altura > 0 else {
            resultado = "Por favor, rellene todos los campos"
            gradoObesidad = ""
            return
        }
        
        let imc = peso / (altura * altura)
        let imcFormateado = String(format: "%.2f", imc)
        
        resultado = "Tu IMC es \(imcFormateado)"
        gradoObesidad = clasificarIMC(imc)
    }
    
    private func clasificarIMC(_ imc: Double) -> String {
        switch imc {
        case ..<18.5:
            return "Bajo peso"
        case 18.5..<24.9:
            return "Peso normal"
        case 25..<29.9:
            return "Sobrepeso"
        case 30...:
            return "Obesidad"
        default:
            return "Ni idea jaja"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
