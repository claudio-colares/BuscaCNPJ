{ -----------------------------------------+
  |  SISTEMA.........: BUSCA CNPJ           |
  |  LINGUAGEM/DB....: Delphi               |
  |  ANO.............: 2023                 |
  |-----------------------------------------|
  |  Programadores/autores:                 |
  |  - Claudio A. Colares                   |
  +-----------------------------------------}
unit Receitaws;

interface

uses
  Pkg.JsonReceitaWS, System.Generics.Collections, REST.Json.Types;

{$M+}

type
  TBilling = class
  private
    FDatabase: Boolean;
    FFree: Boolean;
  published
    property Database: Boolean read FDatabase write FDatabase;
    property Free: Boolean read FFree write FFree;
  end;
  
  TExtra = class
  end;
  
  TQsa = class
  end;
  
  TAtividadesSecundarias = class
  private
    FCode: string;
    FText: string;
  published
    property Code: string read FCode write FCode;
    property Text: string read FText write FText;
  end;
  
  TAtividadePrincipal = class
  private
    FCode: string;
    FText: string;
  published
    property Code: string read FCode write FCode;
    property Text: string read FText write FText;
  end;
  
  TReceitaws = class(TJsonDTO)
  private
    FAbertura: string;
    [JSONName('atividade_principal'), JSONMarshalled(False)]
    FAtividadePrincipalArray: TArray<TAtividadePrincipal>;
    [GenericListReflect]
    FAtividadePrincipal: TObjectList<TAtividadePrincipal>;
    [JSONName('atividades_secundarias'), JSONMarshalled(False)]
    FAtividadesSecundariasArray: TArray<TAtividadesSecundarias>;
    [GenericListReflect]
    FAtividadesSecundarias: TObjectList<TAtividadesSecundarias>;
    FBairro: string;
    FBilling: TBilling;
    [JSONName('capital_social')]
    FCapitalSocial: string;
    FCep: string;
    FCnpj: string;
    FComplemento: string;
    [JSONName('data_situacao')]
    FDataSituacao: string;
    [JSONName('data_situacao_especial')]
    FDataSituacaoEspecial: string;
    FEfr: string;
    FEmail: string;
    FExtra: TExtra;
    FFantasia: string;
    FLogradouro: string;
    [JSONName('motivo_situacao')]
    FMotivoSituacao: string;
    FMunicipio: string;
    [JSONName('natureza_juridica')]
    FNaturezaJuridica: string;
    FNome: string;
    FNumero: string;
    FPorte: string;
    [JSONName('qsa'), JSONMarshalled(False)]
    FQsaArray: TArray<TQsa>;
    [GenericListReflect]
    FQsa: TObjectList<TQsa>;
    FSituacao: string;
    [JSONName('situacao_especial')]
    FSituacaoEspecial: string;
    FStatus: string;
    FTelefone: string;
    FTipo: string;
    FUf: string;
    [SuppressZero, JSONName('ultima_atualizacao')]
    FUltimaAtualizacao: TDateTime;
    function GetAtividadePrincipal: TObjectList<TAtividadePrincipal>;
    function GetAtividadesSecundarias: TObjectList<TAtividadesSecundarias>;
    function GetQsa: TObjectList<TQsa>;
  protected
    function GetAsJson: string; override;
  published
    property Abertura: string read FAbertura write FAbertura;
    property AtividadePrincipal: TObjectList<TAtividadePrincipal> read GetAtividadePrincipal;
    property AtividadesSecundarias: TObjectList<TAtividadesSecundarias> read GetAtividadesSecundarias;
    property Bairro: string read FBairro write FBairro;
    property Billing: TBilling read FBilling;
    property CapitalSocial: string read FCapitalSocial write FCapitalSocial;
    property Cep: string read FCep write FCep;
    property Cnpj: string read FCnpj write FCnpj;
    property Complemento: string read FComplemento write FComplemento;
    property DataSituacao: string read FDataSituacao write FDataSituacao;
    property DataSituacaoEspecial: string read FDataSituacaoEspecial write FDataSituacaoEspecial;
    property Efr: string read FEfr write FEfr;
    property Email: string read FEmail write FEmail;
    property Extra: TExtra read FExtra;
    property Fantasia: string read FFantasia write FFantasia;
    property Logradouro: string read FLogradouro write FLogradouro;
    property MotivoSituacao: string read FMotivoSituacao write FMotivoSituacao;
    property Municipio: string read FMunicipio write FMunicipio;
    property NaturezaJuridica: string read FNaturezaJuridica write FNaturezaJuridica;
    property Nome: string read FNome write FNome;
    property Numero: string read FNumero write FNumero;
    property Porte: string read FPorte write FPorte;
    property Qsa: TObjectList<TQsa> read GetQsa;
    property Situacao: string read FSituacao write FSituacao;
    property SituacaoEspecial: string read FSituacaoEspecial write FSituacaoEspecial;
    property Status: string read FStatus write FStatus;
    property Telefone: string read FTelefone write FTelefone;
    property Tipo: string read FTipo write FTipo;
    property Uf: string read FUf write FUf;
    property UltimaAtualizacao: TDateTime read FUltimaAtualizacao write FUltimaAtualizacao;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;
  
implementation

{ TRoot }

constructor TReceitaws.Create;
begin
  inherited;
  FExtra := TExtra.Create;
  FBilling := TBilling.Create;
end;

destructor TReceitaws.Destroy;
begin
  FExtra.Free;
 // FBilling.Free;
  GetAtividadePrincipal.Free;
  GetAtividadesSecundarias.Free;
  GetQsa.Free;
  inherited;
end;

function TReceitaws.GetAtividadePrincipal: TObjectList<TAtividadePrincipal>;
begin
  Result := ObjectList<TAtividadePrincipal>(FAtividadePrincipal, FAtividadePrincipalArray);
end;

function TReceitaws.GetAtividadesSecundarias: TObjectList<TAtividadesSecundarias>;
begin
  Result := ObjectList<TAtividadesSecundarias>(FAtividadesSecundarias, FAtividadesSecundariasArray);
end;

function TReceitaws.GetQsa: TObjectList<TQsa>;
begin
  Result := ObjectList<TQsa>(FQsa, FQsaArray);
end;

function TReceitaws.GetAsJson: string;
begin
  RefreshArray<TAtividadePrincipal>(FAtividadePrincipal, FAtividadePrincipalArray);
  RefreshArray<TAtividadesSecundarias>(FAtividadesSecundarias, FAtividadesSecundariasArray);
  RefreshArray<TQsa>(FQsa, FQsaArray);
  Result := inherited;
end;

end.
