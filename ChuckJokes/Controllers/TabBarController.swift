//
//  TabBarController.swift
//  ChuckJokes
//
//  Created by Владимир Коваленко on 21.01.2021.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addTabBar()
        setMenuViewControllers()
    }
    // MARK: - making tab bar items
    private func setMenuViewControllers() {
        let jokeController = JokeController()
        jokeController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "Icon"), tag:  0)

        let webController = WebController()
        webController.tabBarItem = UITabBarItem(title: "History", image: UIImage(named: "Icon"), tag:  1)
    
        let tabBarList = [jokeController, webController]
        viewControllers = tabBarList
    }
    private func addTabBar(){
        self.delegate = self
        tabBar.backgroundColor = .white
    }

}
extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
            return true
        }
}
