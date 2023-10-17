{ -----------------------------------------+
  |  SISTEMA.........: BUSCA CNPJ           |
  |  LINGUAGEM/DB....: Delphi               |
  |  ANO.............: 2023                 |
  |-----------------------------------------|
  |  Programadores/autores:                 |
  |  - Claudio A. Colares                   |
  +-----------------------------------------}
unit CNPJInfo;

interface

uses
  System.SysUtils, System.Net.HttpClient, System.JSON, System.Classes, System.Generics.Collections, ACBrUtil,
   Vcl.Dialogs,PublicaCnpjWS,Receitaws,BrasilApiWS;

type
  TCNPJInfo = class
  private
    FAchou                  : Boolean;
    FRazaoSocial            : string;
    FPorte                  : string;
    FInscEstadual           : string;
    FNomeFantasia           : string;
    FEmpresaTipo            : string;
    FNaturezaJuridica       : string;
    FCNAE                   : string;
    FDataAbertura           : string;
    FSituacao               : String;
    FEmail                  : string;
    FTelefone               : string;
    FComplemento            : string;
    FEndereco               : string;
    FNumero                 : string;
    FBairro                 : string;
    FCidade                 : string;
    FUF                     : string;
    FIDUF                   : String;
    FIDCidade               : string;
    FCep                    : string;
    FAtividadePrincipal     : TStringList;
    FEstabelecimentoArray   : TStringList;
    FAtividadesSecundarias  : TStringList;
    FQuadroSocios           : TStringList;
  public
    constructor Create;

    procedure Consultar(const CNPJ: string;servidor:String);
    property RazaoSocial            : string read FRazaoSocial;
    property NomeFantasia           : string read FNomeFantasia;
    property Porte                  : string read FPorte;
    property InscEstadual           : string read FInscEstadual;
    property EmpresaTipo            : string read FEmpresaTipo;
    property NaturezaJuridica       : string read FNaturezaJuridica;
    property CNAE                   : string read FCNAE;
    property DataAbertura           : string read FDataAbertura;
    property Email                  : string read FEmail;
    property Situacao               : string read FSituacao;
    property Complemento            : string read FComplemento;
    property Telefone               : string read FTelefone;
    property Achou                  : Boolean read FAchou;
    property Endereco               : string read FEndereco;
    property Numero                 : string read FNumero;
    property Bairro                 : string read FBairro;
    property Cidade                 : string read FCidade;
    property UF                     : string read FUF;
    property IDUF                   : string read FIDUF;
    property IDCIDADE               : string read FIDCidade;
    property Cep                    : string read FCep;
    property AtividadePrincipal     : TStringList read FAtividadePrincipal;
    property AtividadesSecundarias  : TStringList read FAtividadesSecundarias;
    property QuadroSocios           : TStringList read FQuadroSocios;
  end;

implementation

uses
  App.Funcoes;

constructor TCNPJInfo.Create;
begin
  FPorte            := '';
  FInscEstadual     := '';
  FRazaoSocial      := '';
  FNomeFantasia     := '';
  FEmpresaTipo      := '';
  FNaturezaJuridica := '';
  FCNAE             := '';
  FDataAbertura     := '';
  FEmail            := '';
  FSituacao         := '';
  FComplemento      := '';
  FTelefone         := '';
  FEndereco         := '';
  FAchou            := False;
  FNumero           := '';
  FBairro           := '';
  FCidade           := '';
  FUF               := '';
  FIDUF             := '';
  FIDCidade         := '';
  FCep              := '';
  FAtividadePrincipal     := TStringList.Create;
  FAtividadesSecundarias  := TStringList.Create;
end;

procedure TCNPJInfo.Consultar(const CNPJ: string; servidor:string);
var
  HttpClient          : THTTPClient;
  ResponseContent     : string;
  PublicaCnpjWS       : TPublicaCnpjWS;
  ReceitaCnpjWS       : TReceitaws;
  BrasilApiWS         : TBrasilApiWS;
  AtividadePrincipal  : TAtividadePrincipal;
  AtividadeSecundaria : TAtividadesSecundarias;
  i,j                 : Integer;
