unit JS.DatabaseUpdate;

interface

uses
  System.Generics.Collections,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Phys.IBBase,
  FireDAC.Comp.Client, FireDAC.Dapt, Data.DB,

  JS.DatabaseUpdate.Interfaces;

type
  TJSDataBase = class(TInterfacedObject, IJSDataBase)
  private
    FTables: TList<IJSTable>;
    FFDConn: TFDConnection;
    FQry1: TFDQuery;
    FQry2: TFDQuery;

    function TableExists(ATableName: String): Boolean;
    function CreateTable(ATableName: String; AFields: TList<IJSTableField>): IJSDataBase;
    function CheckCreateFields(ATableName: String; AFields: TList<IJSTableField>): IJSDataBase;
    function CheckCreateIndexs(ATableName: String; AIndexs: TList<IJSTableIndex>): IJSDataBase;

    function FieldTypeStr(AFieldType: TEnumFieldType): String;
    function SubTypeStr(ASubType: TEnumSubType): String;
    function SizeStr(ASize: Integer; ASubType: TEnumSubType): String;
    function NotNullStr(ANotNull: Boolean): String;
    function PrimaryKeyStr(AFields: TList<IJSTableField>): String;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: IJSDataBase;

    function Tables: TList<IJSTable>;
    function UpdateDB(AFDConn: TFDConnection): IJSDataBase;
  end;


  TJSTable = class(TInterfacedObject, IJSTable)
  private
    FDescription: String;
    FFields: TList<IJSTableField>;
    FIndexs: TList<IJSTableIndex>;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: IJSTable;

    function Description: String; overload;
    function Description(AValue: String): IJSTable; overload;

    function Fields: TList<IJSTableField>;
    function Indexs: TList<IJSTableIndex>;
  end;

  TJSTableField = class(TInterfacedObject, IJSTableField)
  private
    FFieldName   :String;
    FDisplayName :String;
    FFieldType   :TEnumFieldType;
    FSize        :Integer;
    FScale       :Integer;
    FSubType     :TEnumSubType;
    FNotNull     :Boolean;
    FPrimaryKey  :Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: IJSTableField;

    function FieldName: String; overload;
    function FieldName(AValue: String): IJSTableField; overload;

    function DisplayName: String; overload;
    function DisplayName(AValue: String): IJSTableField; overload;

    function FieldType: TEnumFieldType; overload;
    function FieldType(AValue: TEnumFieldType): IJSTableField; overload;

    function Size: Integer; overload;
    function Size(AValue: Integer): IJSTableField; overload;

    function Scale: Integer; overload;
    function Scale(AValue: Integer): IJSTableField; overload;

    function SubType: TEnumSubType; overload;
    function SubType(AValue: TEnumSubType): IJSTableField; overload;

    function NotNull: Boolean; overload;
    function NotNull(AValue: Boolean): IJSTableField; overload;

    function PrimaryKey: Boolean; overload;
    function PrimaryKey(AValue: Boolean): IJSTableField; overload;
  end;

  TJSTableIndex = class(TInterfacedObject, IJSTableIndex)
  private
    FIndexName  :String;
    FFields     :String;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: IJSTableIndex;

    function IndexName: String; overload;
    function IndexName(AValue: String): IJSTableIndex; overload;

    function Fields: String; overload;
    function Fields(AValue: String): IJSTableIndex; overload;
  end;

implementation

uses
  System.SysUtils,
  Vcl.Forms,
  Vcl.Dialogs;

{ TJSTable }

constructor TJSTable.Create;
begin
  FFields := TList<IJSTableField>.Create;
  FIndexs := TList<IJSTableIndex>.Create;
end;

destructor TJSTable.Destroy;
begin
  if Assigned(FFields) then
    FreeAndNil(FFields);

  if Assigned(FIndexs) then
    FreeAndNil(FIndexs);

  inherited;
end;

function TJSTable.Fields: TList<IJSTableField>;
begin
  Result := FFields;
end;

function TJSTable.Indexs: TList<IJSTableIndex>;
begin
  Result := FIndexs;
end;

class function TJSTable.New: IJSTable;
begin
  Result := Self.Create;
end;

function TJSTable.Description(AValue: String): IJSTable;
begin
  Result := Self;
  FDescription := AValue;
end;

function TJSTable.Description: String;
begin
  Result := FDescription;
end;

{ TJSTableField }

constructor TJSTableField.Create;
begin
//
end;

destructor TJSTableField.Destroy;
begin
  //
  inherited;
end;

function TJSTableField.DisplayName(AValue: String): IJSTableField;
begin
  Result := Self;
  FDisplayName := AValue;
end;

function TJSTableField.DisplayName: String;
begin
  Result := FDisplayName;
end;

