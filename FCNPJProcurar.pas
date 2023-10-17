{ -----------------------------------------+
  |  SISTEMA.........: BUSCA CNPJ           |
  |  LINGUAGEM/DB....: Delphi               |
  |  ANO.............: 2023                 |
  |-----------------------------------------|
  |  Programadores/autores:                 |
  |  - Claudio A. Colares                   |
  +-----------------------------------------}
unit FCNPJProcurar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.StrUtils, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Mask, Vcl.Buttons,
  ACBrBase, ACBrUtil, ACBrSocket, ACBrConsultaCNPJ, ACBrValidador,CNPJInfo,RecordCliente, frxCtrls;

{$IFDEF CONDITIONALEXPRESSIONS}
   {$IF CompilerVersion >= 20.0}
     {$DEFINE DELPHI2009_UP}
   {$IFEND}
{$ENDIF}

{.$DEFINE SUPPORT_PNG}  // Remova o Ponto, se seu Delphi suporta PNG

{$IFDEF DELPHI2009_UP}
  {$DEFINE SUPPORT_PNG}
{$ENDIF}

type
  TFrmCNPJProcurar = class(TForm)
    Panel2: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    EditTipo: TEdit;
    EditRazaoSocial: TEdit;
    EditAbertura: TEdit;
    EditEndereco: TEdit;
    EditNumero: TEdit;
    EditComplemento: TEdit;
    EditBairro: TEdit;
    EditCidade: TEdit;
    EditUF: TEdit;
    EditCEP: TEdit;
    Panel1: TPanel;
    Label1: TLabel;
    ButBuscar: TBitBtn;
    Label14: TLabel;
    EditFantasia: TEdit;
    Label13: TLabel;
    EditCNPJ: TMaskEdit;
    ListCNAE2: TListBox;
    Label15: TLabel;
    EditCNAE1: TEdit;
    Label16: TLabel;
    EditEmail: TEdit;
    Label17: TLabel;
    EditTelefone: TEdit;
    Label18: TLabel;
    Panel4: TPanel;
    btnOk: TButton;
    btnSair: TButton;
    EditInscEstadual: TEdit;
    lblInscEstadual: TLabel;
    EditIDUF: TEdit;
    lblIDUF: TLabel;
    Label12: TLabel;
    EditSituacao: TEdit;
    Label19: TLabel;
    EditIDCidade: TEdit;
    grpServidor: TGroupBox;
    cbbServidor: TComboBox;
    procedure ButBuscarClick(Sender: TObject);
    procedure EditCaptchaKeyPress(Sender: TObject; var Key: Char);
    procedure btnOkClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure Limparformulario;
  public
    { Public declarations }
    FCliente : TCliente;

  end;

var
  FrmCNPJProcurar: TFrmCNPJProcurar;
  ConsultarCadastro : TCNPJInfo;

implementation

uses
  JPEG
{$IFDEF SUPPORT_PNG}
  , pngimage
{$ENDIF}
  , App.Constantes, App.Funcoes;

{$R *.dfm}

procedure TFrmCNPJProcurar.btnOkClick(Sender: TObject);
var
  mCNPJ : String;
  mFone : String;
begin
  mCNPJ := OnlyNumber(Trim(EditCNPJ.Text));
  if ValidarDocumento(mCNPJ, docCNPJ) = False then
  begin
    Atencao(_LABEL_RECEITAFEDERAL_CNPJ, 'CNPJ não é válido');
    Exit;
  end;

  if (Trim(EditRazaoSocial.Text) = '') then
  begin
    Atencao(_LABEL_RECEITAFEDERAL_CNPJ, 'Campo Razão Social está vazio');
    Exit;
  end;

  if (Trim(EditRazaoSocial.Text) = '') then
  begin
    Atencao(_LABEL_RECEITAFEDERAL_CNPJ, 'Campo Razão Social está vazio');
    Exit;
  end;

  if (Trim(EditCidade.Text) = '')  then
  begin
    Atencao(_LABEL_RECEITAFEDERAL_CNPJ, 'Campo Cidade está vazio');
    Exit;
  end;

  mFone                 := OnlyNumber(EditTelefone.Text);
  FCliente.Limpar();
  FCliente.TipoEmpresa  := EditTipo.Text;
  FCliente.IE           := EditInscEstadual.Text;
  FCliente.xNome        := EditRazaoSocial.Text;
  FCliente.Fantasia     := EditFantasia.Text;
  FCliente.DTAbertura   := StrToDateDef(EditAbertura.Text, 0);
  FCliente.xLgr         := EditEndereco.Text;
  FCliente.nro          := EditNumero.Text;
  FCliente.xCpl         := ReplaceStr(Trim(EditComplemento.Text), '*', '');
  FCliente.xBairro      := ReplaceStr(Trim(EditBairro.Text), '*', '');
  FCliente.cMun         := StrToIntDef(EditIDCidade.Text,0);
  FCliente.xMun         := EditCidade.Text;
  FCliente.cUF          := StrToIntDef(EditIDUF.Text, 0);
  FCliente.UF           := EditUF.Text;
  FCliente.CEP          := FormatarCEP(EditCEP.Text);
  FCliente.Situacao     := EditSituacao.Text;
  FCliente.CNAE         := OnlyNumber(EditCNAE1.Text);
  FCliente.email        := LowerCase(EditEmail.Text);
  FCliente.DDD          := Copy(mFone, 1, _TAMANHO_DDD);
  FCliente.fone         := FormatarFone(AnsiRightStr(mFone, (Length(mFone) - _TAMANHO_DDD) ));



  ModalResult := mrOk;
