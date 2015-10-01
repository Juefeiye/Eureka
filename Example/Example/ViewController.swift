//  ViewController.swift
//  Eureka ( https://github.com/xmartlabs/Eureka )
//
//  Copyright (c) 2015 Xmartlabs ( http://xmartlabs.com )
//
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit
import Eureka
import CoreLocation

//MARK: HomeViewController

class HomeViewController : FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ImageRow.defaultCellUpdate = { cell, row in
           cell.accessoryView?.layer.cornerRadius = 17
           cell.accessoryView?.frame = CGRectMake(0, 0, 34, 34)
        }
        
        form  +++=
            
            Section(footer: "These are 8 ButtonRow rows") {
                $0.header = HeaderFooterView<EurekaLogoView>(HeaderFooterProvider.Class)
            }
        
                <<< ButtonRow("Rows") {
                        $0.title = $0.tag
                        $0.presentationMode = .SegueName(segueName: "RowsExampleViewControllerSegue", completionCallback: nil)
                    }
            
                <<< ButtonRow("Native iOS Event Form") { row in
                        row.title = row.tag
                        row.presentationMode = .SegueName(segueName: "NativeEventsFormNavigationControllerSegue", completionCallback:{  vc in vc.dismissViewControllerAnimated(true, completion: nil) })
                    }
            
                <<< ButtonRow("Accesory View Navigation") { (row: ButtonRow) in
                        row.title = row.tag
                        row.presentationMode = .SegueName(segueName: "AccesoryViewControllerSegue", completionCallback:{  vc in vc.dismissViewControllerAnimated(true, completion: nil) })
                    }
            
                <<< ButtonRow("Custom Cells") { (row: ButtonRow) -> () in
                        row.title = row.tag
                        row.presentationMode = .SegueName(segueName: "CustomCellsControllerSegue", completionCallback:{  vc in vc.dismissViewControllerAnimated(true, completion: nil) })
                    }
            
                <<< ButtonRow("Customization of rows with text input") { (row: ButtonRow) -> Void in
                        row.title = row.tag
                        row.presentationMode = .SegueName(segueName: "FieldCustomizationControllerSegue", completionCallback:{  vc in vc.dismissViewControllerAnimated(true, completion: nil) })
                    }
            
                <<< ButtonRow("Hidden rows") { (row: ButtonRow) -> Void in
                    row.title = row.tag
                    row.presentationMode = .SegueName(segueName: "HiddenRowsControllerSegue", completionCallback:{  vc in vc.dismissViewControllerAnimated(true, completion: nil) })
                    }
            
                <<< ButtonRow("Disabled rows") { (row: ButtonRow) -> Void in
                    row.title = row.tag
                    row.presentationMode = .SegueName(segueName: "DisabledRowsControllerSegue", completionCallback:{  vc in vc.dismissViewControllerAnimated(true, completion: nil) })
                }
            
                <<< ButtonRow("Formatters") { (row: ButtonRow) -> Void in
                    row.title = row.tag
                    row.presentationMode = .SegueName(segueName: "FormattersControllerSegue", completionCallback:{  vc in vc.dismissViewControllerAnimated(true, completion: nil) })
                }
    }
}

//MARK: Emoji

typealias Emoji = String
let 👦🏼 = "👦🏼", 🍐 = "🍐", 💁🏻 = "💁🏻", 🐗 = "🐗", 🐼 = "🐼", 🐻 = "🐻", 🐖 = "🐖", 🐡 = "🐡"

//Mark: RowsExampleViewController

