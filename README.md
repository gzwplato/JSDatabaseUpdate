# JSDatabaseUpdate
Script de atualização de dados Firebird/MySQL

-Estudo e testes
  Atualizar/Sincronizar tabelas e campos de bancos de dados Firebird/MySQL.

-Exemplo de uso
uses
  JS.DatabaseUpdate.Interfaces,
  JS.DatabaseUpdate;

procedure TPrincipalView.Button1Click(Sender: TObject);
Var
  lDB: IJSDataBase;
  lTbl: IJSTable;
  lI, lJ: Integer;
begin
  lDB := TJSDataBase.New;

  // Tabela teste
  lTbl := TJSTable.New.Description('teste');
  lTbl.Fields.Add( TJSTableField.New.FieldName('codteste') .FieldType(eftInteger)  .Size(0)  .NotNull(true) .PrimaryKey(true) );
  lTbl.Fields.Add( TJSTableField.New.FieldName('teste')    .FieldType(eftString)   .Size(60) .NotNull(true)  );
  lTbl.Fields.Add( TJSTableField.New.FieldName('data')     .FieldType(eftDate)     .Size(0)  .NotNull(false) );
  lTbl.Fields.Add( TJSTableField.New.FieldName('hora')     .FieldType(eftTime)     .Size(0)  .NotNull(false) );
  lTbl.Fields.Add( TJSTableField.New.FieldName('oper')     .FieldType(eftString)   .Size(60) .NotNull(false) );
  lTbl.Fields.Add( TJSTableField.New.FieldName('ativo')    .FieldType(eftInteger)  .Size(0)  .NotNull(false) );

  if (AnsiUpperCase(FDConnection1.Params.DriverID) = 'FB') then
    lTbl.Fields.Add( TJSTableField.New.FieldName('obs').FieldType(eftBlob).Size(80).SubType(estBinary).NotNull(false) );

  if (AnsiUpperCase(FDConnection1.Params.DriverID) = 'MYSQL') then
    lTbl.Fields.Add( TJSTableField.New.FieldName('obs').FieldType(eftLongBlob).NotNull(false));

  lTbl.Indexs.Add( TJSTableIndex.New.IndexName('teste_idx_teste') .Fields('teste') );
  lTbl.Indexs.Add( TJSTableIndex.New.IndexName('teste_idx_data')  .Fields('data')   );
  lTbl.Indexs.Add( TJSTableIndex.New.IndexName('teste_idx_hora')  .Fields('hora')   );
  lDB.Tables.Add(lTbl);

  // Atualizar a Base de Dados
  lDB.UpdateDB(FDConnection1);

  ShowMessage('Processo realizado com sucesso');
end;
