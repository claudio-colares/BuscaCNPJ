{ -----------------------------------------+
  |  SISTEMA.........: BUSCA CNPJ           |
  |  LINGUAGEM/DB....: Delphi               |
  |  ANO.............: 2023                 |
  |-----------------------------------------|
  |  Programadores/autores:                 |
  |  - Claudio A. Colares                   |
  +-----------------------------------------}
unit PublicaCnpjWS;

interface

uses
  Pkg.Json.DTO, System.Generics.Collections, REST.Json.Types;

{$M+}

type
  TAtividadePrincipal = class;
  TAtividadesSecundarias = class;
  TCidade = class;
  TEstado = class;
  TInscricoesEstaduais = class;
  TPais = class;
  TQualificacaoSocio = class;

  TEstado = class
  private
    [JSONName('ibge_id')]
    FIbgeId: Integer;
    FId: Integer;
    FNome: string;
    FSigla: string;
  published
    property IbgeId: Integer read FIbgeId write FIbgeId;
    property Id: Integer read FId write FId;
    property Nome: string read FNome write FNome;
    property Sigla: string read FSigla write FSigla;
  end;
  
  TInscricoesEstaduais = class
  private
    FAtivo: Boolean;
    [SuppressZero, JSONName('atualizado_em')]
    FAtualizadoEm: TDateTime;
    FEstado: TEstado;
    [JSONName('inscricao_estadual')]
    FInscricaoEstadual: string;
  published
    property Ativo: Boolean read FAtivo write FAtivo;
    property AtualizadoEm: TDateTime read FAtualizadoEm write FAtualizadoEm;
    property Estado: TEstado read FEstado;
    property InscricaoEstadual: string read FInscricaoEstadual write FInscricaoEstadual;
  public
    constructor Create;
    destructor Destroy; override;
  end;
  
  TCidade = class
  private
    [JSONName('ibge_id')]
    FIbgeId: Integer;
    FId: Integer;
    FNome: string;
    [JSONName('siafi_id')]
    FSiafiId: string;
  published
    property IbgeId: Integer read FIbgeId write FIbgeId;
    property Id: Integer read FId write FId;
    property Nome: string read FNome write FNome;
    property SiafiId: string read FSiafiId write FSiafiId;
  end;
  
  TPais = class
  private
    [JSONName('comex_id')]
    FComexId: string;
    FId: string;
    FIso2: string;
    FIso3: string;
    FNome: string;
  published
    property ComexId: string read FComexId write FComexId;
    property Id: string read FId write FId;
    property Iso2: string read FIso2 write FIso2;
    property Iso3: string read FIso3 write FIso3;
    property Nome: string read FNome write FNome;
  end;
  
  TAtividadePrincipal = class
  private
    FClasse: string;
    FDescricao: string;
    FDivisao: string;
    FGrupo: string;
    FId: string;
    FSecao: string;
    FSubclasse: string;
  published
    property Classe: string read FClasse write FClasse;
    property Descricao: string read FDescricao write FDescricao;
    property Divisao: string read FDivisao write FDivisao;
    property Grupo: string read FGrupo write FGrupo;
    property Id: string read FId write FId;
    property Secao: string read FSecao write FSecao;
    property Subclasse: string read FSubclasse write FSubclasse;
  end;
  
  TAtividadesSecundarias = class
  private
    FClasse: string;
    FDescricao: string;
    FDivisao: string;
    FGrupo: string;
    FId: string;
    FSecao: string;
    FSubclasse: string;
  published
    property Classe: string read FClasse write FClasse;
    property Descricao: string read FDescricao write FDescricao;
    property Divisao: string read FDivisao write FDivisao;
    property Grupo: string read FGrupo write FGrupo;
    property Id: string read FId write FId;
    property Secao: string read FSecao write FSecao;
    property Subclasse: string read FSubclasse write FSubclasse;
  end;
  
  TEstabelecimento = class(TJsonDTO)
  private
    [JSONName('atividade_principal')]
    FAtividadePrincipal: TAtividadePrincipal;
    [JSONName('atividades_secundarias'), JSONMarshalled(False)]
    FAtividadesSecundariasArray: TArray<TAtividadesSecundarias>;
    [GenericListReflect]
    FAtividadesSecundarias: TObjectList<TAtividadesSecundarias>;
    [SuppressZero, JSONName('atualizado_em')]
    FAtualizadoEm: TDateTime;
    FBairro: string;
    FCep: string;
    FCidade: TCidade;
    FComplemento: string;
    FCnpj: string;
    [JSONName('cnpj_digito_verificador')]
    FCnpjDigitoVerificador: string;
    [JSONName('cnpj_ordem')]
    FCnpjOrdem: string;
    [JSONName('cnpj_raiz')]
    FCnpjRaiz: string;
    [SuppressZero, JSONName('data_inicio_atividade')]
    FDataInicioAtividade: TDateTime;
    [SuppressZero, JSONName('data_situacao_cadastral')]
    FDataSituacaoCadastral: TDateTime;
    FDdd1: string;
    FDdd2: string;
    [JSONName('ddd_fax')]
    FDddFax: string;
    FEmail: string;
    FEstado: TEstado;
    FFax: string;
    [JSONName('inscricoes_estaduais'), JSONMarshalled(False)]
    FInscricoesEstaduaisArray: TArray<TInscricoesEstaduais>;
    [GenericListReflect]
    FInscricoesEstaduais: TObjectList<TInscricoesEstaduais>;
    FLogradouro: string;
    [JSONName('nome_fantasia')]
    FNomeFantasia: string;
    FNumero: string;
    FPais: TPais;
    [JSONName('situacao_cadastral')]
    FSituacaoCadastral: string;
    FTelefone1: string;
    FTelefone2: string;
    FTipo: string;
    [JSONName('tipo_logradouro')]
    FTipoLogradouro: string;
    function GetAtividadesSecundarias: TObjectList<TAtividadesSecundarias>;
    function GetInscricoesEstaduais: TObjectList<TInscricoesEstaduais>;
  protected
    function GetAsJson: string; override;
  published
    property AtividadePrincipal: TAtividadePrincipal read FAtividadePrincipal;
    property AtividadesSecundarias: TObjectList<TAtividadesSecundarias> read GetAtividadesSecundarias;
    property AtualizadoEm: TDateTime read FAtualizadoEm write FAtualizadoEm;
    property Bairro: string read FBairro write FBairro;
    property Cep: string read FCep write FCep;
    property Cidade: TCidade read FCidade;
    property Complemento: string read FComplemento write FComplemento;
    property Cnpj: string read FCnpj write FCnpj;
    property CnpjDigitoVerificador: string read FCnpjDigitoVerificador write FCnpjDigitoVerificador;
    property CnpjOrdem: string read FCnpjOrdem write FCnpjOrdem;
    property CnpjRaiz: string read FCnpjRaiz write FCnpjRaiz;
    property DataInicioAtividade: TDateTime read FDataInicioAtividade write FDataInicioAtividade;
    property DataSituacaoCadastral: TDateTime read FDataSituacaoCadastral write FDataSituacaoCadastral;
    property Ddd1: string read FDdd1 write FDdd1;
    property Ddd2: string read FDdd2 write FDdd2;
    property DddFax: string read FDddFax write FDddFax;
    property Email: string read FEmail write FEmail;
    property Estado: TEstado read FEstado;
    property Fax: string read FFax write FFax;
    property InscricoesEstaduais: TObjectList<TInscricoesEstaduais> read GetInscricoesEstaduais;
    property Logradouro: string read FLogradouro write FLogradouro;
    property NomeFantasia: string read FNomeFantasia write FNomeFantasia;
    property Numero: string read FNumero write FNumero;
    property Pais: TPais read FPais;
    property SituacaoCadastral: string read FSituacaoCadastral write FSituacaoCadastral;
    property Telefone1: string read FTelefone1 write FTelefone1;
    property Telefone2: string read FTelefone2 write FTelefone2;
    property Tipo: string read FTipo write FTipo;
    property TipoLogradouro: string read FTipoLogradouro write FTipoLogradouro;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;
  
  TQualificacaoSocio = class
  private
    FDescricao: string;
    FId: Integer;
  published
    property Descricao: string read FDescricao write FDescricao;
    property Id: Integer read FId write FId;
  end;
  
  TSocios = class
  private
    [SuppressZero, JSONName('atualizado_em')]
    FAtualizadoEm: TDateTime;
    [JSONName('cpf_cnpj_socio')]
    FCpfCnpjSocio: string;
    [JSONName('cpf_representante_legal')]
    FCpfRepresentanteLegal: string;
    [SuppressZero, JSONName('data_entrada')]
    FDataEntrada: TDateTime;
    [JSONName('faixa_etaria')]
    FFaixaEtaria: string;
    FNome: string;
    [JSONName('pais_id')]
    FPaisId: string;
    [JSONName('qualificacao_socio')]
    FQualificacaoSocio: TQualificacaoSocio;
    FTipo: string;
  published
    property AtualizadoEm: TDateTime read FAtualizadoEm write FAtualizadoEm;
    property CpfCnpjSocio: string read FCpfCnpjSocio write FCpfCnpjSocio;
    property CpfRepresentanteLegal: string read FCpfRepresentanteLegal write FCpfRepresentanteLegal;
    property DataEntrada: TDateTime read FDataEntrada write FDataEntrada;
    property FaixaEtaria: string read FFaixaEtaria write FFaixaEtaria;
    property Nome: string read FNome write FNome;
    property PaisId: string read FPaisId write FPaisId;
    property QualificacaoSocio: TQualificacaoSocio read FQualificacaoSocio;
    property Tipo: string read FTipo write FTipo;
  public
    constructor Create;
    destructor Destroy; override;
  end;
  
  TQualificacaoDoResponsavel = class
  private
    FDescricao: string;
    FId: Integer;
  published
    property Descricao: string read FDescricao write FDescricao;
    property Id: Integer read FId write FId;
  end;
  
  TNaturezaJuridica = class
  private
    FDescricao: string;
    FId: string;
  published
    property Descricao: string read FDescricao write FDescricao;
    property Id: string read FId write FId;
  end;
  
  TPorte = class
  private
    FDescricao: string;
    FId: string;
  published
    property Descricao: string read FDescricao write FDescricao;
    property Id: string read FId write FId;
  end;
  
  TPublicaCnpjWS = class(TJsonDTO)
  private
    [SuppressZero, JSONName('atualizado_em')]
    FAtualizadoEm: TDateTime;
    [JSONName('capital_social')]
    FCapitalSocial: string;
    [JSONName('cnpj_raiz')]
    FCnpjRaiz: string;
    FEstabelecimento: TEstabelecimento;
    [JSONName('natureza_juridica')]
    FNaturezaJuridica: TNaturezaJuridica;
    FPorte: TPorte;
    [JSONName('qualificacao_do_responsavel')]
    FQualificacaoDoResponsavel: TQualificacaoDoResponsavel;
    [JSONName('razao_social')]
    FRazaoSocial: string;
    [JSONName('responsavel_federativo')]
    FResponsavelFederativo: string;
    [JSONName('socios'), JSONMarshalled(False)]
    FSociosArray: TArray<TSocios>;
    [GenericListReflect]
    FSocios: TObjectList<TSocios>;
    function GetSocios: TObjectList<TSocios>;
  protected
    function GetAsJson: string; override;
  published
    property AtualizadoEm: TDateTime read FAtualizadoEm write FAtualizadoEm;
    property CapitalSocial: string read FCapitalSocial write FCapitalSocial;
    property CnpjRaiz: string read FCnpjRaiz write FCnpjRaiz;
    property Estabelecimento: TEstabelecimento read FEstabelecimento;
    property NaturezaJuridica: TNaturezaJuridica read FNaturezaJuridica;
    property Porte: TPorte read FPorte;
    property QualificacaoDoResponsavel: TQualificacaoDoResponsavel read FQualificacaoDoResponsavel;
    property RazaoSocial: string read FRazaoSocial write FRazaoSocial;
    property ResponsavelFederativo: string read FResponsavelFederativo write FResponsavelFederativo;
    property Socios: TObjectList<TSocios> read GetSocios;
  public
    constructor Create; override;
    destructor Destroy; override;
    const
      SetURL : string= 'https://publica.cnpj.ws/cnpj/';
  end;
  
