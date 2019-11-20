program Calendar;

uses
  System.StartUpCopy,
  FMX.Forms,
  Main in 'Main.pas' {fMain},
  FMX.CustomCalendar.Style in 'FMX.CustomCalendar.Style.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfMain, fMain);
  Application.Run;
end.
