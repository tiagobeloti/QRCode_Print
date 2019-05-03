unit U_frm_etiqueta_27x25mm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport;

type
  Tfrm_etiqueta_27x25mm = class(TForm)
    etq_27x25mm: TRLReport;
    RLImage1: TRLImage;
    RLImage2: TRLImage;
    RLImage3: TRLImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_etiqueta_27x25mm: Tfrm_etiqueta_27x25mm;

implementation

Uses
    impressao_QR; //classe mae

{$R *.dfm}

end.