function TJSTableField.FieldName: String;
begin
  Result := FFieldName;
end;

function TJSTableField.FieldName(AValue: String): IJSTableField;
begin
  Result := Self;
  FFieldName := AValue;
end;

function TJSTableField.FieldType(AValue: TEnumFieldType): IJSTableField;
begin
  Result := Self;
  FFieldType := AValue;
end;

function TJSTableField.FieldType: TEnumFieldType;
begin
  Result := FFieldType;
end;

class function TJSTableField.New: IJSTableField;
begin
  Result := Self.Create;
end;

function TJSTableField.NotNull: Boolean;
begin
  Result := FNotNull;
end;

function TJSTableField.NotNull(AValue: Boolean): IJSTableField;
begin
  Result := Self;
  FNotNull := AValue;
end;

function TJSTableField.PrimaryKey(AValue: Boolean): IJSTableField;
begin
  Result := Self;
  FPrimaryKey := AValue;
end;

function TJSTableField.PrimaryKey: Boolean;
begin
  Result := FPrimaryKey;
end;

function TJSTableField.Scale(AValue: Integer): IJSTableField;
begin
  Result := Self;
  FScale := AValue;
end;

function TJSTableField.Scale: Integer;
begin
  Result := FScale;
end;

function TJSTableField.Size: Integer;
begin
  Result := FSize;
end;

function TJSTableField.Size(AValue: Integer): IJSTableField;
begin
  Result := Self;
  FSize := AValue;
end;

function TJSTableField.SubType(AValue: TEnumSubType): IJSTableField;
begin
  Result := Self;
  FSubType := AValue;
end;

function TJSTableField.SubType: TEnumSubType;
begin
  Result := FSubType;
end;

{ TJSDataBase }

function TJSDataBase.CheckCreateIndexs(ATableName: String; AIndexs: TList<IJSTableIndex>): IJSDataBase;
var
  lI: Integer;
  lAchou: Boolean;
begin
  Result := Self;

  // Firebird
  if (AnsiUpperCase(FFDConn.DriverName) = 'FB') then
  Begin
    FQry1.SQL.Clear;
    FQry1.SQL.Add(
      ' select                                  ' +
      '   rdb$index_name                        ' +
      ' from                                    ' +
      '   rdb$indices                           ' +
      ' where                                   ' +
      '   lower(rdb$relation_name) = :atablename'
    );
    FQry1.Params[0].AsString := AnsiLowerCase(ATableName);
  End;

  // MySQL
  if (AnsiUpperCase(FFDConn.DriverName) = 'MYSQL') then
  Begin
    FQry1.SQL.Clear;
    FQry1.SQL.Add(
      ' select                                ' +
      '   index_name                          ' +
      ' from                                  ' +
      '   information_schema.statistics       ' +
      ' where                                 ' +
      '   lower(table_schema) = :table_schema ' +
      ' and                                   ' +
      '   lower(table_name) = :table_name     '
    );
    FQry1.Params[0].AsString := FFDConn.Params.Database;
    FQry1.Params[1].AsString := AnsiLowerCase(ATableName);
  End;

  Try
    FQry1.Open;
  Except
    on E: Exception do
      ShowMessage(E.ClassName + ' ' + E.Message + ' ' + Self.UnitName + 'CheckCreateIndexs_OPEN');
  End;

  for lI := 0 to Pred(AIndexs.Count) do
  Begin
    FQry1.First;
    while not FQry1.Eof do
    Begin
      lAchou := False;
      if (AnsiLowerCase(FQry1.Fields[0].AsString.Trim) = AnsiLowerCase(AIndexs.Items[lI].IndexName.Trim)) then
      Begin
        lAchou := True;
        Break;
      End;

      FQry1.Next;
      Application.ProcessMessages;
    End;

    // Se não existir, Cria!
    if not lAchou then
    Begin
      FQry2.Close;
      FQry2.SQL.Clear;

      // Firebird
      if (AnsiUpperCase(FFDConn.DriverName) = 'FB') then
      Begin
        FQry2.SQL.Add(
          ' create index ' + AnsiLowerCase(AIndexs.Items[lI].IndexName.Trim) +
          ' on '           + AnsiLowerCase(ATableName) +
          ' ('             + AIndexs.Items[lI].Fields + ') '
        );
      End;

      // MySQL
      if (AnsiUpperCase(FFDConn.DriverName) = 'MYSQL') then
      Begin
        FQry2.SQL.Add(
          ' alter table ' + AnsiLowerCase(ATableName) +
          ' add index '   + AnsiLowerCase(AIndexs.Items[lI].IndexName.Trim) +
          ' ('            + AIndexs.Items[lI].Fields + ' asc) visible'
        );
      End;

      Try
        FQry2.ExecSQL;
      Except
        on E: Exception do
          ShowMessage(E.ClassName + ' ' + E.Message + ' ' + Self.UnitName + 'CheckCreateIndexs_EXECSQL');
      End;
    End;
  End;
