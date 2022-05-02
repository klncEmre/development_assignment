//
//  main.swift
//  assignment_samurai
//
//  Created by EMRE KILINC on 27.04.2022.
//

import Foundation

var name: String?

func calculateCostFromJson(urlString: String) {
    //First I will get json data with this function
    if let url = URL(string: urlString){
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
        
        task.resume()
    }
}

//This function will be used to handle error and response in calculateCostFromJson  function.
func handle(data: Data?, response: URLResponse?, error: Error?){
    if(error != nil){
        print(error!)
        return
    }
    if let safeData = data {
        parseJsonData(itemDataToUse: safeData)
    }
}

func parseJsonData(itemDataToUse: Data){ //function to decode the data and print the calculation result. Calculate the cost with decoded data using calculateCost function which has recursive algorithm.
    let decoder = JSONDecoder()
    var cost: Int
    do {
        let decodedData = try decoder.decode(itemData.self, from: itemDataToUse)
        name = decodedData.name
        cost = calculateCost(itemDataGiven: decodedData) //Begin to recursive function here with decoded data.
        let text = "Cost of item " + name! + " is " + String(cost) + " units"
        print(text)
    }
    catch{
        print(error)
    }
}



func calculateCost(itemDataGiven : itemData ) -> Int{ //This function calculate cost recursively.
    
    var localCost = 0

    if let items = itemDataGiven.items{ //check that if it has items or not. If it has items, I will calculate each item's cost with for loop.
        for item in items {
            localCost += calculateCost(itemDataGiven: item)
        }
    }
    else{
        //if it has no item, it must has price property.
        localCost = itemDataGiven.price!
    }
    
    return localCost * itemDataGiven.count
    
}


calculateCostFromJson(urlString: "https://prod-storyly-media.s3.eu-west-1.amazonaws.com/test-scenarios/sample_3.json")


sleep(1)
