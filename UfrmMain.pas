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
    btnClearSSsum: TButton;
    btnClrSumsByMul: TButton;
    procedure btnSimpleNumberClick(Sender: TObject);
    procedure btnSumsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnClearSSsumClick(Sender: TObject);
    procedure memOutDblClick(Sender: TObject);
    procedure btnClrSumsByMulClick(Sender: TObject);
  private
    { Private declarations }
    Showed : boolean;
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
    function CheckSS(v: TValue): Boolean;
    procedure AddMul(n1, n2: Integer);
    procedure AddMuls(sum: TValue);
    procedure ShowSumsValuesMuls;
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
  // ищем пару в массиве пар
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
  // проверяем есть ли оно в массиве уже
  // если есть добавляем пару
  // если нет добавляем и значение и пару

  // предполагаем что суммы нет
  found := false;
  for i := 1 to sumCount do begin
    if arSums[i].val = sum then begin
      // сумма есть. добавляем пару усди ее нет
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
    // суммы нет. добавляем и значение и пару
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
    if arSums[i].val <> 0 then begin
      s:='(sum: '+IntToStr(arSums[i].val)+' pairs';
      for j := 1 to arSums[i].cPairs do
        s:=s + format('(%d,%d)',[arSums[i].arPairs[j].n1,arSums[i].arPairs[j].n2]);
      s:=s+')';
      memOut.Lines.Add(s);
    end;
  end;
  memOut.Lines.Add('sum count '+IntToStr(sumCount));
end;

procedure TfrmMain.ShowSumsValuesMuls();
var
  i, j: Integer;
  s: String;
begin
  for i:=1 to sumCount do begin
    if arSums[i].val <> 0 then begin
      s:='(sum: '+IntToStr(arSums[i].val)+' pMul';
      for j := 1 to arSums[i].cPairs do
        if arSums[i].arPairs[j].n1*arSums[i].arPairs[j].n2 <> 0 then
          s:=s + format('(%d)',[arSums[i].arPairs[j].n1*arSums[i].arPairs[j].n2]);
      s:=s+')';
      memOut.Lines.Add(s);
    end;
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
begin

end;

procedure TfrmMain.btnSumsClick(Sender: TObject);
var
  i, j: Integer;
begin
  sumCount:=0;
  mulCount:=0;
  for i := 2 to 99 do
    for j := 2 to 99 do begin
//      if i <> j then begin
      if true then begin
        // numbers not equ
//        if not (SimpleNum(i) and SimpleNum(j))  then begin
        if true  then begin
          // добавляем если хотя бы одно на простое
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

procedure TfrmMain.memOutDblClick(Sender: TObject);
begin
  memOut.Clear;
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

function TfrmMain.CheckSS(v:TValue): Boolean;
var
  i: Integer;
begin
  Result:=false;
  for i := 1 to v.cPairs do begin
//    if (SimpleNum(v.arPairs[i].n1) and SimpleNum(v.arPairs[i].n2))or(v.arPairs[i].n1 + v.arPairs[i].n2 > 100) then begin
    if (SimpleNum(v.arPairs[i].n1) and SimpleNum(v.arPairs[i].n2)) then begin
      Result :=true;
      exit;
    end;
  end;
end;

procedure TfrmMain.btnClearSSsumClick(Sender: TObject);
var
  i, j: Integer;
begin
  for i := 1 to sumCount do begin
    if CheckSS(arSums[i]) then begin
      // исключаем если находим хотя бы одну пару простых чисел
      arSums[i].val := 0;
    end;
  end;
  ShowSumsValues();
  ShowSumsValuesMuls();
end;

procedure TfrmMain.AddMul(n1,n2: Integer);
var
  i: Integer;
  found: Boolean;
begin
  found := false; // предполагаем что произведения нет
  for i := 1 to mulCount do begin
    if arMuls[i].val = n1*n2 then begin
      // можно проверить есть ли пара уже в списке!!!!!!!!!!!!!! пока не делаем
      // добавляем в список пар
      inc(arMuls[i].cPairs);
      arMuls[i].arPairs[arMuls[i].cPairs].n1 := n1;
      arMuls[i].arPairs[arMuls[i].cPairs].n2 := n2;
      found := true;
      break;
    end;
  end;
  if not found then begin
    // произведения нет в списке
    inc(mulCount);
    arMuls[mulCount].val := n1*n2;
    inc(arMuls[mulCount].cPairs);
    arMuls[mulCount].arPairs[arMuls[mulCount].cPairs].n1 := n1;
    arMuls[mulCount].arPairs[arMuls[mulCount].cPairs].n2 := n2;
  end;
end;

procedure TfrmMain.AddMuls(sum:TValue);
var
  i: Integer;
begin
  //добавляем пары из списка пар текущей суммы в список произведение
  for i := 1 to sum.cPairs do begin
    AddMul(sum.arPairs[i].n1,sum.arPairs[i].n2);
  end;
end;

procedure TfrmMain.btnClrSumsByMulClick(Sender: TObject);
var
  i, ii, j, k: Integer;
  mulval: integer;
  found: Boolean;
begin
  // множество произведений из слагаемых оставшихся сумм
  // стираем пару если находим произведение в других списках
  // в других спиках тоже стрираем пары которе дают тоже произведение
  for i := 1 to sumCount do begin
    if arSums[i].val <> 0 then begin
      // сумма в списке
      // проходим по списку пар данной суммы и ищем произведение каждой пары
      // в списках произведений пар других сумм
      for ii := 1 to arSums[i].cPairs do
        if arSums[i].arPairs[ii].n1 * arSums[i].arPairs[ii].n2 <> 0 then begin
          mulval := arSums[i].arPairs[ii].n1 * arSums[i].arPairs[ii].n2;
          found:=false;
          for j := 1 to sumCount do begin
            if (arSums[j].val <> 0)and(i<>j) then begin
              // ищем sval во всех других множествах и обнуляем пары с таким же произведением
              for k := 1 to arSums[j].cPairs do begin
                if arSums[j].arPairs[k].n1*arSums[j].arPairs[k].n2 = mulval then begin
                  arSums[j].arPairs[k].n1 := 0;
                  arSums[j].arPairs[k].n2 := 0;
                  found:=true;
                end;
              end;
            end;
          end;
          // если были найдены дубликаты произведения то обнуляем и саму пару
          if found then begin
            arSums[i].arPairs[ii].n1 := 0;
            arSums[i].arPairs[ii].n2 := 0;
          end;
        end;
    end;
  end;
  ShowSumsValuesMuls;
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
