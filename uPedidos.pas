unit uPedidos;

interface

uses FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
     FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.Comp.Client, FireDAC.Stan.Param,
     FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Phys.SQLiteVDataSet, FireDAC.VCLUI.Wait, dtmBanco, Datasnap.DBClient,
     SysUtils;

type
  TPedidosClass = class
  private

  public
    procedure Salva(numero, emissao, cliente : string; total : Double; tblPedItens : TClientDataSet);
    function getDescricaoProduto(codigo : string) : string;
    function getDescricaoCliente(codigo : string) : string;
    function getItensPedido(numero : string) : TFDQuery;

  end;

var
  pedClass : TPedidosClass;

implementation

{ TPedidos }

function TPedidosClass.getDescricaoCliente(codigo: string): string;
var
  sqlQuery : TFDQuery;
begin

  sqlQuery := TFDQuery.Create(nil);
  sqlQuery.Connection := dtmMysql.cnt1;
  sqlQuery.SQL.Text := 'SELECT NOME FROM CLIENTES WHERE ID = :id';
  sqlQuery.ParamByName('id').AsString := codigo;
  sqlQuery.Open;

  Result := sqlQuery.FieldByName('NOME').AsString;

  sqlQuery.Free;

end;

function TPedidosClass.getDescricaoProduto(codigo: string): string;
var
  sqlQuery : TFDQuery;
begin

  sqlQuery := TFDQuery.Create(nil);
  sqlQuery.Connection := dtmMysql.cnt1;
  sqlQuery.SQL.Text := 'SELECT DESCRICAO FROM PRODUTOS WHERE CODIGO = :id';
  sqlQuery.ParamByName('id').AsString := codigo;
  sqlQuery.Open;

  if sqlQuery.FieldByName('DESCRICAO').AsString = '' then
  begin
    sqlQuery.Close;
    sqlQuery.SQL.Text := 'SELECT DESCRICAO FROM PRODUTOS WHERE ID = :id';
    sqlQuery.ParamByName('id').AsString := codigo;
    sqlQuery.Open;
  end;

  Result := sqlQuery.FieldByName('DESCRICAO').AsString;

  if sqlQuery.FieldByName('DESCRICAO').AsString = '' then
    Result := 'Produto não encontrado';

  sqlQuery.Free;

end;

function TPedidosClass.getItensPedido(numero: string): TFDQuery;
var
  sqlQuery : TFDQuery;
begin
  sqlQuery := TFDQuery.Create(nil);
  sqlQuery.Connection := dtmMysql.cnt1;
  sqlQuery.SQL.Text := 'SELECT * FROM ITENSPEDIDOS WHERE ID_PEDIDO = :id';
  sqlQuery.ParamByName('id').AsString := numero;
  sqlQuery.Open;

  Result := sqlQuery;
end;

procedure TPedidosClass.Salva(numero, emissao, cliente : string; total : Double; tblPedItens : TClientDataSet);
var
  sqlQuery : TFDQuery;
  sql : string;