end;

function TJSDataBase.CheckCreateFields(ATableName: String; AFields: TList<IJSTableField>): IJSDataBase;
var
  lI: Integer;
  lFieldType, lSubType, lSize, lNotNull: String;
begin
  Try
    FQry1.Open('select * from ' + ATableName + ' where ' + AFields.Items[0].FieldName + ' = ' + QuotedStr('0'));
  Except
    on E: Exception do
      ShowMessage(E.ClassName + ' ' + E.Message + ' ' + Self.UnitName + 'CheckCreateFields_OPEN');
  End;

  for lI := 0 to Pred(AFields.Count) do
  Begin
    // Se não existir, Cria!
    if (FQry1.FindField(AFields.Items[lI].FieldName) = nil) then
    begin
      lFieldType := FieldTypeStr(AFields.Items[lI].FieldType);
      lSubType   := SubTypeStr(AFields.Items[lI].SubType);
      lSize      := SizeStr(AFields.Items[lI].Size, AFields.Items[lI].SubType);
      lNotNull   := NotNullStr(AFields.Items[lI].NotNull);

      FQry2.SQL.Clear;
      FQry2.SQL.Add(
        ' alter table ' + ATableName +
        ' add ' + AFields.Items[lI].FieldName + lFieldType + lSubType + lSize + lNotNull
      );

      Try
        FQry2.ExecSQL;
      Except
        on E: Exception do
          ShowMessage(E.ClassName + ' ' + E.Message + ' ' + Self.UnitName + 'CheckCreateFields');
      End;
    end;
  End;
end;

constructor TJSDataBase.Create;
begin
  FTables := TList<IJSTable>.Create;
  FQry1 := TFDQuery.Create(nil);
  FQry2 := TFDQuery.Create(nil);
end;

function TJSDataBase.CreateTable(ATableName: String; AFields: TList<IJSTableField>): IJSDataBase;
var
  lFieldType0, lFieldType1: String;
  lSize0, lSize1: String;
  lNotNull0, lNotNull1: String;
begin
  // Campo 1
  lFieldType0 := FieldTypeStr(AFields.Items[0].FieldType);
  lSize0      := SizeStr(AFields.Items[0].Size, AFields.Items[0].SubType);
  lNotNull0   := NotNullStr(AFields.Items[0].NotNull);

  // Campo 2
  lFieldType1 := FieldTypeStr(AFields.Items[1].FieldType);
  lSize1      := SizeStr(AFields.Items[1].Size, AFields.Items[1].SubType);
  lNotNull1   := NotNullStr(AFields.Items[1].NotNull);

  // Criar JSTable
  FQry1.SQL.Clear;
  FQry1.SQL.Add(
    ' create table ' + ATableName + ' ( ' +
      AFields.Items[0].FieldName + lFieldType0 + lSize0 + lNotNull0 + ', ' +
      AFields.Items[1].FieldName + lFieldType1 + lSize1 + lNotNull1 + '  ' +
    ' ) '
  );
  try
    FQry1.ExecSQL;
  Except
    on E: Exception do
      ShowMessage(E.ClassName + ' ' + E.Message + ' ' + Self.UnitName + 'CreateTable');
  end;

  // Criar Chave Primária
  FQry1.SQL.Clear;
  FQry1.SQL.Add(
    ' alter table ' + ATableName +
    ' add constraint pk_' + ATableName +
    ' primary key (' + PrimaryKeyStr(AFields) + ')'
  );
  try
    FQry1.ExecSQL;
  Except
    on E: Exception do
      ShowMessage(E.ClassName + ' ' + E.Message + ' ' + Self.UnitName + 'CreateTable_PrimaryKey');
  end;
end;

destructor TJSDataBase.Destroy;
begin
  if Assigned(FTables) then
    FreeAndNil(FTables);

  if Assigned(FQry1) then
    FreeAndNil(FQry1);

  if Assigned(FQry2) then
    FreeAndNil(FQry2);

  inherited;
end;

function TJSDataBase.FieldTypeStr(AFieldType: TEnumFieldType): String;
begin
  // Definir o primeiro campo
  case AFieldType of
    eftInteger:  Result := ' integer ';
    eftString:   Result := ' varchar ';
    eftDate:     Result := ' date ';
    eftTime:     Result := ' time ';
    eftDecimal:  Result := ' decimal ';
    eftBlob:     Result := ' blob ';
    eftLongBlob: Result := ' longblob ';
  end;
end;

function TJSDataBase.Tables: TList<IJSTable>;
begin
  Result := FTables;
