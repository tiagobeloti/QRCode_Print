unit frm_etiqueta_17x17mm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport;

type
  Tfrm_17x17mm = class(TForm)
    etq_17x17: TRLReport;
    RLImage1: TRLImage;
    RLImage2: TRLImage;
    RLImage3: TRLImage;
    RLImage4: TRLImage;
    RLImage5: TRLImage;
    RLImage6: TRLImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_17x17mm: Tfrm_17x17mm;

implementation

Uses
    impressao_QR; //formulario principal, ve os objetos nele

{$R *.dfm}

end.
