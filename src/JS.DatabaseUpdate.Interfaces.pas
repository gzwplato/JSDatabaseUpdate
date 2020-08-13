unit JS.DatabaseUpdate.Interfaces;

interface

uses
  System.Generics.Collections,
  FireDAC.Comp.Client;

type
  TEnumFieldType = (eftInteger, eftString, eftDate, eftTime, eftDecimal, eftBlob, eftLongBlob);
  TEnumSubType = (estNone, estBinary, estText);
  IJSDataBase = Interface;
  IJSTable = Interface;
  IJSTableField = Interface;
  IJSTableIndex = Interface;

  IJSDataBase = Interface
    ['{2610096C-452F-4D0F-9DCC-1AFF52B66076}']

    function Tables: TList<IJSTable>;
    function UpdateDB(AFDConn: TFDConnection): IJSDataBase;
  End;

  IJSTable = Interface
    ['{FE5EE2C5-A4B7-49C4-AC33-E33FD6457F3B}']

    function Description: String; overload;
    function Description(AValue: String): IJSTable; overload;

    function Fields: TList<IJSTableField>;
    function Indexs: TList<IJSTableIndex>;
  End;

  IJSTableField = Interface
    ['{693D068A-F15F-48E0-B871-88D4B77ACADE}']

    function FieldName: String; overload;
    function FieldName(AValue: String): IJSTableField; overload;

    function DisplayName: String; overload;
    function DisplayName(AValue: String): IJSTableField; overload;

    function FieldType: TEnumFieldType; overload;
    function FieldType(AValue: TEnumFieldType): IJSTableField; overload;

    function Size: Integer; overload;
    function Size(AValue: Integer): IJSTableField; overload;

    function Scale: Integer; overload;
    function Scale(AValue: Integer): IJSTableField; overload;

    function SubType: TEnumSubType; overload;
    function SubType(AValue: TEnumSubType): IJSTableField; overload;

    function NotNull: Boolean; overload;
    function NotNull(AValue: Boolean): IJSTableField; overload;

    function PrimaryKey: Boolean; overload;
    function PrimaryKey(AValue: Boolean): IJSTableField; overload;
  End;

  IJSTableIndex = Interface
    ['{693D068A-F15F-48E0-B871-88D4B77ACADE}']

    function IndexName: String; overload;
    function IndexName(AValue: String): IJSTableIndex; overload;

    function Fields: String; overload;
    function Fields(AValue: String): IJSTableIndex; overload;
  End;

implementation

end.
