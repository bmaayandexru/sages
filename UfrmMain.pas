unit UfrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TPair = record
    n1, n2: integer;
  end;
  TAPairs = array[1..100] of TPair;
  TValue = record
    val: Integer;
    cPairs: Integer;
    arPairs: TAPairs;
  end;
  TAValues = array [1..10000] of TValue;

  TfrmMain = class(TForm)
    btnSimpleNumber: TButton;
    memOut: TMemo;
    btnSums: TButton;
    btnMuls: TButton;
    procedure btnSimpleNumberClick(Sender: TObject);
    procedure btnSumsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnMulsClick(Sender: TObject);
  private
    { Private declarations }
    Showed: boolean;
    arSN:array[1..25] of integer;
    countSN: Integer;
    arSums, arMuls: TAValues;
    sumCount, mulCount:Integer;
    procedure ShowArSimpleNum;
    function SimpleNum(num: Integer): boolean;
    procedure AddSumValue(val1, val2, sum: Integer);
    procedure AddMulValue(val1, val2, mul: Integer);
    function ThereArePair(val1, val2: Integer; v: TValue):boolean;

    procedure ShowSumsValues;
    procedure ShowMulsValues;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}


function TfrmMain.SimpleNum(num: Integer):boolean;
var
  i: Integer;
begin
  Result:=false;
  for i := 1 to countSN do begin
    if num = arSN[i] then begin
      Result := true;
      exit;
    end;
  end;
end;


function TfrmMain.ThereArePair(val1, val2: Integer; v: TValue):boolean;
var
  i: Integer;
begin
  // ���� ���� � ������� ���
  Result:=false;
  for i := 1 to v.cPairs do begin
    if ((v.arPairs[i].n1 = val1) and (v.arPairs[i].n2 = val2)) or ((v.arPairs[i].n2 = val1) and (v.arPairs[i].n1 = val2)) then begin
      Result := true;
      exit;
    end;
  end;
end;

procedure TfrmMain.AddSumValue(val1, val2, sum: Integer);
var
  i: Integer;
  found: Boolean;
begin
  if sum >= 100 then exit;
  // ��������� ���� �� ��� � ������� ���
  // ���� ���� ��������� ����
  // ���� ��� ��������� � �������� � ����

  // ������������ ��� ����� ���
  found := false;
  for i := 1 to sumCount do begin
    if arSums[i].val = sum then begin
      // ����� ����. ��������� ���� ���� �� ���
      found := true;
      if not ThereArePair(val1,val2,arSums[i]) then begin
        inc(arSums[i].cPairs);
        arSums[i].arPairs[arSums[i].cPairs].n1:=val1;
        arSums[i].arPairs[arSums[i].cPairs].n2:=val2;
      end;
      exit;
    end
  end;
  if not found then begin
    // ����� ���. ��������� � �������� � ����
    inc(sumCount);
    i:=sumCount;
    arSums[i].val := sum;
    inc(arSums[i].cPairs);
    arSums[i].arPairs[arSums[i].cPairs].n1:=val1;
    arSums[i].arPairs[arSums[i].cPairs].n2:=val2;
  end;
end;

procedure TfrmMain.ShowSumsValues();
var
  i, j: Integer;
  s: String;
begin
  for i:=1 to sumCount do begin
    s:='(sum: '+IntToStr(arSums[i].val)+' pairs';
    for j := 1 to arSums[i].cPairs do
      s:=s + format('(%d,%d)',[arSums[i].arPairs[j].n1,arSums[i].arPairs[j].n2]);
    s:=s+')';
    memOut.Lines.Add(s);
  end;
  memOut.Lines.Add('sum count '+IntToStr(sumCount));
end;

procedure TfrmMain.ShowMulsValues();
var
  i, j: Integer;
  s: String;
begin
  for i:=1 to mulCount do begin
    s:='(mul: '+IntToStr(arMuls[i].val)+' pairs';
    for j := 1 to arMuls[i].cPairs do
      s:=s + format('(%d,%d)',[arMuls[i].arPairs[j].n1,arMuls[i].arPairs[j].n2]);
    s:=s+')';
    memOut.Lines.Add(s);
  end;
  memOut.Lines.Add('mul count '+IntToStr(mulCount));
end;

procedure TfrmMain.AddMulValue(val1, val2, mul: Integer);
var
  i: Integer;
  found: Boolean;
begin
  // ��������� ���� �� ��� � ������� ���
  // ���� ���� ��������� ����
  // ���� ��� ��������� � �������� � ����

  // ������������ ��� ������������ ���
  found := false;
  for i := 1 to mulCount do begin
    if arMuls[i].val = mul then begin
      // ������������ ���� ����. ��������� ���� ���� �� ���
      found := true;
      if not ThereArePair(val1,val2,arMuls[i]) then begin
        inc(arMuls[i].cPairs);
        arMuls[i].arPairs[arMuls[i].cPairs].n1:=val1;
        arMuls[i].arPairs[arMuls[i].cPairs].n2:=val2;
      end;
      exit;
    end
  end;
  if not found then begin
    // ������������ ���. ��������� � �������� � ����
    inc(mulCount);
    i:=mulCount;
    arMuls[i].val := mul;
    inc(arMuls[i].cPairs);
    arMuls[i].arPairs[arMuls[i].cPairs].n1:=val1;
    arMuls[i].arPairs[arMuls[i].cPairs].n2:=val2;
  end;
end;

procedure TfrmMain.btnSumsClick(Sender: TObject);
var
  i, j: Integer;
begin
  sumCount:=0;
  for i := 2 to 99 do
    for j := 2 to 99 do begin
      if i <> j then begin
        // numbers not equ
        if not (SimpleNum(i) and SimpleNum(j))  then begin
          // ��������� ���� ���� �� ���� �� �������
          AddSumValue(i, j, i+j);
          // AddMulValue(i, j, i*j);
        end;
      end;
    end;
  ShowSumsValues();
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  if Showed then exit;
  btnSimpleNumberClick(btnSimpleNumber);
end;

procedure TfrmMain.ShowArSimpleNum();
var
  s: String;
  i:Integer;
begin
  s:='(';
  for i := 1 to countSN-1 do begin
    s:= s + IntToStr(arSN[i])+ ',';
  end;
  s:= s + IntToStr(arSN[i])+ ')';
  memOut.Lines.Add(s);
end;

procedure TfrmMain.btnMulsClick(Sender: TObject);
var
  i, j: Integer;
begin
  mulCount:=0;
  for i := 2 to 99 do
    for j := 2 to 99 do begin
      if i <> j then begin
        // numbers not equ
        if not (SimpleNum(i) and SimpleNum(j))  then begin
          // ��������� ���� ���� �� ���� �� �������
          AddMulValue(i, j, i*j);
        end;
      end;
    end;
  ShowMulsValues();
end;

procedure TfrmMain.btnSimpleNumberClick(Sender: TObject);
var
  i, j: Integer;
  fsn:boolean;
begin
  countSN := 0;
  for i:=2 to 99 do begin
    if countSN = 0 then begin
      // add 2
      inc(countSN);
      arSN[countSN]:=i; // or 2
    end else begin
      fsn := True;
      for j := 1 to countSN do begin
        if i mod arSN[j] = 0  then begin
          fsn :=false;
          break;
        end;
      end;
      if fsn then begin
        // found simple number
        inc(countSN);
        arSN[countSN]:=i;
      end;
    end;
  end;
  ShowArSimpleNum();
end;

end.
