unit FMX.CustomCalendar.Style;

interface

Uses FMX.Calendar.Style, FMX.Presentation.Messages, FMX.Controls.Model, FMX.ListBox;

Type
  TCustomCalendar = Class(TStyledCalendar)
  Protected
    Procedure MMDataChanged(var AMessage: TDispatchMessageWithValue<TDataRecord>); message MM_DATA_CHANGED;
  Protected
    Procedure FillDays; Override;
    Procedure AddEvent(AEvent: TListBoxItem);
    Procedure RemoveEvents;
    Procedure PaintEvents;
  End;

implementation

Uses FMX.Objects, FMX.Types, FMX.Controls, System.SysUtils, FMX.Presentation.Factory,
  FMX.Presentation.Style, FMX.Calendar, FMX.Graphics;

{ TCustomCalendar }

procedure TCustomCalendar.AddEvent(AEvent: TListBoxItem);
Var
  ABack: TCircle;
begin
  ABack := TCircle.Create(nil);
  ABack.Name := '_back';
  ABack.HitTest := false;
  ABack.Align := TAlignLayout.Contents;
  ABack.Stroke.Kind := TBrushKind.None;
  ABack.Fill.Color := $ff74b9ff;
  AEvent.InsertObject(0, ABack);
end;

procedure TCustomCalendar.FillDays;
begin
  inherited;
  RemoveEvents;
  PaintEvents;
end;

procedure TCustomCalendar.MMDataChanged(var AMessage: TDispatchMessageWithValue<TDataRecord>);
begin
  if (SameText(AMessage.Value.Key, 'Events')) then
    FillCalendar
  else
    inherited;
end;

procedure TCustomCalendar.PaintEvents;
begin
  if Model.Data['Events'].IsType<TArray<TDateTime>> then
  begin
    var AEvents: TArray<TDateTime> := Model.Data['Events'].AsType<TArray<TDateTime>>;
    for var AEvent: TDateTime in AEvents do
    begin
      var AItem: TListBoxItem := TryFindDayItem(AEvent);
      if (AItem <> nil) then
        AddEvent(AItem);
    end;
  end;
end;

procedure TCustomCalendar.RemoveEvents;
begin
  if (Days <> nil) then
    for var i: Integer := 0 to Days.Count-1 do
    begin
      var AEvent: TListBoxItem := Days.ListItems[i];
      for var j: Integer := AEvent.Controls.Count-1 DownTo 0 do
        if SameText(AEvent.Controls[j].Name, '_back') then
        begin
          var AControl: TControl := AEvent.Controls[0];
          AControl.Parent := nil;
          AControl.DisposeOf;
        end;
    end;
end;

Initialization
  TPresentationProxyFactory.Current.Replace(TCalendar, TControlType.Styled, TStyledPresentationProxy<TCustomCalendar>);

Finalization
  TPresentationProxyFactory.Current.Replace(TCalendar, TControlType.Styled, TStyledPresentationProxy<TStyledCalendar>);

end.