implementation

{ TInscricoesEstaduais }

constructor TInscricoesEstaduais.Create;
begin
  inherited;
  FEstado := TEstado.Create;
end;

destructor TInscricoesEstaduais.Destroy;
begin
  FEstado.Free;
  inherited;
end;

{ TEstabelecimento }

constructor TEstabelecimento.Create;
begin
  inherited;
  FAtividadePrincipal := TAtividadePrincipal.Create;
  FPais := TPais.Create;
  FEstado := TEstado.Create;
  FCidade := TCidade.Create;
end;

destructor TEstabelecimento.Destroy;
begin
  FAtividadePrincipal.Free;
  FPais.Free;
  FEstado.Free;
  FCidade.Free;
  GetAtividadesSecundarias.Free;
  GetInscricoesEstaduais.Free;
  inherited;
end;

function TEstabelecimento.GetAtividadesSecundarias: TObjectList<TAtividadesSecundarias>;
begin
  Result := ObjectList<TAtividadesSecundarias>(FAtividadesSecundarias, FAtividadesSecundariasArray);
end;

function TEstabelecimento.GetInscricoesEstaduais: TObjectList<TInscricoesEstaduais>;
begin
  Result := ObjectList<TInscricoesEstaduais>(FInscricoesEstaduais, FInscricoesEstaduaisArray);