class RowsExampleViewController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        URLRow.defaultCellUpdate = { cell, row in cell.textField.textColor = .blueColor() }
        LabelRow.defaultCellUpdate = { cell, row in cell.detailTextLabel?.textColor = .orangeColor()  }
        CheckRow.defaultCellSetup = { cell, row in cell.tintColor = .orangeColor() }
        DateRow.defaultRowInitializer = { row in row.minimumDate = NSDate() }
        
        form =
            
            Section()
            
                <<< LabelRow () {
                        $0.title = "LabelRow"
                        $0.value = "tap the row"
                    }
                    .onCellSelection { $0.cell.detailTextLabel?.text? += " 🇺🇾 " }
            
                <<< DateRow() { $0.value = NSDate(); $0.title = "DateRow" }
                
                <<< CheckRow() {
                        $0.title = "CheckRow"
                        $0.value = true
                    }
                
                <<< SwitchRow() {
                        $0.title = "SwitchRow"
                        $0.value = true
                    }
            
            +++ Section("SegmentedRow examples")
            
                <<< SegmentedRow<String>() { $0.options = ["One", "Two", "Three"] }
                
                <<< SegmentedRow<Emoji>(){
                        $0.title = "Who are you?"
                        $0.options = [💁🏻, 🍐, 👦🏼, 🐗, 🐼, 🐻 ]
                        $0.value = 🍐
                    }
            
            +++ Section("Selectors Rows Examples")
                
                <<< ActionSheetRow<String>() {
                        $0.title = "ActionSheetRow"
                        $0.selectorTitle = "Your favourite player?"
                        $0.options = ["Diego Forlán", "Edinson Cavani", "Diego Lugano", "Luis Suarez"]
                        $0.value = "Luis Suarez"
                    }
                
                <<< AlertRow<Emoji>() {
                        $0.title = "AlertRow"
                        $0.selectorTitle = "Who is there?"
                        $0.options = [💁🏻, 🍐, 👦🏼, 🐗, 🐼, 🐻]
                        $0.value = 👦🏼
                    }.onChange { row in
                        print(row.value)
                    }
                    .onPresent{ _, to in
                        to.view.tintColor = .purpleColor()
                    }
            
                <<< PushRow<Emoji>() {
                        $0.title = "PushRow"
                        $0.options = [💁🏻, 🍐, 👦🏼, 🐗, 🐼, 🐻]
                        $0.value = 👦🏼
                        $0.selectorTitle = "Choose an Emoji!"
                    }
            
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
                        $0.selectorTitle = ""
                    }
                    .onPresent { from, to in
                        to.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: from, action: "multipleSelectorDone:")
                    }
        
            +++ Section("FieldRow examples")
            
                <<< TextRow() {
                        $0.title = "TextRow"
                        $0.placeholder = "Placeholder"
                    }
                
                <<< DecimalRow() {
                        $0.title = "DecimalRow"
                        $0.value = 5
                    }
                
                <<< URLRow() {
                        $0.title = "URLRow"
                        $0.value = NSURL(string: "http://xmartlabs.com")
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
    }
    
    func multipleSelectorDone(item:UIBarButtonItem) {
        navigationController?.popViewControllerAnimated(true)
    }
    
}

//MARK: Custom Cells Example

class CustomCellsController : FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        form +++
            Section() {
                var header = HeaderFooterView<EurekaLogoViewNib>(HeaderFooterProvider.NibFile(name: "EurekaSectionHeader", bundle: NSBundle.mainBundle()))
                header.onSetupView = { (view, section, form) -> () in
                                    view.imageView.alpha = 0;
                                    UIView.animateWithDuration(2.0, animations: { [weak view] in
                                        view?.imageView.alpha = 1
                                        })
                                    view.layer.transform = CATransform3DMakeScale(0.9, 0.9, 1)
                                    UIView.animateWithDuration(1.0, animations: { [weak view] in
                                        view?.layer.transform = CATransform3DIdentity
                                        })
                                }
                
                $0.header = header
            }
            +++ Section("WeekDay cell")
            <<< WeekDayRow(){ $0.value = [.Monday, .Wednesday, .Friday] }
            <<< FloatLabelRow() { $0.title = "Float Label Row, type something to see.." }
    }
}