begin
  FAchou := False;

  HttpClient              := THTTPClient.Create;


  try
    try
      // SERVIDOR 01 -------------------------------------------------------------------------------------------------
      if servidor = 'https://publica.cnpj.ws/cnpj/' then
      begin
        ResponseContent      := HttpClient.Get(servidor + OnlyNumber(CNPJ)).ContentAsString(TEncoding.UTF8);

        PublicaCnpjWS        := TPublicaCnpjWS.Create;
        PublicaCnpjWS.AsJson := TJSONObject.ParseJSONValue(ResponseContent).ToJSON;

        FRazaoSocial         := PublicaCnpjWS.RazaoSocial;
        FNomeFantasia        := PublicaCnpjWS.Estabelecimento.NomeFantasia;
        FEmpresaTipo         := PublicaCnpjWS.Estabelecimento.Tipo;
        FSituacao            := PublicaCnpjWS.Estabelecimento.SituacaoCadastral;
        FTelefone            := PublicaCnpjWS.Estabelecimento.Ddd1 + ' ' + PublicaCnpjWS.Estabelecimento.Telefone1;
        FEndereco            := PublicaCnpjWS.Estabelecimento.TipoLogradouro + ' ' + PublicaCnpjWS.Estabelecimento.Logradouro;
        FNumero              := PublicaCnpjWS.Estabelecimento.Numero;
        FComplemento         := PublicaCnpjWS.Estabelecimento.Complemento;
        FBairro              := PublicaCnpjWS.Estabelecimento.Bairro;
        FIDUF                := PublicaCnpjWS.Estabelecimento.Estado.IbgeId.ToString;
        FIDCidade            := PublicaCnpjWS.Estabelecimento.Cidade.IbgeId.ToString;
        FCep                 := PublicaCnpjWS.Estabelecimento.Cep;
        FCidade              := PublicaCnpjWS.Estabelecimento.Cidade.Nome;
        FUF                  := PublicaCnpjWS.Estabelecimento.Estado.Sigla;
        FEmail               := PublicaCnpjWS.Estabelecimento.Email;
        FDataAbertura        := DateToStr(PublicaCnpjWS.Estabelecimento.DataInicioAtividade);
        FCNAE                := PublicaCnpjWS.Estabelecimento.AtividadePrincipal.Descricao;

        for i := 0 to PublicaCnpjWS.Estabelecimento.InscricoesEstaduais.Count -1 do
        begin
          FInscEstadual := PublicaCnpjWS.Estabelecimento.InscricoesEstaduais[i].InscricaoEstadual;
        end;

        for j := 0 to PublicaCnpjWS.Estabelecimento.AtividadesSecundarias.Count -1 do
        begin
          FAtividadesSecundarias.Add(PublicaCnpjWS.Estabelecimento.AtividadesSecundarias[j].Id
          + ' - ' + PublicaCnpjWS.Estabelecimento.AtividadesSecundarias[j].Descricao);
        end;

      end;

      // SERVIDOR 02 -------------------------------------------------------------------------------------------------
      if servidor = 'https://www.receitaws.com.br/v1/cnpj/' then
      begin
        ResponseContent := HttpClient.Get(servidor + OnlyNumber(CNPJ)).ContentAsString(TEncoding.UTF8);

        ReceitaCnpjWS        := TReceitaws.Create;
        ReceitaCnpjWS.AsJson := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(ResponseContent),0).ToJSON;

        FRazaoSocial  := ReceitaCnpjWS.Nome;
        FNomeFantasia := ReceitaCnpjWS.Fantasia;
        FEmpresaTipo  := ReceitaCnpjWS.Tipo;
        FSituacao     := ReceitaCnpjWS.Situacao;
        FTelefone     := ReceitaCnpjWS.Telefone;
        FEndereco     := ReceitaCnpjWS.Logradouro;
        FNumero       := ReceitaCnpjWS.Numero;
        FBairro       := ReceitaCnpjWS.Bairro;
        FComplemento  := ReceitaCnpjWS.Complemento;
        FCep          := ReceitaCnpjWS.Cep;
        FCidade       := ReceitaCnpjWS.Municipio;
        FUF           := ReceitaCnpjWS.Uf;
        FEmail        := ReceitaCnpjWS.Email;
        FDataAbertura := ReceitaCnpjWS.DataSituacao;


        for i := 0 to ReceitaCnpjWS.AtividadePrincipal.Count -1 do
        begin
         FCNAE := ReceitaCnpjWS.AtividadePrincipal[i].Code
          + ' - ' + ReceitaCnpjWS.AtividadePrincipal[i].Text;
        end;

        for j := 0 to ReceitaCnpjWS.AtividadesSecundarias.Count -1 do
        begin
          FAtividadesSecundarias.Add(ReceitaCnpjWS.AtividadesSecundarias[j].Code
          + ' - ' + ReceitaCnpjWS.AtividadesSecundarias[j].Text);
        end;
      end;


      // SERVIDOR 03 -------------------------------------------------------------------------------------------------
      if servidor = 'https://brasilapi.com.br/api/cnpj/v1/' then
      begin
        ResponseContent := HttpClient.Get(servidor + OnlyNumber(CNPJ)).ContentAsString(TEncoding.UTF8);

        BrasilApiWS        := TBrasilApiWS.Create;
        BrasilApiWS.AsJson := TJSONObject.ParseJSONValue(ResponseContent).ToJSON;

        FRazaoSocial  := BrasilApiWS.RazaoSocial   ;
        FNomeFantasia := BrasilApiWS.NomeFantasia;
        FEmpresaTipo  := BrasilApiWS.DescricaoIdentificadorMatrizFilial;
        FSituacao     := BrasilApiWS.DescricaoSituacaoCadastral;
        FTelefone     := BrasilApiWS.DddTelefone1;
        FEndereco     := BrasilApiWS.Logradouro;
        FNumero       := BrasilApiWS.Numero;
        FBairro       := BrasilApiWS.Bairro;
        FComplemento  := BrasilApiWS.Complemento;
        FCep          := BrasilApiWS.Cep;
        FCidade       := BrasilApiWS.Municipio;
        FUF           := BrasilApiWS.Uf;
        FEmail        := '';
        FDataAbertura := DateToStr(BrasilApiWS.DataInicioAtividade);
        FCNAE         := BrasilApiWS.CnaeFiscal.ToString + ' - ' + BrasilApiWS.CnaeFiscalDescricao;


        for j := 0 to BrasilApiWS.CnaesSecundarios.Count -1 do
        begin
          FAtividadesSecundarias.Add(BrasilApiWS.CnaesSecundarios[j].Codigo.ToString
          + ' - ' + BrasilApiWS.CnaesSecundarios[j].Descricao);
        end;
      end;

    except
      on E: Exception do
      begin
        ShowMessage(E.Message);
        FAtividadePrincipal.Clear;    // Limpa a lista em caso de erro.
        FAtividadesSecundarias.Clear; // Limpa a lista em caso de erro.
      end;
    end;
  finally
    HttpClient.Free;
  end;
end;

// ...
end.