end;

function TEstabelecimento.GetAsJson: string;
begin
  RefreshArray<TAtividadesSecundarias>(FAtividadesSecundarias, FAtividadesSecundariasArray);
  RefreshArray<TInscricoesEstaduais>(FInscricoesEstaduais, FInscricoesEstaduaisArray);
  Result := inherited;
end;

{ TSocios }

constructor TSocios.Create;
begin
  inherited;
  FQualificacaoSocio := TQualificacaoSocio.Create;
end;

destructor TSocios.Destroy;
begin
  FQualificacaoSocio.Free;
  inherited;
end;

{ tcnpjws }

constructor TPublicaCnpjWS.Create;
begin
  inherited;
  FPorte := TPorte.Create;
  FNaturezaJuridica := TNaturezaJuridica.Create;
  FQualificacaoDoResponsavel := TQualificacaoDoResponsavel.Create;
  FEstabelecimento := TEstabelecimento.Create;
end;

destructor TPublicaCnpjWS.Destroy;
begin
  FPorte.Free;
  FNaturezaJuridica.Free;
  FQualificacaoDoResponsavel.Free;
  FEstabelecimento.Free;
  GetSocios.Free;
  inherited;
end;

function TPublicaCnpjWS.GetSocios: TObjectList<TSocios>;
begin
  Result := ObjectList<TSocios>(FSocios, FSociosArray);
end;

function TPublicaCnpjWS.GetAsJson: string;
begin
  RefreshArray<TSocios>(FSocios, FSociosArray);
  Result := inherited;
end;

end.
