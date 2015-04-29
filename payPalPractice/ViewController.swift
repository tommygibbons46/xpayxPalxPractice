//
//  ViewController.swift
//  payPalPractice
//
//  Created by Thomas Gibbons on 4/25/15.
//  Copyright (c) 2015 Thomas Gibbons. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PayPalPaymentDelegate, PayPalFuturePaymentDelegate

{
    var config = PayPalConfiguration()
    var resultText = ""
    @IBOutlet weak var successView: UIView!
    
    var environment:String = PayPalEnvironmentNoNetwork
    {
        willSet(newEnvironment)
        {
            if (newEnvironment != environment)
            {
                PayPalMobile.preconnectWithEnvironment(newEnvironment)
            }
        }
    }
    @IBOutlet weak var paymentTextField: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
               // Set up payPalConfig
        config.merchantName = "Tommy's Test Pod"
        config.acceptCreditCards = true
        config.merchantPrivacyPolicyURL = NSURL(string: "https://www.paypal.com/webapps/mpp/ua/privacy-full")
        config.merchantUserAgreementURL = NSURL(string: "https://www.paypal.com/webapps/mpp/ua/useragreement-full")
    }
    
    
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(true);
    }
    
    

    @IBAction func makePaymentButtonTap(sender: UIButton)
    {
        let total = NSDecimalNumber(string: paymentTextField.text)
        let payment = PayPalPayment()
        payment.amount = total;
        payment.currencyCode = "USD"
        payment.shortDescription = "StudyPool Test Payment"
        
        if(!payment.processable)
        {
            println("Payment cannot go through")
        }
        else
        {
            println("Payment is on its way")
            let payPalPayVC = PayPalPaymentViewController(payment: payment, configuration: config, delegate: self)
            presentViewController(payPalPayVC, animated: true, completion: nil)

        }
    }
    
    //pragmaMark PayPalPayment Delegates
    func payPalPaymentDidCancel(paymentViewController: PayPalPaymentViewController!)
    {
        paymentViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    func payPalPaymentViewController(paymentViewController: PayPalPaymentViewController!, didCompletePayment completedPayment: PayPalPayment!)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
        println("\(completedPayment!.description)")
        println("\(completedPayment.confirmation)")
    }
    
    //pragmaMark PayPalFuturePayment Delegates
    
    @IBAction func authorizeFuturePaymentsAction(sender: AnyObject)
    {
        let futurePaymentViewController = PayPalFuturePaymentViewController(configuration: config, delegate: self)
        presentViewController(futurePaymentViewController, animated: true, completion: nil)
    }
    func payPalFuturePaymentDidCancel(futurePaymentViewController: PayPalFuturePaymentViewController!)
    {
        println("PayPal Future Payment Authorizaiton Canceled")
        successView.hidden = true
        futurePaymentViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func payPalFuturePaymentViewController(futurePaymentViewController: PayPalFuturePaymentViewController!, didAuthorizeFuturePayment futurePaymentAuthorization: [NSObject : AnyObject]!)
    {
        println("PayPal Future Payment Authorization Success!")
        // send authorizaiton to your server to get refresh token.
        futurePaymentViewController?.dismissViewControllerAnimated(true, completion: { () -> Void in
            println("\(futurePaymentAuthorization!.description)")
        })
    }
    
    
    
}

