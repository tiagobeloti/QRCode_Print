unit U_frm_etiqueta_40x40mm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport;

type
  Tfrm_etiqueta_40x40mm = class(TForm)
    etq_40x40mm: TRLReport;
    RLImage1: TRLImage;
    RLImage2: TRLImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_etiqueta_40x40mm: Tfrm_etiqueta_40x40mm;

implementation

Uses
    impressao_QR; //formulario principal, ve os objetos nele

{$R *.dfm}

end.
