//
//  WebViewController.swift
//  World Trotter
//
//  Created by christian espinoza on 7/5/16.
//  Copyright © 2016 Christian Espinoza. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController{
    
    var webView: WKWebView!
    
    override func loadView() {
       let url = NSURL(string: "https://reddit.com")!
       webView = WKWebView()
       webView.loadRequest(NSURLRequest(URL: url))
       view = webView
    }
    
    override func viewDidLoad() {
        // super.viewDidLoad()
        print("WebViewController loaded its view")
    }
    
}
