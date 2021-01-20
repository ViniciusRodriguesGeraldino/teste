object dtmMysql: TdtmMysql
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 180
  Width = 223
  object cnt1: TFDConnection
    Params.Strings = (
      'Database=teste'
      'User_Name=root'
      'Password=1234'
      'Server=localhost'
      'Port=3307'
      'DriverID=MySQL')
    LoginPrompt = False
    AfterCommit = cnt1AfterCommit
    Left = 24
    Top = 16
  end
  object sqlPed: TFDQuery
    CachedUpdates = True
    Connection = cnt1
    SQL.Strings = (
      'SELECT * FROM PEDIDOS')
    Left = 80
    Top = 64
  end
  object dtsPed: TDataSource
    DataSet = sqlPed
    Left = 128
    Top = 64
  end
  object sqlPedItens: TFDQuery
    CachedUpdates = True
    Connection = cnt1
    SQL.Strings = (
      'SELECT * FROM ITENSPEDIDOS')
    Left = 88
    Top = 120
  end
  object dtsPedItens: TDataSource
    DataSet = sqlPedItens
    Left = 136
    Top = 120
  end
  object FDTransaction1: TFDTransaction
    Connection = cnt1
    Left = 112
    Top = 16
  end
end
