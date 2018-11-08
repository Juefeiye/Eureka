//
//  RowsExample.swift
//  Example
//
//  Created by Mathias Claassen on 3/15/18.
//  Copyright © 2018 Xmartlabs. All rights reserved.
//

import CoreLocation
import Eureka

//Mark: RowsExampleViewController

class RowsExampleViewController: FormViewController {

    let titles = ["请假人：*","请假类型：*","开始时间：*","结束时间：*","请假事由：","审批人：",]
    
    func getAttributTitle(_ title:String) -> NSAttributedString{
        let att = NSMutableAttributedString(string: title)
        att.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.red], range: NSRange.init(location: title.count-1, length: 1))
        att.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.gray], range: NSRange.init(location: 0, length: title.count-1))
        return att
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        URLRow.defaultCellUpdate = { cell, row in cell.textField.textColor = .blue }
        LabelRow.defaultCellUpdate = { cell, row in cell.detailTextLabel?.textColor = .orange  }
        CheckRow.defaultCellSetup = { cell, row in cell.tintColor = .orange }
        DateRow.defaultRowInitializer = { row in row.minimumDate = Date() }

        form +++
            
            Section()
            
            <<< PickerInputRow<String>("Name"){
                $0.title = titles[0]
                $0.options = ["陈安之","陈来之"]
                $0.value = $0.options.first
                }.cellUpdate({[weak self] (cell, row) in
                    cell.textLabel?.attributedText = self!.getAttributTitle(self!.titles[0])
                    cell.accessoryType = .disclosureIndicator
                    cell.detailTextLabel?.textColor = .red
                    cell.height = { 55 }
                })
            
            <<< PickerInputRow<String>("Action"){
                $0.title = titles[1]
                $0.options = ["事假","病假"]
                $0.value = $0.options.first
                }.cellUpdate({[weak self] (cell, row) in
                    cell.textLabel?.attributedText = self!.getAttributTitle(self!.titles[1])
                    cell.accessoryType = .disclosureIndicator
                    cell.detailTextLabel?.textColor = .red
                    cell.height = { 55 }
                })
            
            <<< DateTimeRow("Starts") {
                $0.title = titles[2]
                $0.value = Date()
                let formatter = DateFormatter()
                formatter.dateStyle = .short
                formatter.dateFormat = "yyyy-MM-dd HH:00"
                $0.dateFormatter = formatter
                }.onChange { [weak self] row in
                    let endRow: DateTimeRow! = self?.form.rowBy(tag: "Ends")
                    if row.value?.compare(endRow.value!) == .orderedDescending {
                        endRow.value = Date(timeInterval: 60*60*24, since: row.value!)
                        endRow.cell!.backgroundColor = .white
                        endRow.updateCell()
                    }
                }.cellUpdate({[weak self] (cell, row) in
                    cell.textLabel?.attributedText = self!.getAttributTitle(self!.titles[2])
                    cell.accessoryType = .disclosureIndicator
                    cell.datePicker.locale = Locale(identifier: "zh_CN")
                    cell.detailTextLabel?.textColor = .red
                    cell.height = { 55 }
                })
            
            <<< DateTimeRow("Ends"){
                $0.title = titles[3]
                $0.value = Date()
                let formatter = DateFormatter()
                formatter.dateStyle = .short
                formatter.dateFormat = "yyyy-MM-dd HH:00"
                $0.dateFormatter = formatter
                }.onChange { [weak self] row in
                    let startRow: DateTimeRow! = self?.form.rowBy(tag: "Starts")
                    if row.value?.compare(startRow.value!) == .orderedAscending {
                        row.cell!.backgroundColor = .red
                    }
                    else{
                        row.cell!.backgroundColor = .white
                    }
                    row.updateCell()
                }.cellUpdate({[weak self] (cell, row) in
                    cell.textLabel?.attributedText = self!.getAttributTitle(self!.titles[3])
                    cell.accessoryType = .disclosureIndicator
                    cell.datePicker.locale = Locale(identifier: "zh_CN")
                    cell.detailTextLabel?.textColor = .red
                    cell.height = { 55 }
                })
            
            +++ Section()
            
            <<< TextAreaRow("Text") {
                $0.placeholder = "请假事由："
                $0.textAreaHeight = .dynamic(initialTextViewHeight: 55)
                }.cellUpdate({ (cell, row) in
                    cell.textView.textContainerInset = UIEdgeInsets.init(top: 0, left: 100, bottom: 0, right: 0)
                    cell.placeholderLabel?.textColor = .gray
                })

            +++ Section()

            <<< LabelRow () {
                $0.title = "LabelRow"
                $0.value = "tap the row"
                }
                .onCellSelection { cell, row in
                    row.title = (row.title ?? "") + " 🇺🇾 "
                    row.reload() // or row.updateCell()
            }

            <<< DateRow() { $0.value = Date(); $0.title = "DateRow" }

            <<< CheckRow() {
                $0.title = "CheckRow"
                $0.value = true
            }

            <<< SwitchRow() {
                $0.title = "SwitchRow"
                $0.value = true
            }

            <<< SliderRow() {
                $0.title = "SliderRow"
                $0.value = 5.0
            }
            .cellSetup { cell, row in
                cell.imageView?.image = #imageLiteral(resourceName: "selected")
            }

            <<< StepperRow() {
                $0.title = "StepperRow"
                $0.value = 1.0
            }

            +++ Section("SegmentedRow examples")

            <<< SegmentedRow<String>() { $0.options = ["One", "Two", "Three"] }

            <<< SegmentedRow<Emoji>(){
                $0.title = "Who are you?"
                $0.options = [💁🏻, 🍐, 👦🏼, 🐗, 🐼, 🐻 ]
                $0.value = 🍐
            }

            <<< SegmentedRow<String>(){
                $0.title = "SegmentedRow"
                $0.options = ["One", "Two"]
                }.cellSetup { cell, row in
                    cell.imageView?.image = UIImage(named: "plus_image")
            }

            <<< SegmentedRow<String>(){
                $0.options = ["One", "Two", "Three", "Four"]
                $0.value = "Three"
                }.cellSetup { cell, row in
                    cell.imageView?.image = UIImage(named: "plus_image")
            }

            <<< SegmentedRow<UIImage>(){
                let names = ["selected", "plus_image", "unselected"]
                $0.options = names.map { UIImage(named: $0)! }
                $0.value = $0.options?.last
            }

            +++ Section("Selectors Rows Examples")

            <<< ActionSheetRow<String>() {
                $0.title = "ActionSheetRow"
                $0.selectorTitle = "Your favourite player?"
                $0.options = ["Diego Forlán", "Edinson Cavani", "Diego Lugano", "Luis Suarez"]
                $0.value = "Luis Suarez"
                }
                .onPresent { from, to in
                    to.popoverPresentationController?.permittedArrowDirections = .up
            }

            <<< AlertRow<Emoji>() {
                $0.title = "AlertRow"
                $0.cancelTitle = "Dismiss"
                $0.selectorTitle = "Who is there?"
                $0.options = [💁🏻, 🍐, 👦🏼, 🐗, 🐼, 🐻]
                $0.value = 👦🏼
                }.onChange { row in
                    print(row.value ?? "No Value")
                }
                .onPresent{ _, to in
                    to.view.tintColor = .purple
            }

            <<< PushRow<Emoji>() {
                $0.title = "PushRow"
                $0.options = [💁🏻, 🍐, 👦🏼, 🐗, 🐼, 🐻]
                $0.value = 👦🏼
                $0.selectorTitle = "Choose an Emoji!"
                }.onPresent { from, to in
                    to.dismissOnSelection = false
                    to.dismissOnChange = false
            }

            <<< PushRow<Emoji>() {
                $0.title = "SectionedPushRow"
                $0.options = [💁🏻, 🍐, 👦🏼, 🐗, 🐼, 🐻]
                $0.value = 👦🏼
                $0.selectorTitle = "Choose an Emoji!"
                }.onPresent { from, to in
                    to.dismissOnSelection = false
                    to.dismissOnChange = false
                    to.sectionKeyForValue = { option in
                        switch option {
                        case 💁🏻, 👦🏼: return "People"
                        case 🐗, 🐼, 🐻: return "Animals"
                        case 🍐: return "Food"
                        default: return ""
                        }
                    }
            }
            <<< PushRow<Emoji>() {
                $0.title = "LazySectionedPushRow"
                $0.value = 👦🏼
                $0.selectorTitle = "Choose a lazy Emoji!"
                $0.optionsProvider = .lazy({ (form, completion) in
                    let activityView = UIActivityIndicatorView(style: .gray)
                    form.tableView.backgroundView = activityView
                    activityView.startAnimating()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                        form.tableView.backgroundView = nil
                        completion([💁🏻, 🍐, 👦🏼, 🐗, 🐼, 🐻])
                    })
                })
                }
                .onPresent { from, to in
                    to.sectionKeyForValue = { option -> String in
                        switch option {
                        case 💁🏻, 👦🏼: return "People"
                        case 🐗, 🐼, 🐻: return "Animals"
                        case 🍐: return "Food"
                        default: return ""
                        }
                    }
        }

            <<< PushRow<Emoji>() {
                $0.title = "Custom Cell Push Row"
                $0.options = [💁🏻, 🍐, 👦🏼, 🐗, 🐼, 🐻]
                $0.value = 👦🏼
                $0.selectorTitle = "Choose an Emoji!"
                }
                .onPresent { from, to in
                    to.selectableRowSetup = { row in
                        row.cellProvider = CellProvider<ListCheckCell<Emoji>>(nibName: "EmojiCell", bundle: Bundle.main)
                    }
                    to.selectableRowCellUpdate = { cell, row in
                        var detailText: String?
                        switch row.selectableValue {
                        case 💁🏻, 👦🏼: detailText = "Person"
                        case 🐗, 🐼, 🐻: detailText = "Animal"
                        case 🍐: detailText = "Food"
                        default: detailText = ""
                        }
                        cell.detailTextLabel?.text = detailText
                    }
        }


        if UIDevice.current.userInterfaceIdiom == .pad {
            let section = form.last!

            section <<< PopoverSelectorRow<Emoji>() {
                $0.title = "PopoverSelectorRow"
                $0.options = [💁🏻, 🍐, 👦🏼, 🐗, 🐼, 🐻]
                $0.value = 💁🏻
                $0.selectorTitle = "Choose an Emoji!"
            }
        }

        let section = form.last!

        section
            <<< LocationRow(){
                $0.title = "LocationRow"
                $0.value = CLLocation(latitude: -34.91, longitude: -56.1646)
            }

            <<< ImageRow(){
                $0.title = "ImageRow"
            }

            <<< MultipleSelectorRow<Emoji>() {
                $0.title = "MultipleSelectorRow"
                $0.options = [💁🏻, 🍐, 👦🏼, 🐗, 🐼, 🐻]
                $0.value = [👦🏼, 🍐, 🐗]
                }
                .onPresent { from, to in
                    to.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: from, action: #selector(RowsExampleViewController.multipleSelectorDone(_:)))
            }

            <<< MultipleSelectorRow<Emoji>() {
                $0.title = "SectionedMultipleSelectorRow"
                $0.options = [💁🏻, 🍐, 👦🏼, 🐗, 🐼, 🐻]
                $0.value = [👦🏼, 🍐, 🐗]
                }
                .onPresent { from, to in
                    to.sectionKeyForValue = { option in
                        switch option {
                        case 💁🏻, 👦🏼: return "People"
                        case 🐗, 🐼, 🐻: return "Animals"
                        case 🍐: return "Food"
                        default: return ""
                        }
                    }
                    to.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: from, action: #selector(RowsExampleViewController.multipleSelectorDone(_:)))
            }
            <<< MultipleSelectorRow<Emoji>() {
                $0.title = "LazyMultipleSelectorRow"
                $0.value = [👦🏼, 🍐, 🐗]
                $0.optionsProvider = .lazy({ (form, completion) in
                    let activityView = UIActivityIndicatorView(style: .gray)
                    form.tableView.backgroundView = activityView
                    activityView.startAnimating()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                        form.tableView.backgroundView = nil
                        completion([💁🏻, 🍐, 👦🏼, 🐗, 🐼, 🐻])
                    })
                })
                }.onPresent { from, to in
                    to.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: from, action: #selector(RowsExampleViewController.multipleSelectorDone(_:)))
        }

        form +++ Section("Generic picker")

            <<< PickerRow<String>("Picker Row") { (row : PickerRow<String>) -> Void in

                row.options = []
                for i in 1...10{
                    row.options.append("option \(i)")
                }
            }

            <<< PickerInputRow<String>("Picker Input Row"){
                $0.title = "Options"
                $0.options = []
                for i in 1...10{
                    $0.options.append("option \(i)")
                }
                $0.value = $0.options.first
            }
            
            <<< DoublePickerInlineRow<String, Int>() {
                $0.title = "2 Component picker"
                $0.firstOptions = { return ["a", "b", "c"]}
                $0.secondOptions = { _ in return [1, 2, 3]}
            }
            <<< TriplePickerInputRow<String, String, Int>() {
                $0.firstOptions = { return ["a", "b", "c"]}
                $0.secondOptions = { return [$0, $0 + $0, $0 + "-" + $0, "asd"]}
                $0.thirdOptions = { _,_ in return [1, 2, 3]}
                $0.title = "3 Component picker"
            }

            +++ Section("FieldRow examples")

            <<< TextRow() {
                $0.title = "TextRow"
                $0.placeholder = "Placeholder"
            }

            <<< DecimalRow() {
                $0.title = "DecimalRow"
                $0.value = 5
                $0.formatter = DecimalFormatter()
                $0.useFormatterDuringInput = true
                //$0.useFormatterOnDidBeginEditing = true
                }.cellSetup { cell, _  in
                    cell.textField.keyboardType = .numberPad
            }

            <<< URLRow() {
                $0.title = "URLRow"
                $0.value = URL(string: "http://xmartlabs.com")
            }

            <<< PhoneRow() {
                $0.title = "PhoneRow (disabled)"
                $0.value = "+598 9898983510"
                $0.disabled = true
            }

            <<< NameRow() {
                $0.title =  "NameRow"
            }

            <<< PasswordRow() {
                $0.title = "PasswordRow"
                $0.value = "password"
            }

            <<< IntRow() {
                $0.title = "IntRow"
                $0.value = 2015
            }

            <<< EmailRow() {
                $0.title = "EmailRow"
                $0.value = "a@b.com"
            }

            <<< TwitterRow() {
                $0.title = "TwitterRow"
                $0.value = "@xmartlabs"
            }

            <<< AccountRow() {
                $0.title = "AccountRow"
                $0.placeholder = "Placeholder"
            }

            <<< ZipCodeRow() {
                $0.title = "ZipCodeRow"
                $0.placeholder = "90210"
        }
    }

    @objc func multipleSelectorDone(_ item:UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }

}