//MARK: Field row customization Example
class FieldRowCustomizationController : FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        form +++
            Section(header: "Default field rows", footer: "Rows with title have a right-aligned text field.\nRows without title have a left-aligned text field.\nBut this can be changed...")
            
                <<< NameRow() {
                        $0.title = "Your name:"
                        $0.placeholder = "(right alignment)"
                    }
            
                <<< NameRow() {
                        $0.placeholder = "Name (left alignment)"
                    }
            
            +++ Section("Customized Alignment")
            
                <<< NameRow() {
                        $0.title = "Your name:"
                    }.cellUpdate { cell, row in
                        cell.textField.textAlignment = .Left
                        cell.textField.placeholder = "(left alignment)"
                    }
            
                <<< NameRow().cellUpdate { cell, row in
                    cell.textField.textAlignment = .Right
                    cell.textField.placeholder = "Name (right alignment)"
                }
        
            +++ Section(header: "Customized Text field width", footer: "Eureka allows us to set up a specific UITextField width using textFieldPercentage property. In the section above we have also right aligned the textLabels.")
            
                <<< NameRow() {
                    $0.title = "Title"
                    $0.textFieldPercentage = 0.6
                    $0.placeholder = "textFieldPercentage = 0.6"
                }
                .cellUpdate {
                    $0.cell.textField.textAlignment = .Left
                    $0.cell.textLabel?.textAlignment = .Right
                }
                <<< NameRow() {
                    $0.title = "Another Title"
                    $0.textFieldPercentage = 0.6
                    $0.placeholder = "textFieldPercentage = 0.6"
                }
                .cellUpdate {
                    $0.cell.textField.textAlignment = .Left
                    $0.cell.textLabel?.textAlignment = .Right
                }
                <<< NameRow() {
                    $0.title = "One more"
                    $0.textFieldPercentage = 0.7
                    $0.placeholder = "textFieldPercentage = 0.7"
                }
                .cellUpdate {
                    $0.cell.textField.textAlignment = .Left
                    $0.cell.textLabel?.textAlignment = .Right
                }
        
            +++ Section("TextAreaRow")
        
                <<< TextAreaRow() { $0.placeholder = "TextAreaRow" }
        
            }
}


//MARK: Navigation Accessory View Example

class NavigationAccessoryController : FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationOptions = RowNavigationOptions.Enabled.union(.SkipCanNotBecomeFirstResponderRow)
        
        form = Section(header: "Settings", footer: "These settings change how the navigation accessory view behaves")
            
             <<< SwitchRow("set_none") {
                    $0.title = "Navigation accessory view"
                    $0.value = self.navigationOptions?.contains(.Enabled)
                 }

            <<< CheckRow("set_disabled") {
                    $0.title = "Stop at disabled row"
                    $0.value = self.navigationOptions?.contains(.StopDisabledRow)
                    $0.hidden = "$set_none == false" // .Predicate(NSPredicate(format: "$set_none == false"))
                }.onChange { [weak self] row in
                    if row.value ?? false {
                        self?.navigationOptions = self?.navigationOptions?.union(.StopDisabledRow)
                    }
                    else{
                        self?.navigationOptions = self?.navigationOptions?.subtract(.StopDisabledRow)
                    }
                }

            <<< CheckRow("set_skip") {
                    $0.title = "Skip non first responder view"
                    $0.value = self.navigationOptions?.contains(.SkipCanNotBecomeFirstResponderRow)
                    $0.hidden = "$set_none  == false"
                }.onChange { [weak self] row in
                    if row.value ?? false {
                        self?.navigationOptions = self?.navigationOptions?.union(.SkipCanNotBecomeFirstResponderRow)
                    }
                    else{
                        self?.navigationOptions = self?.navigationOptions?.subtract(.SkipCanNotBecomeFirstResponderRow)
                    }
                }

        
            +++
            
                NameRow() { $0.title = "Your name:" }
            
                <<< PasswordRow() { $0.title = "Your password:" }
        
            +++
                Section()
            
                <<< SegmentedRow<Emoji>() {
                        $0.title = "Favourite food:"
                        $0.options = [🐗, 🐖, 🐡, 🍐]
                    }
            
                <<< PhoneRow() { $0.title = "Your phone number" }
            
                <<< URLRow() {
                        $0.title = "Disabled"
                        $0.disabled = true
                    }
            
                <<< TextRow() { $0.title = "Your father's name"}
            
                <<< TextRow(){ $0.title = "Your mother's name"}
    }
}

//MARK: Native Event Example

class NativeEventNavigationController: UINavigationController, RowControllerType {
    var completionCallback : ((UIViewController) -> ())?
}

