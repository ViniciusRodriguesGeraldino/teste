unit dtmBanco;

interface

uses
  Vcl.Forms, Vcl.Dialogs, System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef,
  FireDAC.VCLUI.Wait;

type
  TdtmMysql = class(TDataModule)
    cnt1: TFDConnection;
    sqlPed: TFDQuery;
    dtsPed: TDataSource;
    sqlPedItens: TFDQuery;
    dtsPedItens: TDataSource;
    FDTransaction1: TFDTransaction;
    procedure DataModuleCreate(Sender: TObject);
    procedure cnt1AfterCommit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dtmMysql: TdtmMysql;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdtmMysql.cnt1AfterCommit(Sender: TObject);
begin
  if FDTransaction1.Active then
    try
      cnt1.Commit;
    except
    end;

end;

procedure TdtmMysql.DataModuleCreate(Sender: TObject);
begin
  try
    cnt1.Connected := true;
  except on E: Exception do
    ShowMessage('Não conectou ao banco. ' + E.Message);
  end;
end;

end.
