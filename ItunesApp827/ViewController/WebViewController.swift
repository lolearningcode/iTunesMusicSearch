//
//  WebViewController.swift
//  ItunesApp827
//
//  Created by mac on 9/11/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let webView = WKWebView()
    var viewModel: ViewModel!
    
    override func loadView() {
        super.loadView()
        
        webView.addSubview(loadingView)
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWeb()
       
    }
    
    
    private func setupWeb() {
        activityIndicator.startAnimating()
        loadingView.layer.cornerRadius = 25
        
        guard let url = URL(string:"https://google.com") else { return }
        
        let request = URLRequest(url: url)
        webView.load(request) //load a website
        
        webView.navigationDelegate = self
        webView.uiDelegate = self
    }


}

extension WebViewController: WKNavigationDelegate, WKUIDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
        loadingView.isHidden = true
    }
    
    
}
