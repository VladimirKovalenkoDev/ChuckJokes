//
//  Network.swift
//  ChuckJokes
//
//  Created by Владимир Коваленко on 21.01.2021.
//

import Foundation
protocol SearchManagerDelegate {
    func didSearch(_ searchManager : SearchManager, searchItems: Value)
    func didFailWithError (error: Error )
}

struct SearchManager  {
    var delegate : SearchManagerDelegate?
    
    func loadJokes(number: String) {
        let urlString = "http://api.icndb.com/jokes/random/\(number)"
        performRequest(with: urlString)
        print(urlString)
        
    }
    func performRequest(with urlString: String){
        // create url
        if let url = URL(string: urlString) {// it is optional cos it can be an error
          // create url session
            let session = URLSession(configuration: .default)
            // GIVE THE session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                   if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                         return
                     }
                     if let safeData = data {
                        if  let searchItems = self.parseJSON(safeData){
                           self.delegate?.didSearch(self , searchItems: searchItems)
                        }
                     }
                 }
            // start the task
            task.resume()
            }

        }
    func parseJSON(_ searchData: Data) -> Value? {
        let decoder = JSONDecoder()// create decoder
        do {
            //decoding
      let decodeData = try decoder.decode(Value.self, from: searchData)
            let results = decodeData.value
            let searchItems  = Value(value: results)
            return searchItems
        }catch{
           delegate?.didFailWithError(error: error  )
            return nil
            }
        }
    
    }
    

