//
//  ContentView.swift
//  WeSplit
//
//  Created by Mehmet Deniz Cengiz on 9/14/20.
//  Copyright © 2020 Deniz Cengiz. All rights reserved.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    @State private var useRedText = false
    
    
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        
        let peopleCount = Double(numberOfPeople) ?? 2
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        
        let amountPerPerson = grandTotal / peopleCount
        
        
        return amountPerPerson > 0 ? amountPerPerson : 0.00
    }
    
    
    var grandTotal: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        let tipValue = orderAmount / 100 * tipSelection
        
        return orderAmount + tipValue
    }
  
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    TextField("Number of people", text: $numberOfPeople)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("How much tip do you want to leave ?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    } .pickerStyle(SegmentedPickerStyle())
                }.titleStyle()
                
                Section(header: Text( "Amount per person" )
                    .titleStyle()) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
                
                Section(header: Text( "Total amount for the check" )
                    .font(.largeTitle)
                    .foregroundColor(tipPercentages[tipPercentage] == 0 ? Color.red : Color.blue)) {
                    Text("$\(grandTotal, specifier: "%.2f")")
                }
                
                
            } .navigationBarTitle("WeSplit")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}
