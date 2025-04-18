//
//  ContentView.swift
//  WeSplit
//
//  Created by Gabriel Santos on 23/03/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    @FocusState var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    let localeCurrencyText = Locale.current.currency?.identifier ?? "BRL"
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalAmountWithTip: Double {
        
        let tipValue = checkAmount / 100 * Double(tipPercentage)
        let total = checkAmount + tipValue
        
        return total
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: localeCurrencyText))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("How much money do you want to tip?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: localeCurrencyText))
                        
                }
                
                Section("Total amount with the tip") {
                    Text(totalAmountWithTip, format: .currency(code: localeCurrencyText))
                        .foregroundStyle(tipPercentage == 0 ? .red : .black)
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
