object Form1: TForm1
  Left = 360
  Top = 117
  Width = 412
  Height = 622
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 272
    Top = 144
    Width = 28
    Height = 13
    Caption = 'Name'
  end
  object Label1: TLabel
    Left = 136
    Top = 8
    Width = 55
    Height = 20
    Caption = 'Label1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object RichEdit1: TRichEdit
    Left = 16
    Top = 32
    Width = 249
    Height = 329
    TabOrder = 0
  end
  object Edit1: TEdit
    Left = 272
    Top = 56
    Width = 81
    Height = 21
    TabOrder = 1
    Text = '127.0.0.1'
  end
  object Edit3: TEdit
    Left = 16
    Top = 376
    Width = 249
    Height = 21
    TabOrder = 2
    OnKeyPress = Edit3KeyPress
  end
  object Button1: TButton
    Left = 272
    Top = 88
    Width = 65
    Height = 17
    Caption = 'Talk'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 272
    Top = 112
    Width = 65
    Height = 17
    Caption = 'Listen'
    TabOrder = 4
    OnClick = Button2Click
  end
  object Edit4: TEdit
    Left = 272
    Top = 160
    Width = 73
    Height = 21
    TabOrder = 5
    Text = 'k'
  end
  object ScrollBar1: TScrollBar
    Left = 56
    Top = 416
    Width = 153
    Height = 17
    Max = 45
    Min = 2
    PageSize = 0
    Position = 2
    TabOrder = 6
    OnChange = ScrollBar1Change
  end
  object ColorBox1: TColorBox
    Left = 88
    Top = 472
    Width = 97
    Height = 22
    ItemHeight = 16
    TabOrder = 7
    OnChange = ColorBox1Change
  end
  object CheckBox1: TCheckBox
    Left = 280
    Top = 352
    Width = 81
    Height = 17
    Caption = 'Bold'
    TabOrder = 8
    OnClick = CheckBox1Click
  end
  object CheckBox2: TCheckBox
    Left = 280
    Top = 368
    Width = 81
    Height = 17
    Caption = 'Italic'
    TabOrder = 9
    OnClick = CheckBox2Click
  end
  object CheckBox3: TCheckBox
    Left = 280
    Top = 384
    Width = 97
    Height = 17
    Caption = 'Undeline'
    TabOrder = 10
    OnClick = CheckBox3Click
  end
  object RadioGroup1: TRadioGroup
    Left = 272
    Top = 192
    Width = 105
    Height = 81
    Caption = 'Font'
    Items.Strings = (
      'Comic Sans MS'
      'Times New Roman'
      'Arial')
    TabOrder = 11
    OnClick = RadioGroup1Click
  end
  object ClientSocket1: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 0
    OnConnect = ClientSocket1Connect
    OnRead = ClientSocket1Read
    Left = 80
  end
  object ServerSocket1: TServerSocket
    Active = False
    Port = 0
    ServerType = stNonBlocking
    OnClientConnect = ServerSocket1ClientConnect
    OnClientRead = ServerSocket1ClientRead
    Left = 48
  end
end
