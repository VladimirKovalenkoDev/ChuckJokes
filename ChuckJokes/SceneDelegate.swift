//
//  SceneDelegate.swift
//  ChuckJokes
//
//  Created by Владимир Коваленко on 21.01.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let winScene = (scene as? UIWindowScene) else { return }
         window = UIWindow(windowScene: winScene)
         window?.rootViewController = TabBarController()
         window?.makeKeyAndVisible()
    }
}

