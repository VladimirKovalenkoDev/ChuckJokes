//
//  JokeData.swift
//  ChuckJokes
//
//  Created by Владимир Коваленко on 21.01.2021.
//

import Foundation
struct Value: Codable {
    let value: [Joke]
}
struct Joke: Codable {
    let joke : String
}
