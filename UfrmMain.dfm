object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'frmMain'
  ClientHeight = 652
  ClientWidth = 641
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  DesignSize = (
    641
    652)
  PixelsPerInch = 96
  TextHeight = 13
  object btnSimpleNumber: TButton
    Left = 8
    Top = 16
    Width = 105
    Height = 25
    Caption = 'btnSimpleNumber'
    TabOrder = 0
    OnClick = btnSimpleNumberClick
  end
  object memOut: TMemo
    Left = 119
    Top = 8
    Width = 522
    Height = 641
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssVertical
    TabOrder = 1
    OnDblClick = memOutDblClick
  end
  object btnSums: TButton
    Left = 8
    Top = 47
    Width = 105
    Height = 25
    Caption = 'btnSums'
    TabOrder = 2
    OnClick = btnSumsClick
  end
  object btnClearSSsum: TButton
    Left = 8
    Top = 88
    Width = 105
    Height = 25
    Caption = 'btnClearSSsum'
    TabOrder = 3
    OnClick = btnClearSSsumClick
  end
  object btnClrSumsByMul: TButton
    Left = 8
    Top = 136
    Width = 105
    Height = 25
    Caption = 'btnClrSumsByMul'
    TabOrder = 4
    OnClick = btnClrSumsByMulClick
  end
end
