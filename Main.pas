unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Calendar;

type
  TfMain = class(TForm)
    calMain: TCalendar;
    butMain: TButton;
    procedure butMainClick(Sender: TObject);
  private
    { Private declarations }
    FEvents: TArray<TDateTime>;
  public
    { Public declarations }
  end;

var
  fMain: TfMain;

implementation

{$R *.fmx}

Uses System.Rtti;

procedure TfMain.butMainClick(Sender: TObject);
begin
  Self.FEvents := TArray<TDateTime>.Create();
  SetLength(Self.FEvents, 3);
  Self.FEvents[0] := now-4;
  Self.FEvents[1] := now-2;
  Self.FEvents[2] := now+4;
  calMain.Model.Data['Events'] := TValue.From<TArray<TDateTime>>(Self.FEvents);
end;

end.
