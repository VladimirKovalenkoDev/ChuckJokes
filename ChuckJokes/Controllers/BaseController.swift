//
//  ViewController.swift
//  ChuckJokes
//
//  Created by Владимир Коваленко on 21.01.2021.
//

import UIKit
import SnapKit
// this is a base controller for joke and web controllers
// it makes base of ui for both contollers
class BaseController: UIViewController {
    private var navigation: UIView =  {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
        return view
    }()
    public var tabLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        return label
    }()
    let spinner = UIActivityIndicatorView(style: .medium)
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        view.backgroundColor = .white
    }
    private func setUpView(){
        view.addSubview(navigation)
        view.addSubview(spinner)
        self.navigation.addSubview(tabLabel)
        navigation.snp.makeConstraints { (make) in
            make.top.equalTo(view)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.height.equalTo(88)
        }
        tabLabel.snp.makeConstraints { (make) in
            make.top.equalTo(navigation).offset(56)
            make.centerX.equalTo(navigation)
        }
        spinner.center = view.center
    }
}

