unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ScktComp, ComCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    RichEdit1: TRichEdit;
    ClientSocket1: TClientSocket;
    ServerSocket1: TServerSocket;
    Edit1: TEdit;
    Edit3: TEdit;
    Button1: TButton;
    Button2: TButton;
    Label2: TLabel;
    Edit4: TEdit;
    ScrollBar1: TScrollBar;
    ColorBox1: TColorBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Label1: TLabel;
    RadioGroup1: TRadioGroup;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ServerSocket1ClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure ClientSocket1Connect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ScrollBar1Change(Sender: TObject);
    procedure ColorBox1Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  temp:string;
  check:integer;
  talknow:string;

implementation

{$R *.dfm}

procedure TForm1.Button2Click(Sender: TObject);
begin
serversocket1.Port:=2000;
serversocket1.Open;
edit1.Enabled:=false;
button1.Enabled:=false;
button1.Enabled:=false;
edit1.Visible:=false;
button1.Visible:=false;
button2.Visible:=false;
label1.Caption:='Server';
label1.Visible:=true;
check:=2;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
clientsocket1.Port:=2000;
clientsocket1.Address:=edit1.Text;
clientsocket1.open;
edit1.Enabled:=false;
button1.Enabled:=false;
button1.Enabled:=false;
edit1.Visible:=false;
button1.Visible:=false;
button2.Visible:=false;
label1.Caption:='Client';
label1.Visible:=true;
check:=1;
end;

procedure TForm1.ServerSocket1ClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
temp:=serversocket1.Socket.Connections[0].ReceiveText;
if copy(temp,1,7)='connect' then
begin
showmessage('Connected');
serversocket1.Socket.Connections[0].SendText('connect');
end;
end;

procedure TForm1.ClientSocket1Read(Sender: TObject;
  Socket: TCustomWinSocket);
begin
 temp:=clientsocket1.Socket.ReceiveText;

if copy(temp,1,1)='!' then
begin
if talknow<>copy(temp,2,pos('@',temp)-2) then
richedit1.Text:=richedit1.Text+copy(temp,2,pos('@',temp)-2)+' : '+copy(temp,pos('@',temp)+1,length(temp)-pos('@',temp))
else
richedit1.Text:=richedit1.Text+copy(temp,pos('@',temp)+1,length(temp)-pos('@',temp));
talknow:=copy(temp,2,pos('@',temp)-2);
end
else if copy(temp,1,4)='size' then
begin
richedit1.SelStart:=strtoint(copy(temp,5,pos('!',temp)-5));
 richedit1.SelLength:=strtoint(copy(temp,pos('!',temp)+1,pos('@',temp)-pos('!',temp)-1));
 richedit1.SelAttributes.Size:=strtoint(copy(temp,pos('@',temp)+1,length(temp)-pos('@',temp)));
end
else if copy(temp,1,5)='color' then
begin
richedit1.SelStart:=strtoint(copy(temp,6,pos('!',temp)-6));
 richedit1.SelLength:=strtoint(copy(temp,pos('!',temp)+1,pos('@',temp)-pos('!',temp)-1));
 richedit1.SelAttributes.Color:=stringtocolor(copy(temp,pos('@',temp)+1,length(temp)-pos('@',temp)));
end
else if copy(temp,1,5)='style' then
begin
richedit1.SelStart:=strtoint(copy(temp,8,pos('!',temp)-8));
richedit1.SelLength:=strtoint(copy(temp,pos('!',temp)+1,length(temp)-pos('!',temp)));
  if copy(temp,6,1)='+' then
  begin
  if copy(temp,7,1)='b' then
  richedit1.SelAttributes.Style:=richedit1.SelAttributes.Style+[fsbold]
  else if copy(temp,7,1)='i' then
  richedit1.SelAttributes.Style:=richedit1.SelAttributes.Style+[fsitalic]
  else if copy(temp,7,1)='u' then
  richedit1.SelAttributes.Style:=richedit1.SelAttributes.Style+[fsunderline];
  end

  else if copy(temp,6,1)='-' then
  begin
  if copy(temp,7,1)='b' then
  richedit1.SelAttributes.Style:=richedit1.SelAttributes.Style-[fsbold]
  else if copy(temp,7,1)='i' then
  richedit1.SelAttributes.Style:=richedit1.SelAttributes.Style-[fsitalic]
  else if copy(temp,7,1)='u' then
  richedit1.SelAttributes.Style:=richedit1.SelAttributes.Style-[fsunderline];
  end;
  end
  else if copy(temp,1,4)='font' then
  begin
  richedit1.SelStart:=strtoint(copy(temp,5,pos('!',temp)-5));
  richedit1.SelLength:=strtoint(copy(temp,pos('!',temp)+1,pos('@',temp)- pos('!',temp)-1));
  richedit1.SelAttributes.Name:=copy(temp,pos('@',temp)+1,length(temp)-pos('@',temp));
  
