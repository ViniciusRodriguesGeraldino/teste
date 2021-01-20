program Project1;

uses
  Vcl.Forms,
  Teste in 'Teste.pas' {Pedidos},
  uPedidos in 'uPedidos.pas',
  dtmBanco in 'dtmBanco.pas' {dtmMysql: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TPedidos, Pedidos);
  Application.CreateForm(TdtmMysql, dtmMysql);
  Application.Run;
end.
