//
//  WebController.swift
//  ChuckJokes
//
//  Created by Владимир Коваленко on 21.01.2021.
//

import UIKit
import WebKit
class WebController: BaseController {
    private var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        tabLabel.text = "API"
        webView.uiDelegate = self
        setUpWeb()
        loadWeb()
    }
    private func setUpWeb(){
        self.view.backgroundColor = .white
                self.view.addSubview(webView)
                
                NSLayoutConstraint.activate([
                    webView.topAnchor
                        .constraint(equalTo: self.view.topAnchor, constant: 88),
                    webView.leftAnchor
                        .constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
                    webView.bottomAnchor
                        .constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
                    webView.rightAnchor
                        .constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor)
                ])
    }
    private func loadWeb(){
        let myURL = URL(string: "http://www.icndb.com/api/")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}
extension WebController: WKUIDelegate {}
