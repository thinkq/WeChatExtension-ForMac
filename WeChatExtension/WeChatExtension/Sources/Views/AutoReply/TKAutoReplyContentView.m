//
//  TKAutoReplyContentView.m
//  WeChatExtension
//
//  Created by WeChatExtension on 2019/8/20.
//  Copyright © 2019年 WeChatExtension. All rights reserved.
//

#import "TKAutoReplyContentView.h"
#import "WeChatPlugin.h"
#import "YMThemeManager.h"

@interface TKAutoReplyContentView () <NSTextFieldDelegate>

@property (nonatomic, strong) NSTextField *keywordLabel;
@property (nonatomic, strong) NSTextField *keywordTextField;
@property (nonatomic, strong) NSTextField *autoReplyLabel;
@property (nonatomic, strong) NSTextField *autoReplyContentField;
@property (nonatomic, strong) NSButton *enableGroupReplyBtn;
@property (nonatomic, strong) NSButton *enableSingleReplyBtn;
@property (nonatomic, strong) NSButton *enableRegexBtn;
@property (nonatomic, strong) NSTextField *delayField;
@property (nonatomic, strong) NSButton *enableDelayBtn;
@property (nonatomic, strong) NSButton *enableSpecificReplyBtn;
@property (nonatomic, strong) NSButton *selectSessionButton;
@property (nonatomic, strong) NSTextField *bombingIntervalField;
@property (nonatomic, strong) NSButton *enableBombingBtn;
@end

@implementation TKAutoReplyContentView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews
{
    
    
    self.enableSpecificReplyBtn = ({
        NSButton *btn = [NSButton tk_checkboxWithTitle:YMLocalizedString(@"assistant.autoReply.enableSpecific") target:self action:@selector(clickEnableSpecificReplyBtn:)];
        btn.frame = NSMakeRect(20, 30, 400, 20);
        [YMThemeManager changeButtonTheme:btn];
        btn;
    });
    
    self.enableBombingBtn = ({
        NSButton *btn = [NSButton tk_checkboxWithTitle:YMLocalizedString(@"assistant.autoReply.bombingInterval") target:self action:@selector(clickEnableBombingBtn:)];
        btn.frame = NSMakeRect(200, 30, 85, 20);
        [YMThemeManager changeButtonTheme:btn];
        btn;
    });
    
    self.bombingIntervalField = ({
        NSTextField *textField = [[NSTextField alloc] init];
        textField.frame = NSMakeRect(CGRectGetMaxX(self.enableBombingBtn.frame), 30, 60, 20);
        textField.delegate = self;
        textField.alignment = NSTextAlignmentRight;
        NSNumberFormatter * formater = [[NSNumberFormatter alloc] init];
        formater.numberStyle = NSNumberFormatterNoStyle;
        formater.minimum = @(3);
        formater.maximum = @(999);
        textField.cell.formatter = formater;
        
        textField;
    });

    
    self.selectSessionButton = ({
        NSButton *btn = [NSButton tk_buttonWithTitle:YMLocalizedString(@"assistant.autoReply.selectSpecific") target:self action:@selector(clickSelectSessionButton:)];
        btn.frame = NSMakeRect(20, 0, 150, 20);
        btn.bezelStyle = NSBezelStyleTexturedRounded;

        btn;
    });

    self.enableRegexBtn = ({
        NSButton *btn = [NSButton tk_checkboxWithTitle:YMLocalizedString(@"assistant.autoReply.enableRegEx") target:self action:@selector(clickEnableRegexBtn:)];
        btn.frame = NSMakeRect(20, 55, 400, 20);
        [YMThemeManager changeButtonTheme:btn];
        btn;
    });
    
    self.enableGroupReplyBtn = ({
        NSButton *btn = [NSButton tk_checkboxWithTitle:YMLocalizedString(@"assistant.autoReply.enableGroup") target:self action:@selector(clickEnableGroupBtn:)];
        btn.frame = NSMakeRect(20, 80, 400, 20);
        [YMThemeManager changeButtonTheme:btn];
        btn;
    });
    
    self.enableSingleReplyBtn = ({
        NSButton *btn = [NSButton tk_checkboxWithTitle:YMLocalizedString(@"assistant.autoReply.enableSingle") target:self action:@selector(clickEnableSingleBtn:)];
        btn.frame = NSMakeRect(200, 80, 400, 20);
        [YMThemeManager changeButtonTheme:btn];
        btn;
    });
    
    self.enableDelayBtn = ({
        NSButton *btn = [NSButton tk_checkboxWithTitle:YMLocalizedString(@"assistant.autoReply.delay") target:self action:@selector(clickEnableDelayBtn:)];
        btn.frame = NSMakeRect(200, 55, 85, 20);
        [YMThemeManager changeButtonTheme:btn];
        btn;
    });
    
    self.delayField = ({
        NSTextField *textField = [[NSTextField alloc] init];
        textField.frame = NSMakeRect(CGRectGetMaxX(self.enableDelayBtn.frame), 55, 60, 20);
        textField.placeholderString = YMLocalizedString(@"assistant.autoReply.timeUnit");
        textField.delegate = self;
        textField.alignment = NSTextAlignmentRight;
        NSNumberFormatter * formater = [[NSNumberFormatter alloc] init];
        formater.numberStyle = NSNumberFormatterDecimalStyle;
        formater.minimum = @(0);
        formater.maximum = @(999);
        textField.cell.formatter = formater;
        
        textField;
    });

    self.autoReplyContentField = ({
        NSTextField *textField = [[NSTextField alloc] init];
        textField.frame = NSMakeRect(20, 110, 350, 175);
        textField.placeholderString = YMLocalizedString(@"assistant.autoReply.contentPlaceholder");
        textField.delegate = self;
        
        textField;
    });
    
    self.autoReplyLabel = ({
        NSString *text = [NSString stringWithFormat:@"%@: ",YMLocalizedString(@"assistant.autoReply.content")];
        NSTextField *label = [NSTextField tk_labelWithString:text];
        label.frame = NSMakeRect(20, 290, 350, 20);
        
        label;
    });
    
    self.keywordTextField = ({
        NSTextField *textField = [[NSTextField alloc] init];
        textField.frame = NSMakeRect(20, 330, 350, 50);
        textField.placeholderString = YMLocalizedString(@"assistant.autoReply.keywordPlaceholder");
        textField.delegate = self;
        
        textField;
    });
    
    self.keywordLabel = ({
         NSString *text = [NSString stringWithFormat:@"%@: ",YMLocalizedString(@"assistant.autoReply.keyword")];
        NSTextField *label = [NSTextField tk_labelWithString:text];
        label.frame = NSMakeRect(20, 385, 350, 20);
        
        label;
    });
    
    [self addSubviews:@[self.enableRegexBtn,
                        self.enableGroupReplyBtn,
                        self.enableSingleReplyBtn,
                        self.autoReplyContentField,
                        self.autoReplyLabel,
                        self.keywordTextField,
                        self.keywordLabel,
                        self.delayField,
                        self.enableDelayBtn,
                        self.enableSpecificReplyBtn,
                        self.selectSessionButton,
                        self.enableBombingBtn,
                        self.bombingIntervalField]];
}