end;

procedure TFrmCNPJProcurar.btnSairClick(Sender: TObject);
begin
  FCliente.Limpar();
  ModalResult := mrCancel;
end;

procedure TFrmCNPJProcurar.ButBuscarClick(Sender: TObject);
var
  I: Integer;
  mOk : Boolean;
  mErro : String;
begin
    Limparformulario;
    ConsultarCadastro := TCNPJInfo.Create;

    MsgEsperar(_LABEL_CADASTRO_CLIENTE, 'Procurando CNPJ na Receita Federal. Por favor, aguarde...', True);
    try
      mOk := False;
      try
         ConsultarCadastro.Consultar(EditCNPJ.Text, cbbServidor.Text);
         mOk := ConsultarCadastro.Achou;
      except
        on E: Exception do
        begin
          MsgEsperar('', '', False);
          mErro := E.Message;
        end;
      end;

      EditInscEstadual.Text := ConsultarCadastro.InscEstadual;
      EditRazaoSocial.Text := ConsultarCadastro.RazaoSocial;
      EditAbertura.Text    := ConsultarCadastro.DataAbertura;
      EditTipo.Text        := ConsultarCadastro.EmpresaTipo;
      EditFantasia.Text    := ConsultarCadastro.NomeFantasia;
      EditEndereco.Text    := ConsultarCadastro.Endereco;
      EditNumero.Text      := ConsultarCadastro.Numero;
      EditComplemento.Text := ReplaceStr(Trim(ConsultarCadastro.Complemento), '*', '');
      EditBairro.Text      := ReplaceStr(Trim(ConsultarCadastro.Bairro), '*', '');
      EditComplemento.Text := ReplaceStr(Trim(ConsultarCadastro.Complemento), '*', '');
      EditCidade.Text      := ConsultarCadastro.Cidade;
      EditUF.Text          := ConsultarCadastro.UF;
      EditCEP.Text         := ConsultarCadastro.CEP;
      EditSituacao.Text    := ConsultarCadastro.Situacao;
      EditCNAE1.Text       := ConsultarCadastro.CNAE;
      ListCNAE2.Items      := ConsultarCadastro.AtividadesSecundarias;
      EditEmail.Text       := LowerCase(ConsultarCadastro.Email);
      EditTelefone.Text    := ConsultarCadastro.Telefone;
      EditIDCidade.Text    := ConsultarCadastro.IDCIDADE;
      EditIDUF.Text        := ConsultarCadastro.IDUF;

    finally
      MsgEsperar('', '', False);
      ConsultarCadastro.Free;
    end;

end;

procedure TFrmCNPJProcurar.EditCaptchaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    ButBuscarClick(ButBuscar);
end;

procedure TFrmCNPJProcurar.FormCreate(Sender: TObject);
begin
  FCliente.Limpar();
end;

procedure TFrmCNPJProcurar.LimparFormulario;
begin
      EditRazaoSocial.Text := '';
      EditRazaoSocial.Text := '';
      EditAbertura.Text    := '';
      EditTipo.Text        := '';
      EditFantasia.Text    := '';
      EditEndereco.Text    := '';
      EditNumero.Text      := '';
      EditComplemento.Text := '';
      EditBairro.Text      := '';
      EditComplemento.Text := '';
      EditCidade.Text      := '';
      EditUF.Text          := '';
      EditCEP.Text         := '';
      EditSituacao.Text    := '';
      EditCNAE1.Text       := '';
      EditEmail.Text       := '';
      EditTelefone.Text    := '';
end;

end.
