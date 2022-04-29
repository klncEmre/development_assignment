//
//  main.swift
//  assignment_samurai
//
//  Created by EMRE KILINC on 27.04.2022.
//

import Foundation
//First I will get json data with this function



func get_json_data(urlString: String) {
    if let url = URL(string: urlString){
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
        
        task.resume()
    }
    
    
}
//This function will be used to handle error and response in get_json_data function.
func handle(data: Data?, response: URLResponse?, error: Error?){
    if(error != nil){
        print(error!)
        return
    }
    if let safeData = data {
        parseJsonData(itemDataToUse: safeData)
        
        
        
    }
    
}

func parseJsonData(itemDataToUse: Data){ //Function to parse json data to Struct that I have created (itemData)
    let decoder = JSONDecoder()
    do {
        let decodedData = try decoder.decode(itemData.self, from: itemDataToUse)
        calculateCost(itemDataGiven: decodedData)
    }
    catch{
        print(error)
    }
}




get_json_data(urlString: "https://prod-storyly-media.s3.eu-west-1.amazonaws.com/test-scenarios/sample_1.json")


sleep(3)