class NativeEventFormViewController : FormViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeForm()
        
        self.navigationItem.leftBarButtonItem?.target = self
        self.navigationItem.leftBarButtonItem?.action = "cancelTapped:"
    }
    
    private func initializeForm() {
        
        form =
            
                TextRow("Title").cellSetup { cell, row in
                    cell.textField.placeholder = row.tag
                }
            
            <<< TextRow("Location").cellSetup {
                    $0.cell.textField.placeholder = $0.row.tag
                }
        
            +++
            
                SwitchRow("All-day") {
                    $0.title = $0.tag
                }.onChange { [weak self] row in
                    let startDate: DateTimeRow! = self?.form.rowByTag("Starts")
                    let endDate: DateTimeRow! = self?.form.rowByTag("Ends")
                    
                    if row.value ?? false {
                        startDate.dateFormatter?.dateStyle = .MediumStyle
                        startDate.dateFormatter?.timeStyle = .NoStyle
                        endDate.dateFormatter?.dateStyle = .MediumStyle
                        endDate.dateFormatter?.timeStyle = .NoStyle
                    }
                    else {
                        startDate.dateFormatter?.dateStyle = .ShortStyle
                        startDate.dateFormatter?.timeStyle = .ShortStyle
                        endDate.dateFormatter?.dateStyle = .ShortStyle
                        endDate.dateFormatter?.timeStyle = .ShortStyle
                    }
                    
                    
                    startDate.cellUpdate { cell, dateRow in
                        if row.value ?? false {
                            cell.datePicker.datePickerMode = .Date
                        }
                        else {
                            cell.datePicker.datePickerMode = .DateAndTime
                        }
                    }
                    endDate.cellUpdate { cell, dateRow in
                        if row.value ?? false {
                            cell.datePicker.datePickerMode = .Date
                            dateRow.dateFormatter?.dateStyle = .MediumStyle
                            dateRow.dateFormatter?.timeStyle = .NoStyle
                        }
                        else {
                            cell.datePicker.datePickerMode = .DateAndTime
                            dateRow.dateFormatter?.dateStyle = .ShortStyle
                            dateRow.dateFormatter?.timeStyle = .ShortStyle
                        }
                    }
                    
                    startDate.updateCell()
                    endDate.updateCell()
                }
            
            <<< DateTimeRow("Starts") {
                    $0.title = $0.tag
                    $0.value = NSDate().dateByAddingTimeInterval(60*60*24)
                }
                .onChange { [weak self] row in
                    let endRow: DateTimeRow! = self?.form.rowByTag("Ends")
                    if row.value?.compare(endRow.value!) == .OrderedDescending {
                        endRow.value = NSDate(timeInterval: 60*60*24, sinceDate: row.value!)
                        endRow.cell!.backgroundColor = .whiteColor()
                        endRow.updateCell()
                    }
                }
            
            <<< DateTimeRow("Ends"){
                    $0.title = $0.tag
                    $0.value = NSDate().dateByAddingTimeInterval(60*60*25)
                }
                .onChange { [weak self] row in
                    let startRow: DateTimeRow! = self?.form.rowByTag("Starts")
                    if row.value?.compare(startRow.value!) == .OrderedAscending {
                        row.cell!.backgroundColor = .redColor()
                    }
                    else{
                        row.cell!.backgroundColor = .whiteColor()
                    }
                    row.updateCell()
                }
        
        form +++=

                PushRow<RepeatInterval>("Repeat") {
                    $0.title = $0.tag
                    $0.options = RepeatInterval.allValues
                    $0.value = .Never
                }
        
        form +++=
            
            PushRow<EventAlert>() {
                $0.title = "Alert"
                $0.options = EventAlert.allValues
                $0.value = .Never
            }
            .onChange { [weak self] row in
                if row.value == .Never {
                    if let second : PushRow<EventAlert> = self?.form.rowByTag("Another Alert"), let secondIndexPath = second.indexPath() {
                        row.section?.removeAtIndex(secondIndexPath.row)
                    }
                }
                else{
                    guard let _ : PushRow<EventAlert> = self?.form.rowByTag("Another Alert") else {
                        let second = PushRow<EventAlert>("Another Alert") {
                            $0.title = $0.tag
                            $0.value = .Never
                            $0.options = EventAlert.allValues
                        }
                        row.section?.insert(second, atIndex: row.indexPath()!.row + 1)
                        return
                    }
                }
            }
        
        form +++=
            
            PushRow<EventState>("Show As") {
                $0.title = "Show As"
                $0.options = EventState.allValues
            }
        
        form +++=
            
            URLRow("URL") {
                $0.placeholder = "URL"
            }
        
            <<< TextAreaRow("notes") {
                    $0.placeholder = "Notes"
                }
        
    }
    
    func cancelTapped(barButtonItem: UIBarButtonItem) {
        (navigationController as? NativeEventNavigationController)?.completionCallback?(self)
    }
 
    enum RepeatInterval : String, CustomStringConvertible {
        case Never = "Never"
        case Every_Day = "Every Day"
        case Every_Week = "Every Week"
        case Every_2_Weeks = "Every 2 Weeks"
        case Every_Month = "Every Month"
        case Every_Year = "Every Year"
        
        var description : String { return rawValue }
        
        static let allValues = [Never, Every_Day, Every_Week, Every_2_Weeks, Every_Month, Every_Year]
    }
    
    enum EventAlert : String, CustomStringConvertible {
        case Never = "None"
        case At_time_of_event = "At time of event"
        case Five_Minutes = "5 minutes before"
        case FifTeen_Minutes = "15 minutes before"
        case Half_Hour = "30 minutes before"
        case One_Hour = "1 hour before"
        case Two_Hour = "2 hours before"
        case One_Day = "1 day before"
        case Two_Days = "2 days before"
        
        var description : String { return rawValue }
        
        static let allValues = [Never, At_time_of_event, Five_Minutes, FifTeen_Minutes, Half_Hour, One_Hour, Two_Hour, One_Day, Two_Days]
    }
    
    enum EventState {
        case Busy
        case Free
        
        static let allValues = [Busy, Free]
    }
}


