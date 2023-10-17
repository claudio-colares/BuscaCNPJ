{ -----------------------------------------+
  |  SISTEMA.........: BUSCA CNPJ           |
  |  LINGUAGEM/DB....: Delphi               |
  |  ANO.............: 2023                 |
  |-----------------------------------------|
  |  Programadores/autores:                 |
  |  - Claudio A. Colares                   |
  +-----------------------------------------}
unit BrasilApiWS;

interface

uses
  Pkg.Json.DTO, System.Generics.Collections, REST.Json.Types;

{$M+}

type
  TCnaesSecundarios = class
  private
    FCodigo: Integer;
    FDescricao: string;
  published
    property Codigo: Integer read FCodigo write FCodigo;
    property Descricao: string read FDescricao write FDescricao;
  end;
  
  TQsa = class
  end;
  
  TBrasilApiWS = class(TJsonDTO)
  private
    FBairro: string;
    [JSONName('capital_social')]
    FCapitalSocial: Integer;
    FCep: string;
    [JSONName('cnae_fiscal')]
    FCnaeFiscal: Integer;
    [JSONName('cnae_fiscal_descricao')]
    FCnaeFiscalDescricao: string;
    [JSONName('cnaes_secundarios'), JSONMarshalled(False)]
    FCnaesSecundariosArray: TArray<TCnaesSecundarios>;
    [GenericListReflect]
    FCnaesSecundarios: TObjectList<TCnaesSecundarios>;
    FCnpj: string;
    [JSONName('codigo_municipio')]
    FCodigoMunicipio: Integer;
    [JSONName('codigo_municipio_ibge')]
    FCodigoMunicipioIbge: Integer;
    [JSONName('codigo_natureza_juridica')]
    FCodigoNaturezaJuridica: Integer;
    [JSONName('codigo_porte')]
    FCodigoPorte: Integer;
    FComplemento: string;
    [SuppressZero, JSONName('data_inicio_atividade')]
    FDataInicioAtividade: TDateTime;
    [SuppressZero, JSONName('data_opcao_pelo_mei')]
    FDataOpcaoPeloMei: TDateTime;
    [SuppressZero, JSONName('data_opcao_pelo_simples')]
    FDataOpcaoPeloSimples: TDateTime;
    [SuppressZero, JSONName('data_situacao_cadastral')]
    FDataSituacaoCadastral: TDateTime;
    [JSONName('ddd_fax')]
    FDddFax: string;
    [JSONName('ddd_telefone_1')]
    FDddTelefone1: string;
    [JSONName('ddd_telefone_2')]
    FDddTelefone2: string;
    [JSONName('descricao_identificador_matriz_filial')]
    FDescricaoIdentificadorMatrizFilial: string;
    [JSONName('descricao_motivo_situacao_cadastral')]
    FDescricaoMotivoSituacaoCadastral: string;
    [JSONName('descricao_porte')]
    FDescricaoPorte: string;
    [JSONName('descricao_situacao_cadastral')]
    FDescricaoSituacaoCadastral: string;
    [JSONName('descricao_tipo_de_logradouro')]
    FDescricaoTipoDeLogradouro: string;
    [JSONName('ente_federativo_responsavel')]
    FEnteFederativoResponsavel: string;
    [JSONName('identificador_matriz_filial')]
    FIdentificadorMatrizFilial: Integer;
    FLogradouro: string;
    [JSONName('motivo_situacao_cadastral')]
    FMotivoSituacaoCadastral: Integer;
    FMunicipio: string;
    [JSONName('natureza_juridica')]
    FNaturezaJuridica: string;
    [JSONName('nome_cidade_no_exterior')]
    FNomeCidadeNoExterior: string;
    [JSONName('nome_fantasia')]
    FNomeFantasia: string;
    FNumero: string;
    [JSONName('opcao_pelo_mei')]
    FOpcaoPeloMei: Boolean;
    [JSONName('opcao_pelo_simples')]
    FOpcaoPeloSimples: Boolean;
    FPorte: string;
    [JSONName('qsa'), JSONMarshalled(False)]
    FQsaArray: TArray<TQsa>;
    [GenericListReflect]
    FQsa: TObjectList<TQsa>;
    [JSONName('qualificacao_do_responsavel')]
    FQualificacaoDoResponsavel: Integer;
    [JSONName('razao_social')]
    FRazaoSocial: string;
    [JSONName('situacao_cadastral')]
    FSituacaoCadastral: Integer;
    [JSONName('situacao_especial')]
    FSituacaoEspecial: string;
    FUf: string;
    function GetCnaesSecundarios: TObjectList<TCnaesSecundarios>;
    function GetQsa: TObjectList<TQsa>;
  protected
    function GetAsJson: string; override;
  published
    property Bairro: string read FBairro write FBairro;
    property CapitalSocial: Integer read FCapitalSocial write FCapitalSocial;
    property Cep: string read FCep write FCep;
    property CnaeFiscal: Integer read FCnaeFiscal write FCnaeFiscal;
    property CnaeFiscalDescricao: string read FCnaeFiscalDescricao write FCnaeFiscalDescricao;
    property CnaesSecundarios: TObjectList<TCnaesSecundarios> read GetCnaesSecundarios;
    property Cnpj: string read FCnpj write FCnpj;
    property CodigoMunicipio: Integer read FCodigoMunicipio write FCodigoMunicipio;
    property CodigoMunicipioIbge: Integer read FCodigoMunicipioIbge write FCodigoMunicipioIbge;
    property CodigoNaturezaJuridica: Integer read FCodigoNaturezaJuridica write FCodigoNaturezaJuridica;
    property CodigoPorte: Integer read FCodigoPorte write FCodigoPorte;
    property Complemento: string read FComplemento write FComplemento;
    property DataInicioAtividade: TDateTime read FDataInicioAtividade write FDataInicioAtividade;
    property DataOpcaoPeloMei: TDateTime read FDataOpcaoPeloMei write FDataOpcaoPeloMei;
    property DataOpcaoPeloSimples: TDateTime read FDataOpcaoPeloSimples write FDataOpcaoPeloSimples;
    property DataSituacaoCadastral: TDateTime read FDataSituacaoCadastral write FDataSituacaoCadastral;
    property DddFax: string read FDddFax write FDddFax;
    property DddTelefone1: string read FDddTelefone1 write FDddTelefone1;
    property DddTelefone2: string read FDddTelefone2 write FDddTelefone2;
    property DescricaoIdentificadorMatrizFilial: string read FDescricaoIdentificadorMatrizFilial write FDescricaoIdentificadorMatrizFilial;
    property DescricaoMotivoSituacaoCadastral: string read FDescricaoMotivoSituacaoCadastral write FDescricaoMotivoSituacaoCadastral;
    property DescricaoPorte: string read FDescricaoPorte write FDescricaoPorte;
    property DescricaoSituacaoCadastral: string read FDescricaoSituacaoCadastral write FDescricaoSituacaoCadastral;
    property DescricaoTipoDeLogradouro: string read FDescricaoTipoDeLogradouro write FDescricaoTipoDeLogradouro;
    property EnteFederativoResponsavel: string read FEnteFederativoResponsavel write FEnteFederativoResponsavel;
    property IdentificadorMatrizFilial: Integer read FIdentificadorMatrizFilial write FIdentificadorMatrizFilial;
    property Logradouro: string read FLogradouro write FLogradouro;
    property MotivoSituacaoCadastral: Integer read FMotivoSituacaoCadastral write FMotivoSituacaoCadastral;
    property Municipio: string read FMunicipio write FMunicipio;
    property NaturezaJuridica: string read FNaturezaJuridica write FNaturezaJuridica;
    property NomeCidadeNoExterior: string read FNomeCidadeNoExterior write FNomeCidadeNoExterior;
    property NomeFantasia: string read FNomeFantasia write FNomeFantasia;
    property Numero: string read FNumero write FNumero;
    property OpcaoPeloMei: Boolean read FOpcaoPeloMei write FOpcaoPeloMei;
    property OpcaoPeloSimples: Boolean read FOpcaoPeloSimples write FOpcaoPeloSimples;
    property Porte: string read FPorte write FPorte;
    property Qsa: TObjectList<TQsa> read GetQsa;
    property QualificacaoDoResponsavel: Integer read FQualificacaoDoResponsavel write FQualificacaoDoResponsavel;
    property RazaoSocial: string read FRazaoSocial write FRazaoSocial;
    property SituacaoCadastral: Integer read FSituacaoCadastral write FSituacaoCadastral;
    property SituacaoEspecial: string read FSituacaoEspecial write FSituacaoEspecial;
    property Uf: string read FUf write FUf;
  public
    destructor Destroy; override;
  end;
  
implementation

{ TRoot }

destructor TBrasilApiWS.Destroy;
begin
  GetQsa.Free;
  GetCnaesSecundarios.Free;
  inherited;
end;

function TBrasilApiWS.GetCnaesSecundarios: TObjectList<TCnaesSecundarios>;
begin
  Result := ObjectList<TCnaesSecundarios>(FCnaesSecundarios, FCnaesSecundariosArray);
end;

function TBrasilApiWS.GetQsa: TObjectList<TQsa>;
begin
  Result := ObjectList<TQsa>(FQsa, FQsaArray);
end;

function TBrasilApiWS.GetAsJson: string;
begin
  RefreshArray<TCnaesSecundarios>(FCnaesSecundarios, FCnaesSecundariosArray);
  RefreshArray<TQsa>(FQsa, FQsaArray);
  Result := inherited;
end;

end.