- (void)clickEnableSpecificReplyBtn:(NSButton *)btn
{
    self.selectSessionButton.hidden = !btn.state;
    self.enableGroupReplyBtn.hidden = btn.state;
    self.enableSingleReplyBtn.hidden = btn.state;
    if (btn.state) {
        [self selectSessionAction];
    }
    self.model.enableSpecificReply = btn.state;
}

- (void)clickSelectSessionButton:(NSButton *)btn
{
    [self selectSessionAction];
}

- (void)clickEnableRegexBtn:(NSButton *)btn
{
    self.model.enableRegex = btn.state;
}

- (void)clickEnableGroupBtn:(NSButton *)btn
{
    self.model.enableGroupReply = btn.state;
    if (btn.state) {
        self.model.enable = YES;
    } else if (!self.model.enableSingleReply) {
        self.model.enable = NO;
    }
    
    if (self.endEdit) {
         self.endEdit();
    }
}

- (void)clickEnableSingleBtn:(NSButton *)btn
{
    self.model.enableSingleReply = btn.state;
    if (btn.state) {
        self.model.enable = YES;
    } else if (!self.model.enableGroupReply) {
        self.model.enable = NO;
    }
    if (self.endEdit) {
         self.endEdit();
    }
}

- (void)clickEnableDelayBtn:(NSButton *)btn
{
    self.enableBombingBtn.hidden = btn.state;
    self.bombingIntervalField.hidden = btn.state;
    self.model.enableDelay = btn.state;
}

- (void)clickEnableBombingBtn:(NSButton *)btn
{
    self.enableDelayBtn.hidden = btn.state;
    self.delayField.hidden = btn.state;
    self.model.enableBombing = btn.state;
    
    if (self.bombing) {
        self.bombing(btn.state);
    }
}