//MARK: HiddenRowsExample

class HiddenRowsExample : FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TextRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = UIFont.italicSystemFontOfSize(12)
        }
        
        form = Section("What do you want to talk about:")
                <<< SegmentedRow<String>("segments"){
                        $0.options = ["Sport", "Music", "Films"]
                        $0.value = "Films"
                    }
            +++ Section(){
                    $0.tag = "sport_s"
                    $0.hidden = "$segments != 'Sport'" // .Predicate(NSPredicate(format: "$segments != 'Sport'"))
                }
                <<< TextRow(){
                    $0.title = "Which is your favourite soccer player?"
                }
            
                <<< TextRow(){
                    $0.title = "Which is your favourite coach?"
                }
            
                <<< TextRow(){
                    $0.title = "Which is your favourite team?"
                }
            
            +++ Section(){
                    $0.tag = "music_s"
                    $0.hidden = "$segments != 'Music'"
                }
                <<< TextRow(){
                    $0.title = "Which music style do you like most?"
                }
                
                <<< TextRow(){
                    $0.title = "Which is your favourite singer?"
                }
                <<< TextRow(){
                    $0.title = "How many CDs have you got?"
                }
            
            +++ Section(){
                    $0.tag = "films_s"
                    $0.hidden = "$segments != 'Films'"
                }
                <<< TextRow(){
                    $0.title = "Which is your favourite actor?"
                }
                
                <<< TextRow(){
                    $0.title = "Which is your favourite film?"
                }
        
            +++ Section()
        
                <<< SwitchRow("Show Next Row"){
                    $0.title = $0.tag
                }
                <<< SwitchRow("Show Next Section"){
                    $0.title = $0.tag
                    $0.hidden = .Function(["Show Next Row"], { form -> Bool in
                        let row: RowOf<Bool>! = form.rowByTag("Show Next Row")
                        return row.value ?? false == false
                    })
                }
        
            +++ Section(footer: "This section is shown only when 'Show Next Row' switch is enabled"){
                    $0.hidden = .Function(["Show Next Section"], { form -> Bool in
                        let row: RowOf<Bool>! = form.rowByTag("Show Next Section")
                        return row.value ?? false == false
                    })
                }
                <<< TextRow() {
                    $0.placeholder = "Gonna dissapear soon!!"
                }
    }
}

//MARK: DisabledRowsExample

