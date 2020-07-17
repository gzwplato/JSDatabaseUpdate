program updDB;

uses
  Vcl.Forms,
  Principal.View in 'Principal.View.pas' {PrincipalView},
  JS.DatabaseManager.Interfaces in '..\..\src\JS.DatabaseManager.Interfaces.pas',
  JS.DatabaseManager in '..\..\src\JS.DatabaseManager.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TPrincipalView, PrincipalView);
  Application.Run;
end.
