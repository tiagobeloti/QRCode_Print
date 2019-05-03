program Impressao_QRCODE;

uses
  Vcl.Forms,
  impressao_QR in 'impressao_QR.pas' {frm_impressao_QR},
  frm_etiqueta_17x17mm in 'frm_etiqueta_17x17mm.pas' {frm_17x17mm},
  U_frm_etiqueta_40x40mm in 'U_frm_etiqueta_40x40mm.pas' {frm_etiqueta_40x40mm},
  U_frm_etiqueta_27x25mm in 'U_frm_etiqueta_27x25mm.pas' {frm_etiqueta_27x25mm},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows10 Green');
  Application.CreateForm(Tfrm_impressao_QR, frm_impressao_QR);
  Application.CreateForm(Tfrm_17x17mm, frm_17x17mm);
  Application.CreateForm(Tfrm_etiqueta_40x40mm, frm_etiqueta_40x40mm);
  Application.CreateForm(Tfrm_etiqueta_27x25mm, frm_etiqueta_27x25mm);
  Application.Run;
end.