end;
end;

procedure TForm1.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
begin
if check=2 then
begin
serversocket1.Socket.connections[0].SendText('!'+edit4.Text+'@'+edit3.Text+#13);
if talknow <> edit4.Text then
richedit1.Text:=richedit1.Text+edit4.Text+' : '+edit3.Text
else
richedit1.Text:=richedit1.Text+edit3.Text;
edit3.Text:=' ';
talknow:=edit4.Text;
end
else if check=1 then
begin
clientsocket1.Socket.SendText('!'+edit4.Text+'@'+edit3.Text+#13);
if talknow <> edit4.Text then
richedit1.Text:=richedit1.Text+edit4.Text+' : '+edit3.Text
else
richedit1.Text:=richedit1.Text+edit3.Text;
edit3.Text:=' ';
talknow:=edit4.Text;
end;
richedit1.Text:=richedit1.Text+#13;
end;
end;

procedure TForm1.ClientSocket1Connect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
 clientsocket1.Socket.SendText('connect');
end;

procedure TForm1.ServerSocket1ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
begin
temp:=serversocket1.Socket.Connections[0].ReceiveText;
if copy(temp,1,1)='!' then
begin
if talknow<>copy(temp,2,pos('@',temp)-2) then
richedit1.Text:=richedit1.Text+copy(temp,2,pos('@',temp)-2)+' : '+copy(temp,pos('@',temp)+1,length(temp)-pos('@',temp))
else
richedit1.Text:=richedit1.Text+copy(temp,pos('@',temp)+1,length(temp)-pos('@',temp));
talknow:=copy(temp,2,pos('@',temp)-2);
end
else if copy(temp,1,4)='size' then
begin
richedit1.SelStart:=strtoint(copy(temp,5,pos('!',temp)-5));
 richedit1.SelLength:=strtoint(copy(temp,pos('!',temp)+1,pos('@',temp)-pos('!',temp)-1));
 richedit1.SelAttributes.Size:=strtoint(copy(temp,pos('@',temp)+1,length(temp)-pos('@',temp)));
end
else if copy(temp,1,5)='color' then
begin
richedit1.SelStart:=strtoint(copy(temp,6,pos('!',temp)-6));
 richedit1.SelLength:=strtoint(copy(temp,pos('!',temp)+1,pos('@',temp)-pos('!',temp)-1));
 richedit1.SelAttributes.Color:=stringtocolor(copy(temp,pos('@',temp)+1,length(temp)-pos('@',temp)));
end
else if copy(temp,1,5)='style' then
begin
richedit1.SelStart:=strtoint(copy(temp,8,pos('!',temp)-8));
richedit1.SelLength:=strtoint(copy(temp,pos('!',temp)+1,length(temp)-pos('!',temp)));
  if copy(temp,6,1)='+' then
  begin
  if copy(temp,7,1)='b' then
  richedit1.SelAttributes.Style:=richedit1.SelAttributes.Style+[fsbold]
  else if copy(temp,7,1)='i' then
  richedit1.SelAttributes.Style:=richedit1.SelAttributes.Style+[fsitalic]
  else if copy(temp,7,1)='u' then
  richedit1.SelAttributes.Style:=richedit1.SelAttributes.Style+[fsunderline];
  end

  else if copy(temp,6,1)='-' then
  begin
  if copy(temp,7,1)='b' then
  richedit1.SelAttributes.Style:=richedit1.SelAttributes.Style-[fsbold]
  else if copy(temp,7,1)='i' then
  richedit1.SelAttributes.Style:=richedit1.SelAttributes.Style-[fsitalic]
  else if copy(temp,7,1)='u' then
  richedit1.SelAttributes.Style:=richedit1.SelAttributes.Style-[fsunderline];
  end;
  end
else if copy(temp,1,4)='font' then
begin
richedit1.SelStart:=strtoint(copy(temp,5,pos('!',temp)-5));
richedit1.SelLength:=strtoint(copy(temp,pos('!',temp)+1,pos('@',temp)- pos('!',temp)-1));
richedit1.SelAttributes.Name:=copy(temp,pos('@',temp)+1,length(temp)-pos('@',temp));
end;
end;

procedure TForm1.ScrollBar1Change(Sender: TObject);
begin
richedit1.SelAttributes.Size:=scrollbar1.Position;
if check=2 then
serversocket1.Socket.Connections[0].SendText('size'+inttostr(richedit1.SelStart)+'!'+inttostr(richedit1.SelLength)+'@'+inttostr(scrollbar1.position))
else if check=1 then
clientsocket1.Socket.SendText('size'+inttostr(richedit1.SelStart)+'!'+inttostr(richedit1.SelLength)+'@'+inttostr(scrollbar1.position));
end;

procedure TForm1.ColorBox1Change(Sender: TObject);
begin
richedit1.SelAttributes.Color:=colorbox1.Selected;
if check=2 then
serversocket1.Socket.Connections[0].SendText('color'+inttostr(richedit1.SelStart)+'!'+inttostr(richedit1.SelLength)+'@'+colortostring(colorbox1.Selected))
else if check=1 then
clientsocket1.Socket.SendText('color'+inttostr(richedit1.SelStart)+'!'+inttostr(richedit1.SelLength)+'@'+colortostring(colorbox1.Selected));
end;
procedure TForm1.CheckBox1Click(Sender: TObject);
begin
if checkbox1.Checked then
begin
richedit1.SelAttributes.Style:=richedit1.SelAttributes.Style+[fsbold];
if check=2 then
serversocket1.Socket.Connections[0].SendText('style+b'+inttostr(richedit1.SelStart)+'!'+inttostr(richedit1.SelLength))
else
clientsocket1.Socket.SendText('style+b'+inttostr(richedit1.SelStart)+'!'+inttostr(richedit1.SelLength));
end
else
begin
richedit1.SelAttributes.Style:=richedit1.SelAttributes.Style-[fsbold];
if check=2 then
serversocket1.Socket.Connections[0].SendText('style-b'+inttostr(richedit1.SelStart)+'!'+inttostr(richedit1.SelLength))
else
clientsocket1.Socket.SendText('style-b'+inttostr(richedit1.SelStart)+'!'+inttostr(richedit1.SelLength));
end
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
if checkbox2.Checked then
begin
richedit1.SelAttributes.Style:=richedit1.SelAttributes.Style+[fsitalic];
if check=2 then
serversocket1.Socket.Connections[0].SendText('style+i'+inttostr(richedit1.SelStart)+'!'+inttostr(richedit1.SelLength))
else
clientsocket1.Socket.SendText('style+i'+inttostr(richedit1.SelStart)+'!'+inttostr(richedit1.SelLength));
end
else
begin
richedit1.SelAttributes.Style:=richedit1.SelAttributes.Style-[fsitalic];
if check=2 then
serversocket1.Socket.Connections[0].SendText('style-i'+inttostr(richedit1.SelStart)+'!'+inttostr(richedit1.SelLength))
else
clientsocket1.Socket.SendText('style-i'+inttostr(richedit1.SelStart)+'!'+inttostr(richedit1.SelLength));
end
end;

procedure TForm1.CheckBox3Click(Sender: TObject);
begin
if checkbox3.Checked then
begin
richedit1.SelAttributes.Style:=richedit1.SelAttributes.Style+[fsunderline];
if check=2 then
serversocket1.Socket.Connections[0].SendText('style+u'+inttostr(richedit1.SelStart)+'!'+inttostr(richedit1.SelLength))
else
clientsocket1.Socket.SendText('style+u'+inttostr(richedit1.SelStart)+'!'+inttostr(richedit1.SelLength));
end
else
begin
richedit1.SelAttributes.Style:=richedit1.SelAttributes.Style-[fsunderline];
if check=2 then
serversocket1.Socket.Connections[0].SendText('style-u'+inttostr(richedit1.SelStart)+'!'+inttostr(richedit1.SelLength))
else
clientsocket1.Socket.SendText('style-u'+inttostr(richedit1.SelStart)+'!'+inttostr(richedit1.SelLength));
end
end;

procedure TForm1.RadioGroup1Click(Sender: TObject);
var
i:integer;
begin
for i:=0 to 2 do
if radiogroup1.ItemIndex=i then
begin
richedit1.SelAttributes.Name:=radiogroup1.Items.strings[i];
if check=2 then
serversocket1.Socket.Connections[0].SendText('font'+inttostr(richedit1.SelStart)+'!'+inttostr(richedit1.SelLength)+'@'+radiogroup1.Items.strings[i])
else if check=1 then
clientsocket1.Socket.SendText('font'+inttostr(richedit1.SelStart)+'!'+inttostr(richedit1.SelLength)+'@'+radiogroup1.Items.strings[i]);
end;
end;

end.