end;

class function TJSDataBase.New: IJSDataBase;
begin
  Result := Self.Create;
end;

function TJSDataBase.NotNullStr(ANotNull: Boolean): String;
begin
  Result := '';

  if ANotNull then
    Result := ' not null ';
end;

function TJSDataBase.PrimaryKeyStr(AFields: TList<IJSTableField>): String;
var
  lI: Integer;
begin
  Result := '';

  for lI := 0 to Pred(AFields.Count) do
    if AFields.Items[lI].PrimaryKey then
      if Result.IsEmpty then
        Result := AFields.Items[lI].FieldName
      else
        Result := Result + ', ' + AFields.Items[lI].FieldName;
end;

function TJSDataBase.SizeStr(ASize: Integer; ASubType: TEnumSubType): String;
begin
  Result := '';

  case ASubType of
    estNone: Begin
      if (ASize > 0) then
        Result := ' (' + ASize.ToString + ') ';
    End;

    estBinary, estText: Begin
      Result := ' segment size ' + ASize.ToString + ' ';
    End;
  end;

end;

function TJSDataBase.SubTypeStr(ASubType: TEnumSubType): String;
begin
  case ASubType of
    estNone:   Result := '';
    estBinary: Result := ' sub_type 0 ';
    estText:   Result := ' sub_type 1 ';
  end;
end;

function TJSDataBase.TableExists(ATableName: String): Boolean;
Begin
  Result := False;

  // Firebird
  if (AnsiUpperCase(FFDConn.DriverName) = 'FB') then
  Begin
    FQry1.SQL.Clear;
    FQry1.SQL.Add(
      ' select                                  ' +
      '   *                                     ' +
      ' from                                    ' +
      '   rdb$relations                         ' +
      ' where                                   ' +
      '   rdb$flags = 1                         ' +
      ' and                                     ' +
      '   lower(rdb$relation_name) = :tablename '
    );
    FQry1.Params[0].AsString := AnsiLowerCase(ATableName);
  End;

  // MySQL
  if (AnsiUpperCase(FFDConn.DriverName) = 'MYSQL') then
  Begin
    FQry1.SQL.Clear;
    FQry1.SQL.Add(
      ' select                                ' +
      '   *                                   ' +
      ' from                                  ' +
      '   information_schema.tables           ' +
      ' where                                 ' +
      '   lower(table_schema) = :table_schema ' +
      ' and                                   ' +
      '   lower(table_name) = :table_name'
    );
    FQry1.Params[0].AsString := FFDConn.Params.Database;
    FQry1.Params[1].AsString := AnsiLowerCase(ATableName);
  End;

  Try
    FQry1.Open;
  Except
    on E: Exception do
      ShowMessage(E.ClassName + ' ' + E.Message + ' ' + Self.UnitName + 'TableExists');
  End;

  if not FQry1.IsEmpty then
    Result := True;
end;

function TJSDataBase.UpdateDB(AFDConn: TFDConnection): IJSDataBase;
var
  lI, lJ: Integer;
begin
  FFDConn := AFDConn;
  FQry1.Connection := FFDConn;
  FQry2.Connection := FFDConn;

  // Verificar conexão antes de prosseguir
  if not FFDConn.Connected Then
  Begin
    Try
      FFDConn.Connected := True;
    Except
      on E: Exception do
      Begin
        ShowMessage(E.ClassName + ' ' + E.Message + ' ' + Self.UnitName + 'TableExists');
        Abort;
      End;
    End;
  End;


  // Percorrer JSTables (Criar,Atualizar JSTables,Campos)
  for lI := 0 to Pred(FTables.Count) do
  Begin
    if not TableExists(FTables.Items[lI].Description) Then
      CreateTable(FTables.Items[lI].Description, FTables.Items[lI].Fields);

    CheckCreateFields(FTables.Items[lI].Description, FTables.Items[lI].Fields);
    CheckCreateIndexs(FTables.Items[lI].Description, FTables.Items[lI].Indexs);
  End;
end;

{ TJSTableIndex }

constructor TJSTableIndex.Create;
begin
//
end;

destructor TJSTableIndex.Destroy;
begin
  //
  inherited;
end;

function TJSTableIndex.Fields: String;
begin
  Result := FFields;
end;

function TJSTableIndex.Fields(AValue: String): IJSTableIndex;
begin
  Result := Self;
  FFields := aValue;
end;

function TJSTableIndex.IndexName: String;
begin
  Result := FIndexName;
end;

function TJSTableIndex.IndexName(AValue: String): IJSTableIndex;
begin
  Result := Self;
  FIndexName := aValue;
end;

class function TJSTableIndex.New: IJSTableIndex;
begin
  Result := Self.Create;
end;

end.
