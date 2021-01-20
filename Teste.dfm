object Pedidos: TPedidos
  Left = 0
  Top = 0
  Caption = 'Pedidos'
  ClientHeight = 508
  ClientWidth = 536
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 474
    Width = 536
    Height = 34
    Align = alBottom
    TabOrder = 0
    object SpeedButton2: TSpeedButton
      Left = 416
      Top = 6
      Width = 105
      Height = 22
      Caption = 'Gravar Pedido'
      OnClick = SpeedButton2Click
    end
    object lblTotal: TLabel
      Left = 16
      Top = 13
      Width = 28
      Height = 13
      Caption = 'Total:'
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 536
    Height = 137
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 23
      Top = 19
      Width = 51
      Height = 13
      Caption = 'Pedido N'#186':'
    end
    object Label2: TLabel
      Left = 23
      Top = 46
      Width = 37
      Height = 13
      Caption = 'Cliente:'
    end
    object lblCliente: TLabel
      Left = 151
      Top = 46
      Width = 62
      Height = 13
      Caption = 'Jos'#233' da Silva'
    end
    object lbl1: TLabel
      Left = 149
      Top = 19
      Width = 42
      Height = 13
      Caption = 'Emiss'#227'o:'
    end
    object edtPed: TEdit
      Left = 80
      Top = 16
      Width = 57
      Height = 21
      TabOrder = 0
      OnExit = edtPedExit
    end
    object edtCliente: TEdit
      Left = 80
      Top = 43
      Width = 57
      Height = 21
      TabOrder = 2
      OnExit = edtClienteExit
    end
    object GroupBox1: TGroupBox
      Left = 16
      Top = 70
      Width = 537
      Height = 59
      Caption = 'Produto:'
      TabOrder = 3
      object SpeedButton1: TSpeedButton
        Left = 400
        Top = 26
        Width = 105
        Height = 22
        Caption = 'Adicionar Produto'
        OnClick = SpeedButton1Click
      end
      object Label5: TLabel
        Left = 272
        Top = 27
        Width = 28
        Height = 13
        Caption = 'Valor:'
      end
      object Label4: TLabel
        Left = 135
        Top = 27
        Width = 60
        Height = 13
        Caption = 'Quantidade:'
      end
      object Label3: TLabel
        Left = 9
        Top = 27
        Width = 37
        Height = 13
        Caption = 'C'#243'digo:'
      end
      object lblProd: TLabel
        Left = 53
        Top = 0
        Width = 3
        Height = 13
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtValor: TEdit
        Left = 306
        Top = 27
        Width = 79
        Height = 21
        TabOrder = 2
      end
      object edtQtd: TEdit
        Left = 207
        Top = 27
        Width = 57
        Height = 21
        TabOrder = 1
      end
      object edtProduto: TEdit
        Left = 64
        Top = 27
        Width = 57
        Height = 21
        TabOrder = 0
        OnExit = edtProdutoExit
        OnKeyPress = edtProdutoKeyPress
      end
    end
    object edtDataEmissao: TMaskEdit
      Left = 223
      Top = 16
      Width = 74
      Height = 21
      EditMask = '!90/00/0000;1;_'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 137
    Width = 536
    Height = 337
    Align = alClient
    TabOrder = 2
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 534
      Height = 335
      Align = alClient
      DataSource = DataSource1
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnKeyPress = DBGrid1KeyPress
      Columns = <
        item
          Expanded = False
          FieldName = 'CODIGOPRODUTO'
          Title.Caption = 'Produto'
          Width = 81
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCRICAO'
          Title.Caption = 'Descri'#231#227'o'
          Width = 204
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'QUANTIDADE'
          Title.Caption = 'Qtd.'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALORUNITARIO'
          Title.Caption = 'Val. Unitario'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALORTOTAL'
          Title.Caption = 'Val. Total'
          Visible = True
        end>
    end
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 416
    Top = 169
    object ClientDataSet1CODIGOPRODUTO: TStringField
      FieldName = 'CODIGOPRODUTO'
      Size = 60
    end
    object ClientDataSet1DESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 100
    end
    object ClientDataSet1QUANTIDADE: TFloatField
      FieldName = 'QUANTIDADE'
    end
    object ClientDataSet1VALORUNITARIO: TFloatField
      FieldName = 'VALORUNITARIO'
    end
    object ClientDataSet1VALORTOTAL: TFloatField
      FieldName = 'VALORTOTAL'
    end
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 416
    Top = 233
  end
end