- (void)viewDidMoveToSuperview
{
    [super viewDidMoveToSuperview];
    self.layer.backgroundColor = [kBG2 CGColor];
    self.layer.borderWidth = 1;
    self.layer.borderColor = [YM_RGBA(0, 0, 0, 0.1) CGColor];
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    [self.layer setNeedsDisplay];
}

- (void)setModel:(YMAutoReplyModel *)model
{
    _model = model;
    self.keywordTextField.stringValue = model.keyword != nil ? model.keyword : @"";
    self.autoReplyContentField.stringValue = model.replyContent != nil ? model.replyContent : @"";
    self.enableGroupReplyBtn.state = model.enableGroupReply;
    self.enableSingleReplyBtn.state = model.enableSingleReply;
    self.enableRegexBtn.state = model.enableRegex;
    self.enableDelayBtn.state = model.enableDelay;
    self.delayField.stringValue = [NSString stringWithFormat:@"%ld",model.delayTime];
    self.enableSpecificReplyBtn.state = model.enableSpecificReply;
    
    self.bombingIntervalField.stringValue = [NSString stringWithFormat:@"%f",model.bombingInterval];
    self.enableBombingBtn.state = model.enableBombing;
    
    self.enableDelayBtn.hidden = model.enableBombing;
    self.delayField.hidden = model.enableBombing;
    
    self.selectSessionButton.hidden = !model.enableSpecificReply;
    self.enableGroupReplyBtn.hidden = model.enableSpecificReply;
    self.enableSingleReplyBtn.hidden = model.enableSpecificReply;
}

- (void)selectSessionAction
{
    MMSessionPickerWindow *picker = [objc_getClass("MMSessionPickerWindow") shareInstance];
    [picker setType:1];
    [picker setShowsGroupChats:0x1];
    [picker setShowsOtherNonhumanChats:0];
    [picker setShowsOfficialAccounts:0];
    MMSessionPickerLogic *logic = [picker.listViewController valueForKey:@"m_logic"];
    NSMutableOrderedSet *orderSet = nil;
    NSMutableArray *selectUsrs = nil;
    if (LargerOrEqualLongVersion(@"2.4.2.148")) {
        selectUsrs = [logic valueForKey:@"_selectedUserNames"];
        if (!selectUsrs) {
            selectUsrs = [NSMutableArray new];
        }
        [selectUsrs addObjectsFromArray:self.model.specificContacts];
    } else {
        orderSet = [logic valueForKey:@"_selectedUserNamesSet"];
        if (!orderSet) {
            orderSet = [NSMutableOrderedSet new];
        }
        [orderSet addObjectsFromArray:self.model.specificContacts];
    }
    
    [picker.choosenViewController setValue:self.model.specificContacts forKey:@"selectedUserNames"];
    [picker beginSheetForWindow:self.window completionHandler:^(NSOrderedSet *a1) {
        NSMutableArray *array = [NSMutableArray array];
        [a1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [array addObject:obj];
        }];
        self.model.specificContacts = [array copy];
    }];
}

- (void)controlTextDidEndEditing:(NSNotification *)notification
{
    if (self.endEdit) {
         self.endEdit();
    }
}

- (void)controlTextDidChange:(NSNotification *)notification
{
    NSControl *control = notification.object;
    if (control == self.keywordTextField) {
        self.model.keyword = self.keywordTextField.stringValue;
    } else if (control == self.autoReplyContentField) {
        self.model.replyContent = self.autoReplyContentField.stringValue;
    } else if (control == self.delayField) {
        self.model.delayTime = [self.delayField.stringValue integerValue];
    }else if (control == self.bombingIntervalField) {
        self.model.bombingInterval = [self.bombingIntervalField.stringValue doubleValue];
    }
}

- (BOOL)control:(NSControl *)control textView:(NSTextView *)textView doCommandBySelector:(SEL)commandSelector
{
    BOOL result = NO;
    
    if (commandSelector == @selector(insertNewline:)) {
        [textView insertNewlineIgnoringFieldEditor:self];
        result = YES;
    } else if (commandSelector == @selector(insertTab:)) {
        if (control == self.keywordTextField) {
            [self.autoReplyContentField becomeFirstResponder];
        } else if (control == self.autoReplyContentField) {
            [self.keywordTextField becomeFirstResponder];
        }
    }
    
    return result;
}

@end
