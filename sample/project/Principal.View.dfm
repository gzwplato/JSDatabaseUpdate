object PrincipalView: TPrincipalView
  Left = 0
  Top = 0
  Caption = 'PrincipalView'
  ClientHeight = 589
  ClientWidth = 770
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 64
    Top = 152
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 64
    Top = 200
    Width = 649
    Height = 241
    TabOrder = 1
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=dados_meyer'
      'User_Name=root'
      'Password=masterkey'
      'Server=localhost'
      'CharacterSet=utf8'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 72
    Top = 32
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 184
    Top = 32
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 304
    Top = 32
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'C:\AlbSys_Renata\libmysql.dll'
    Left = 184
    Top = 88
  end
end