begin

  if tblPedItens.RecordCount = 0 then
    raise Exception.Create('Não há itens para gravar.');

  sqlQuery := TFDQuery.Create(nil);
  sqlQuery.Connection := dtmMysql.cnt1;

  dtmMysql.sqlPed.Close;
  dtmMysql.sqlPed.Open;

  if not dtmMysql.cnt1.InTransaction then
   dtmMysql.cnt1.StartTransaction;

  try

    //sqlQuery.Close;

    //if (numero <> '') and (dtmMysql.sqlPed.Locate('ID', numero, [])) then
    //begin
    //  sqlQuery.SQL.Text := 'UPDATE PEDIDOS SET DATA_EMISSAO = :data, CLIENTE = :cliente, TOTAL = :total WHERE ID = :id';
    //  sqlQuery.ParamByName('id').AsString    := numero;
    //end
    //else
    //  sqlQuery.SQL.Text := 'INSERT INTO PEDIDOS (DATA_EMISSAO, CLIENTE, TOTAL) VALUES (:data, :cliente, :total);';

    //sqlQuery.ParamByName('data').AsDate      := StrToDateDef(emissao, 0);
    //sqlQuery.ParamByName('cliente').AsString := cliente;
    //sqlQuery.ParamByName('total').AsFloat    := total;
    //sqlQuery.ExecSQL;

    if (numero <> '') and (dtmMysql.sqlPed.Locate('ID', numero, [])) then
      dtmMysql.sqlPed.Edit
    else
      dtmMysql.sqlPed.Insert;

    dtmMysql.sqlPed.FieldByName('DATA_EMISSAO').AsString  := emissao;
    dtmMysql.sqlPed.FieldByName('CLIENTE').AsString       := cliente;
    dtmMysql.sqlPed.FieldByName('TOTAL').AsFloat          := total;

    dtmMysql.sqlPed.Post;
    dtmMysql.sqlPed.ApplyUpdates(0);

    if dtmMysql.cnt1.InTransaction then
      dtmMysql.cnt1.Commit;

  except
    dtmMysql.cnt1.Rollback;
  end;


  //Itens
  if not dtmMysql.cnt1.InTransaction then
   dtmMysql.cnt1.StartTransaction;

  try
    sqlQuery.SQL.Text := 'DELETE FROM ITENSPEDIDOS WHERE ID_PEDIDO = :id';
    sqlQuery.ParamByName('id').AsString := dtmMysql.sqlPed.FieldByName('ID').AsString;
    sqlQuery.ExecSQL;

    if dtmMysql.cnt1.InTransaction then
      dtmMysql.cnt1.Commit;

  except
    dtmMysql.cnt1.Rollback;
  end;

  dtmMysql.sqlPedItens.Close;
  dtmMysql.sqlPedItens.Open;

  if not dtmMysql.cnt1.InTransaction then
   dtmMysql.cnt1.StartTransaction;

  try
    //tblPedItens.First;
    //while not tblPedItens.Eof do
    //begin
    //  dtmMysql.sqlPedItens.Insert;

    //  dtmMysql.sqlPedItens.FieldByName('ID_PEDIDO').AsString      := dtmMysql.sqlPed.FieldByName('ID').AsString;
    //  dtmMysql.sqlPedItens.FieldByName('CODIGOPRODUTO').AsString  := tblPedItens.FieldByName('CODIGOPRODUTO').AsString;
    //  dtmMysql.sqlPedItens.FieldByName('QUANTIDADE').AsString     := tblPedItens.FieldByName('QUANTIDADE').AsString;
    //  dtmMysql.sqlPedItens.FieldByName('VALORUNITARIO').AsString  := tblPedItens.FieldByName('VALORUNITARIO').AsString;
    //  dtmMysql.sqlPedItens.FieldByName('VALORTOTAL').AsString     := tblPedItens.FieldByName('VALORTOTAL').AsString;

    //  dtmMysql.sqlPedItens.Post;
    //  dtmMysql.sqlPedItens.ApplyUpdates(0);

    //  tblPedItens.Next;
    //end;

    tblPedItens.First;
    while not tblPedItens.Eof do
    begin
      sqlQuery.Close;
      sqlQuery.SQL.Text := 'INSERT INTO ITENSPEDIDOS (ID_PEDIDO, CODIGOPRODUTO, QUANTIDADE, VALORUNITARIO, VALORTOTAL) ' +
                           'VALUES (:idPed, :codProd, :qtd, :valUni, :valTot); ';

      sqlQuery.ParamByName('idPed').AsString   := dtmMysql.sqlPed.FieldByName('ID').AsString;
      sqlQuery.ParamByName('codProd').AsString := tblPedItens.FieldByName('CODIGOPRODUTO').AsString;
      sqlQuery.ParamByName('qtd').AsFloat      := tblPedItens.FieldByName('QUANTIDADE').AsFloat;
      sqlQuery.ParamByName('valUni').AsFloat   := tblPedItens.FieldByName('VALORUNITARIO').AsFloat;
      sqlQuery.ParamByName('valTot').AsFloat   := tblPedItens.FieldByName('VALORTOTAL').AsFloat;
      sqlQuery.ExecSQL;

      tblPedItens.Next;
    end;

    if dtmMysql.cnt1.InTransaction then
      dtmMysql.cnt1.Commit;

  except
    dtmMysql.cnt1.Rollback;
  end;

  sqlQuery.Free;

end;



end.
