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
  lTbl.Fields.Add( TJSTableField.New.FieldName('obs')      .FieldType(eftLongBlob) .Size(0)  .NotNull(false) );
  lTbl.Fields.Add( TJSTableField.New.FieldName('data')     .FieldType(eftDate)     .Size(0)  .NotNull(false) );
  lTbl.Fields.Add( TJSTableField.New.FieldName('hora')     .FieldType(eftTime)     .Size(0)  .NotNull(false) );
  lTbl.Fields.Add( TJSTableField.New.FieldName('oper')     .FieldType(eftString)   .Size(60) .NotNull(false) );
  lTbl.Fields.Add( TJSTableField.New.FieldName('ativo')    .FieldType(eftInteger)  .Size(0)  .NotNull(false) );
  lDB.Tables.Add(lTbl);

  // Atualizar a Base de Dados
  lDB.UpdateDB(FDConnection1);

  ShowMessage('Processo realizado com sucesso');
end;
