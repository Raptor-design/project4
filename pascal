unit WebModuleUnit;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, Data.DB, Datasnap.DBClient,
  Datasnap.Provider, Data.SqlExpr, DBXCommon;

type
  TWebModule1 = class(TWebModule)
    SQLConnection1: TSQLConnection;
    SQLQuery1: TSQLQuery;
    DataSetProvider1: TDataSetProvider;
    ClientDataSet1: TClientDataSet;
    PageProducer1: TPageProducer;
    AddPageProducer: TPageProducer;
    procedure PageProducer1HTMLTag(Sender: TObject; Tag: TTag;
      const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure WebModule1itemsAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1addAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TWebModule1.PageProducer1HTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
var
  ItemsText: string;
begin
  if TagString = 'items' then
  begin
    ClientDataSet1.First;
    while not ClientDataSet1.Eof do
    begin
      ItemsText := ItemsText + Format(
        '<tr><td>%d</td><td>%s</td><td>%s</td></tr>',
        [ClientDataSet1.FieldByName('ID').AsInteger,
         ClientDataSet1.FieldByName('Title').AsString,
         ClientDataSet1.FieldByName('Description').AsString]);
      ClientDataSet1.Next;
    end;
    ReplaceText := ItemsText;
  end;
end;

procedure TWebModule1.WebModule1addAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  if Request.Method = 'POST' then
  begin
    with ClientDataSet1 do
    begin
      Append;
      FieldByName('Title').AsString := Request.ContentFields.Values['title'];
      FieldByName('Description').AsString := Request.ContentFields.Values['description'];
      Post;
      ApplyUpdates(0);
    end;
    Response.Content := 'Item added successfully! <a href="/scripts/SimpleWebApp.dll/items">Back to list</a>';
  end
  else
    Response.Content := AddPageProducer.Content;
end;

procedure TWebModule1.WebModule1itemsAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.Content := PageProducer1.Content;
end;

procedure TWebModule1.WebModuleCreate(Sender: TObject);
begin
  SQLConnection1.Params.Values['HostName'] := 'localhost';
  SQLConnection1.Params.Values['Database'] := 'WebAppDB';
  SQLConnection1.Params.Values['User_Name'] := 'your_username';
  SQLConnection1.Params.Values['Password'] := 'your_password';
  
  try
    SQLConnection1.Connected := True;
    ClientDataSet1.Active := True;
  except
    on E: Exception do
      raise Exception.Create('Database connection error: ' + E.Message);
  end;
end;

end.