class DisabledRowsExample : FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form = Section()
            
                <<< SegmentedRow<String>("segments"){
                    $0.options = ["Enabled", "Disabled"]
                    $0.value = "Disabled"
                }
            
                <<< TextRow(){
                    $0.title = "choose enabled, disable above..."
                    $0.disabled = "$segments = 'Disabled'"
                }
            
                <<< SwitchRow("Disable Next Section?"){
                    $0.title = $0.tag
                    $0.disabled = "$segments = 'Disabled'"
                }
            
            +++ Section()
            
                <<< TextRow() {
                    $0.title = "Gonna be disabled soon.."
                    $0.disabled = Condition.Function(["Disable Next Section?"], { (form) -> Bool in
                        let row: SwitchRow! = form.rowByTag("Disable Next Section?")
                        return row.value ?? false
                    })
                }
        
            +++ Section()
        
                <<< SegmentedRow<String>(){
                    $0.options = ["Always Disabled"]
                    $0.disabled = true
        }
    }
}

//MARK: FormatterExample

class FormatterExample : FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form +++ Section("Number formatters")
            <<< DecimalRow(){
                $0.useFormatterDuringInput = true
                $0.title = "Currency style"
                $0.value = 2015
                let formatter = CurrencyFormatter()
                formatter.locale = NSLocale.currentLocale()
                formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
                $0.formatter = formatter
            }
            <<< DecimalRow(){
                $0.title = "Scientific style"
                $0.value = 2015
                let formatter = NSNumberFormatter()
                formatter.locale = NSLocale.currentLocale()
                formatter.numberStyle = NSNumberFormatterStyle.ScientificStyle
                $0.formatter = formatter
            }
            <<< IntRow(){
                $0.title = "Spell out style"
                $0.value = 2015
                let formatter = NSNumberFormatter()
                formatter.locale = NSLocale.currentLocale()
                formatter.numberStyle = NSNumberFormatterStyle.SpellOutStyle
                $0.formatter = formatter
            }
        +++ Section("Date formatters")
            <<< DateRow(){
                $0.title = "Short style"
                $0.value = NSDate()
                let formatter = NSDateFormatter()
                formatter.locale = NSLocale.currentLocale()
                formatter.dateStyle = NSDateFormatterStyle.ShortStyle
                $0.dateFormatter = formatter
            }
            <<< DateRow(){
                $0.title = "Long style"
                $0.value = NSDate()
                let formatter = NSDateFormatter()
                formatter.locale = NSLocale.currentLocale()
                formatter.dateStyle = NSDateFormatterStyle.LongStyle
                $0.dateFormatter = formatter
            }
        +++ Section("Other formatters")
            <<< DecimalRow(){
                $0.title = "Energy: Jules to calories"
                $0.value = 100.0
                let formatter = NSEnergyFormatter()
                $0.formatter = formatter
            }
            <<< IntRow(){
                $0.title = "Weight: Kg to lb"
                $0.value = 1000
                $0.formatter = NSMassFormatter()
            }
    }
    
    class CurrencyFormatter : NSNumberFormatter, FormatterProtocol {
        override func getObjectValue(obj: AutoreleasingUnsafeMutablePointer<AnyObject?>, forString string: String, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>) -> Bool {
            guard obj != nil else { return false }
            var str : String
            str = string.stringByReplacingOccurrencesOfString("$", withString: "")
            str = str.stringByReplacingOccurrencesOfString(",", withString: "")
            guard let i = Float(str) else { return false }
            obj.memory = NSNumber(float: i)
            return true
        }
        
        func getNewPosition(forPosition position: UITextPosition, inTextInput textInput: UITextInput, oldValue: String?, newValue: String?) -> UITextPosition {
            return textInput.positionFromPosition(position, offset:((newValue?.characters.count ?? 0) - (oldValue?.characters.count ?? 0))) ?? position
        }
    }
}

class EurekaLogoViewNib: UIView {

    @IBOutlet weak var imageView: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

class EurekaLogoView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let imageView = UIImageView(image: UIImage(named: "Eureka"))
        imageView.frame = CGRect(x: 0, y: 0, width: 320, height: 130)
        imageView.autoresizingMask = .FlexibleWidth
        self.frame = CGRect(x: 0, y: 0, width: 320, height: 130)
        imageView.contentMode = .ScaleAspectFit
        self.addSubview(imageView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}