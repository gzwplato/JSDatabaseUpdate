program updDB;

uses
  Vcl.Forms,
  Principal.View in 'Principal.View.pas' {PrincipalView},
  JS.DatabaseUpdate.Interfaces in '..\..\src\JS.DatabaseUpdate.Interfaces.pas',
  JS.DatabaseUpdate in '..\..\src\JS.DatabaseUpdate.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TPrincipalView, PrincipalView);
  Application.Run;
end.
