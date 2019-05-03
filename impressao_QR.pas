unit impressao_QR;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, DelphiZXIngQRCode,
  Printers, RLPreviewForm, RLReport;

type
  Tfrm_impressao_QR = class(TForm)
    ComboBox_encoding: TComboBox;
    GroupBox_config: TGroupBox;
    lbl_encoding: TLabel;
    edt_quietzone: TEdit;
    lbl_quietzone: TLabel;
    lbl_data: TLabel;
    edt_data: TEdit;
    btn_encode: TBitBtn;
    PaintBox_preview: TPaintBox;
    btn_17x17: TBitBtn;
    btn_27x25: TBitBtn;
    RadioGroup1: TRadioGroup;
    lbl_count: TLabel;
    lbl_preview: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PaintBox_previewPaint(Sender: TObject);
    procedure btn_encodeClick(Sender: TObject);

    procedure btn_17x17Click(Sender: TObject);
    procedure btn_27x25Click(Sender: TObject);
    procedure edt_dataEnter(Sender: TObject);
    procedure edt_dataChange(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
  private
    { Private declarations }
  public

    QRCodeBitmap : TBitmap; //Objeto tipo bitmap que vai receber o QR codificado
    { Public declarations }

  end;

var
  frm_impressao_QR: Tfrm_impressao_QR;

implementation

Uses
    frm_etiqueta_17x17mm, //opção 1 de etiqueta para QR codes de 14x14mm
    U_frm_etiqueta_27x25mm; //opção 2 de etiqueta para QR codes de 22x22mm




{$R *.dfm}


//------------------------------------------------------------------------------

procedure Tfrm_impressao_QR.btn_27x25Click(Sender: TObject);

var
    imagem :  TPicture; //variavel que vai virar um objeto vazio

begin

if RadioGroup1.ItemIndex = 0 then
begin
  Beep;
  ShowMessage('ERRO - Selecione a etiqueta correta');
  Beep;
  Exit;
end;

if edt_data.Text = '' then
begin
  Beep;
  ShowMessage('O QRCODE não pode ser gerado sem informação válida');
  Beep;
  exit;
end;


QRCodeBitmap.SaveToFile('ULTIMO_COD_IMPRESSO_22x22.BMP'); //log de ultima impres

imagem := TPicture.Create; //cria o objeto vazio imagem

imagem.Assign(QRCodeBitmap); //transfere a imagem bmp para a variavel imagem

frm_etiqueta_27x25mm.Show; //invoca a classe do form do relatorio

//tranferencia da imagem para o formulario de impressão
frm_etiqueta_27x25mm.RLImage1.Picture.Bitmap := QRCodeBitmap;
frm_etiqueta_27x25mm.RLImage2.Picture.Bitmap := QRCodeBitmap;
frm_etiqueta_27x25mm.RLImage3.Picture.Bitmap := QRCodeBitmap;

// Redimencionando o QRCODE no quadrado do formulario de impressão
frm_etiqueta_27x25mm.RLImage1.Stretch := True;
frm_etiqueta_27x25mm.RLImage2.Stretch := True;
frm_etiqueta_27x25mm.RLImage3.Stretch := True;

//chama o preview para o dialogo com a impressora e ordem de impressão
frm_etiqueta_27x25mm.etq_27x25mm.Preview();

//fecha o form invocado para o preenchimento do relatório
frm_etiqueta_27x25mm.Close;

end;

//------------------------------------------------------------------------------

procedure Tfrm_impressao_QR.btn_17x17Click(Sender: TObject);

var
    imagem :  TPicture; //variavel que vai virar um objeto vazio

begin

if RadioGroup1.ItemIndex = 1 then
begin
  Beep;
  ShowMessage('ERRO - Selecione a etiqueta correta');
  Beep;
  Exit;
end;

if edt_data.Text = '' then
begin
  Beep;
  ShowMessage('O QRCODE não pode ser gerado sem informação válida');
  Beep;
  exit;
end;

QRCodeBitmap.SaveToFile('ULTIMO_COD_IMPRESSO_14x14.BMP'); //log de ultima impres

imagem := TPicture.Create; //cria o objeto vazio imagem

imagem.Assign(QRCodeBitmap); //transfere a imagem bmp para a variavel imagem

frm_17x17mm.Show; //invoca a classe do form do relatorio

//******* TESTE DE PROCEDIMENTO, VOU MANTER NO CODIGO COMO REF.

{  for I := 0 to frm_17x17mm.ComponentCount -1 do
  begin
  if frm_17x17mm.Components[I] is TRLImage then
    TRLImage(frm_17x17mm.Components[I]).Picture.Bitmap := QRCodeBitmap;
    TRLImage(frm_17x17mm.Components[I]).Stretch := True;
  end;}

//******* TESTE DE PROCEDIMENTO, VOU MANTER NO CODIGO COMO REF. ---- FIM

//tranferencia da imagem para o formulario de impressão
frm_17x17mm.RLImage1.Picture.Bitmap := QRCodeBitmap;
frm_17x17mm.RLImage2.Picture.Bitmap := QRCodeBitmap;
frm_17x17mm.RLImage3.Picture.Bitmap := QRCodeBitmap;
frm_17x17mm.RLImage4.Picture.Bitmap := QRCodeBitmap;
frm_17x17mm.RLImage5.Picture.Bitmap := QRCodeBitmap;
frm_17x17mm.RLImage6.Picture.Bitmap := QRCodeBitmap;

// Redimencionando o QRCODE no quadrado do formulario de impressão
frm_17x17mm.RLImage1.Stretch := True;
frm_17x17mm.RLImage2.Stretch := True;
frm_17x17mm.RLImage3.Stretch := True;
frm_17x17mm.RLImage4.Stretch := True;
frm_17x17mm.RLImage5.Stretch := True;
frm_17x17mm.RLImage6.Stretch := True;

//chama o preview para o dialogo com a impressora e ordem de impressão
frm_17x17mm.etq_17x17.Preview();

//fecha o form invocado para o preenchimento do relatório
frm_17x17mm.Close;

end;

//------------------------------------------------------------------------------

procedure Tfrm_impressao_QR.btn_encodeClick(Sender: TObject);

var
    QRCODE: TDelphiZXingQRCode;
    Row, Column: Integer;

begin

//valida para ver se existe uma string para ser codigicada em QRCODE
  if edt_data.Text = '' then
  begin
    Beep;
    ShowMessage('O QRCODE não pode ser gerado sem informação válida');
    edt_data.SetFocus;
    Exit;
  end;

QRCODE := TDelphiZXingQRCode.Create; //cria objeto QRCODE

try

QRCODE.Data := edt_data.Text; //conteudo do QR em string alpha numerica
QRCODE.Encoding := TQRCodeEncoding(ComboBox_encoding.ItemIndex);//seta Codif.
QRCODE.QuietZone := StrToIntDef(edt_quietzone.Text,0);//seta QZ default val 0
QRCodeBitmap.SetSize(QRCODE.Rows, QRCODE.Columns);


for Row := 0 to QRCODE.Rows -1  do
  begin
  for Column := 0 to QRCODE.Columns -1 do
    begin
      if (QRCODE.IsBlack[Row,Column]) then
        begin
      QRCodeBitmap.Canvas.Pixels[Column,Row] := clBlack;
    end else
        begin
      QRCodeBitmap.Canvas.Pixels[Column,Row] := clWhite;
    end;
  end;
end;

finally

QRCODE.Free;

end;

PaintBox_preview.Repaint;

end;
//------------------------------------------------------------------------------

procedure Tfrm_impressao_QR.edt_dataChange(Sender: TObject);
begin

//exibe graficamente a quantidade de caracteres no edit data
lbl_count.Caption := IntToStr(edt_data.GetTextLen);

end;

//------------------------------------------------------------------------------

procedure Tfrm_impressao_QR.edt_dataEnter(Sender: TObject);
begin

//muda conforme o valor do radio button quando entramos no edit

  if RadioGroup1.ItemIndex = 0 then
  begin
  edt_data.MaxLength := 50;
  end;

  if RadioGroup1.ItemIndex = 1 then
  begin
  edt_data.MaxLength := 100;
  end;

end;

//------------------------------------------------------------------------------

procedure Tfrm_impressao_QR.FormCreate(Sender: TObject);
begin

QRCodeBitmap := TBitmap.Create; //Cria o objeto para receber o QR codificado


//apenas inicializa os dados visuais
if RadioGroup1.ItemIndex = 0 then
  begin
  lbl_count.Caption := '0';
  end;

  if RadioGroup1.ItemIndex = 1 then
  begin
  lbl_count.Caption := '0';
  end;

end;

//------------------------------------------------------------------------------

procedure Tfrm_impressao_QR.FormDestroy(Sender: TObject);
begin

QRCodeBitmap.Free; //Libera o objeto do QR codificado da memoria quando saimos
                  //do sistema. O objeto é destruido.

end;

//------------------------------------------------------------------------------

procedure Tfrm_impressao_QR.PaintBox_previewPaint(Sender: TObject);

var
  Scale: Double;

begin  // Ajusta o dimencionamento do QR quando a area de preview for preenchida

PaintBox_preview.Canvas.Brush.Color := clWhite; //define o fundo de branco
PaintBox_preview.Canvas.FillRect(Rect(0,0,PaintBox_preview.Width, PaintBox_preview.Height));
  if ((QRCodeBitmap.Width > 0) and (QRCodeBitmap.Height > 0)) then
  begin
    if (PaintBox_preview.Width < PaintBox_preview.Height) then
    begin
      Scale := PaintBox_preview.Width / QRCodeBitmap.Width;
     end else
    begin
      Scale := PaintBox_preview.Height / QRCodeBitmap.Height;
    end;
    PaintBox_preview.Canvas.StretchDraw(Rect(0,0, Trunc(Scale * QRCodeBitmap.Width),Trunc(Scale * QRCodeBitmap.Height)), QRCodeBitmap);
  end;
end;

//------------------------------------------------------------------------------

procedure Tfrm_impressao_QR.RadioGroup1Click(Sender: TObject);
begin

//limpa o edit data e o foca para nova digitação
edt_data.Text := '';
edt_data.SetFocus;

end;

//------------------------------------------------------------------------------

end.
