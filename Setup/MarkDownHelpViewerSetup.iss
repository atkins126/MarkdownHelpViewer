; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!
#define MyAppName 'Markdown Help Viewer'
#define MyAppVersion '2.0.1'

[Setup]
AppName={#MyAppName}
AppPublisher=Ethea S.r.l.
AppVerName={#MyAppName} {#MyAppVersion}
VersionInfoVersion={#MyAppVersion}
AppPublisherURL=https://www.ethea.it/
AppSupportURL=https://github.com/EtheaDev/MarkdownHelpViewer/issues
DefaultDirName={commonpf}\Ethea\MarkdownHelpViewer
OutputBaseFileName=MarkDownHelpViewerSetup
DisableDirPage=false
DefaultGroupName=Markdown Help Viewer
Compression=lzma
SolidCompression=true
UsePreviousAppDir=false
AppendDefaultDirName=false
PrivilegesRequired=admin
WindowVisible=false
WizardImageFile=WizEtheaImage.bmp
WizardSmallImageFile=WizEtheaSmallImage.bmp
AppContact=info@ethea.it
SetupIconFile=..\Icons\setup.ico
AppID=MDHelpViewer
UsePreviousSetupType=false
UsePreviousTasks=false
AlwaysShowDirOnReadyPage=true
AlwaysShowGroupOnReadyPage=true
ShowTasksTreeLines=true
DisableWelcomePage=False
AppCopyright=Copyright � 2023 Ethea S.r.l.
ArchitecturesInstallIn64BitMode=x64
MinVersion=0,6.1sp1
CloseApplications=force
UninstallDisplayIcon={app}\MDHelpViewer.exe

[Languages]
Name: eng; MessagesFile: compiler:Default.isl; LicenseFile: .\License_ENG.rtf
Name: ita; MessagesFile: compiler:Languages\Italian.isl; LicenseFile: .\Licenza_ITA.rtf


[Tasks]
Name: desktopicon; Description: {cm:CreateDesktopIcon}; GroupDescription: {cm:AdditionalIcons}; Flags: unchecked; Components: Viewer

[Files]
; 32 Bit files
Source: "..\Bin32\MDHelpViewer.exe"; DestDir: "{app}"; Flags: ignoreversion 32bit; Components: Viewer
Source: "..\Bin32\libeay32.dll"; DestDir: {app}; Components: Viewer; Flags: ignoreversion 32bit
Source: "..\Bin32\ssleay32.dll"; DestDir: {app}; Components: Viewer; Flags: ignoreversion 32bit
Source: "..\Bin32\sk4d.dll"; DestDir: {app}; Components: Viewer; Flags: ignoreversion 32bit

; 64 Bit files
Source: "..\Bin64\MDHelpViewer.exe"; DestDir: "{app}"; Flags: ignoreversion 64bit; Components: Viewer
Source: "..\Bin64\libeay32.dll"; DestDir: {app}; Components: Viewer; Flags: ignoreversion 64bit
Source: "..\Bin64\ssleay32.dll"; DestDir: {app}; Components: Viewer; Flags: ignoreversion 64bit
Source: "..\Bin64\sk4d.dll"; DestDir: {app}; Components: Viewer; Flags: ignoreversion 64bit

[Icons]
Name: "{group}\MDHelpViewer"; Filename: "{app}\MDHelpViewer.exe"; WorkingDir: "{app}"; IconFilename: "{app}\MDHelpViewer.exe"; Components: Viewer
Name: "{commondesktop}\MDHelpViewer"; Filename: "{app}\MDHelpViewer.exe"; Tasks: desktopicon; Components: Viewer

[Run]
Filename: {app}\MDHelpViewer.exe; Description: {cm:LaunchProgram,'Markdown Help Viewer'}; Flags: nowait postinstall skipifsilent; Components: Viewer

[Components]
Name: Viewer; Description: Markdown Help Viewer; Flags: fixed; Types: custom full
;Name: HelpViewer; Description: Markdown Help Viewer (Preview and Thumbnails); Types: custom compact full

[Registry]
Root: "HKCR"; Subkey: ".md"; ValueType: string; ValueData: "Open"; Flags: uninsdeletekey; Components: Viewer
Root: "HKCR"; Subkey: "Applications\MDHelpViewer.exe"; ValueType: string; ValueData: "Markdown Help Viewer"; Flags: uninsdeletekey; Components: Viewer
Root: "HKCR"; Subkey: "Applications\MDHelpViewer.exe\Shell\Open\Command"; ValueType: string; ValueData: """{app}\MDHelpViewer.exe"" ""%1"""; Flags: uninsdeletekey; Components: Viewer
Root: "HKCR"; Subkey: "Applications\MDHelpViewer.exe\DefaultIcon"; ValueType: string; ValueData: "{app}\MDHelpViewer.exe,0"; Flags: uninsdeletekey; Components: Viewer

[Code]
function InitializeSetup(): Boolean;
begin
   Result:=True;
end;

function GetUninstallString(): String;
var
  sUnInstPath: String;
  sUnInstallString: String;
begin
  sUnInstPath := ExpandConstant('Software\Microsoft\Windows\CurrentVersion\Uninstall\{#emit SetupSetting("AppId")}_is1');
  sUnInstallString := '';
  if not RegQueryStringValue(HKLM, sUnInstPath, 'UninstallString', sUnInstallString) then
    RegQueryStringValue(HKCU, sUnInstPath, 'UninstallString', sUnInstallString);
  Result := sUnInstallString;
end;

function IsUpgrade(): Boolean;
var
  s : string;
begin
  s := GetUninstallString();
  //MsgBox('GetUninstallString '+s, mbInformation, MB_OK);
  Result := (s <> '');
end;

function UnInstallOldVersion(): Integer;
var
  sUnInstallString: String;
  iResultCode: Integer;
begin
// Return Values:
// 1 - uninstall string is empty
// 2 - error executing the UnInstallString
// 3 - successfully executed the UnInstallString

  // default return value
  Result := 0;

  // get the uninstall string of the old app
  sUnInstallString := GetUninstallString();
  if sUnInstallString <> '' then begin
    sUnInstallString := RemoveQuotes(sUnInstallString);
    if Exec(sUnInstallString, '/SILENT /NORESTART /SUPPRESSMSGBOXES', '', SW_HIDE, ewWaitUntilTerminated, iResultCode) then
      Result := 3
    else
      Result := 2;
  end else
    Result := 1;
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if (CurStep=ssInstall) then
  begin
    if (IsUpgrade()) then
    begin
      MsgBox(ExpandConstant('An older version of "Markdown Help Viewer"  was detected. The uninstaller will be executed...'), mbInformation, MB_OK);
      UnInstallOldVersion();
    end;
  end;
end;