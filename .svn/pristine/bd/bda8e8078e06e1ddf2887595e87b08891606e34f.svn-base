unit Principal.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Phys.IBBase,
  Data.DB, FireDAC.Comp.Client, FireDAC.Dapt, Vcl.StdCtrls, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef;

type
  TPrincipalView = class(TForm)
    Button1: TButton;
    FDConnection1: TFDConnection;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    Memo1: TMemo;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrincipalView: TPrincipalView;

implementation

{$R *.dfm}

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

end.
