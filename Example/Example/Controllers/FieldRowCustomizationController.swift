//
//  FieldRowCustomizationController.swift
//  Example
//
//  Created by Mathias Claassen on 3/15/18.
//  Copyright © 2018 Xmartlabs. All rights reserved.
//

import Eureka

class FieldRowCustomizationController : FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        form +++
            Section(header: "Default field rows", footer: "Rows with title have a right-aligned text field.\nRows without title have a left-aligned text field.\nBut this can be changed...")

            <<< NameRow() {
                $0.title = "Your name:"
                $0.placeholder = "(right alignment)"
                }
                .cellSetup { cell, row in
                    cell.imageView?.image = UIImage(named: "plus_image")
            }

            <<< NameRow() {
                $0.placeholder = "Name (left alignment)"
                }
                .cellSetup { cell, row in
                    cell.imageView?.image = UIImage(named: "plus_image")
            }

            +++ Section("Customized Alignment")

            <<< NameRow() {
                $0.title = "Your name:"
                }.cellUpdate { cell, row in
                    cell.textField.textAlignment = .left
                    cell.textField.placeholder = "(left alignment)"
            }

            <<< NameRow().cellUpdate { cell, row in
                cell.textField.textAlignment = .right
                cell.textField.placeholder = "Name (right alignment)"
            }

            +++ Section(header: "Customized Text field width", footer: "Eureka allows us to set up a specific UITextField width using textFieldPercentage property. In the section above we have also right aligned the textLabels.")

            <<< NameRow() {
                $0.title = "Title"
                $0.titlePercentage = 0.4
                $0.placeholder = "textFieldPercentage = 0.6"
                }
                .cellUpdate {
                    $1.cell.textField.textAlignment = .left
                    $1.cell.textLabel?.textAlignment = .right
            }
            <<< NameRow() {
                $0.title = "Another Title"
                $0.titlePercentage = 0.4
                $0.placeholder = "textFieldPercentage = 0.6"
                }
                .cellUpdate {
                    $1.cell.textField.textAlignment = .left
                    $1.cell.textLabel?.textAlignment = .right
            }
            <<< NameRow() {
                $0.title = "One more"
                $0.titlePercentage = 0.3
                $0.placeholder = "textFieldPercentage = 0.7"
                }
                .cellUpdate {
                    $1.cell.textField.textAlignment = .left
                    $1.cell.textLabel?.textAlignment = .right
            }

            +++ Section("TextAreaRow")

            <<< JFTextAreaRow() {
                $0.placeholder = "请填写请假内容，如有需要可添加照片。"
                $0.title = "请假事由"
                $0.textAreaHeight = .dynamic(initialTextViewHeight: 40)
                $0.count = 140
                }.cellUpdate({ [weak self](cell, row) in
                    cell.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                    cell.titleLabel?.textColor = .red
                    cell.textView.textContainerInset = UIEdgeInsets.init(top: 34, left: 0, bottom: 0, right: 0)
                    cell.textView.font = UIFont.systemFont(ofSize: 14)
                    cell.placeholderLabel?.textColor = .gray
                    cell.placeholderLabel?.font = UIFont.systemFont(ofSize: 14)
                    cell.countLabel?.font = UIFont.systemFont(ofSize: 14)
                    
                }).onChange({ (row) in
                    row.cell.countLabel?.text = "限\(140 - (row.value?.count ?? 0))字"
                })
            
            
            <<< TextAreaRow() {
                $0.value = "You also have scrollable read only textAreaRows! I have to write a big text so you will be able to scroll a lot and see that this row is scrollable. I think it is a good idea to insert a Lorem Ipsum here: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla ac odio consectetur, faucibus elit at, congue dolor. Duis quis magna eu ante egestas laoreet. Vivamus ultricies tristique porttitor. Proin viverra sem non turpis molestie, volutpat facilisis justo rutrum. Nulla eget commodo ligula. Aliquam lobortis lobortis justo id fermentum. Sed sit amet elit eu ipsum ultricies porttitor et sed justo. Fusce id mi aliquam, iaculis odio ac, tempus sem. Aenean in eros imperdiet, euismod lacus vitae, mattis nulla. Praesent ornare sem vitae ornare efficitur. Nullam dictum tortor a tortor vestibulum pharetra. Donec sollicitudin varius fringilla. Praesent posuere fringilla tristique. Aliquam dapibus vel nisi in sollicitudin. In eu ligula arcu."
                $0.textAreaMode = .readOnly
                $0.textAreaHeight = .fixed(cellHeight: 110)
        }

    }

    override open func textInputDidChange<T>(_ textInput: UITextInput, cell: Cell<T>) {
        if let textView = textInput as? UITextView ,textView.text.count >= 140{
            textView.text = (textView.text as NSString).substring(to: 140)
        }
    }

    
    
}
