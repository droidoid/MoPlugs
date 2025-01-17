; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "MoPlugs for AutodeskŪ MotionBuilderŪ"
#define MyAppVersion "2019.0.1"
#define MyAppPublisher "Neill3d"
#define MyAppURL "https://github.com/Neill3d/MoPlugs"
#define MyAppExeName "Setup_MoPlugs_2019_0_1"

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"; InfoBeforeFile:"infoBefore_en.txt"; InfoAfterFile: "infoAfter_en.txt"
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl"; InfoBeforeFile:"infoBefore_ru.txt"; InfoAfterFile: "infoAfter_ru.txt"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{2A0E1623-47E7-49DD-87AA-0BAB1C1226B0}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
CreateAppDir=no
OutputBaseFilename={#MyAppExeName}
Compression=lzma
SolidCompression=yes
AppCopyright=Copyright (C) 2019 Neill3d
WizardImageFile=MoP.bmp
WizardImageStretch=no
WizardSmallImageFile=MoP_sm.bmp
DisableWelcomePage=no

[Types]
Name: "full"; Description: "Full installation"
Name: "2014"; Description: "MotionBuilder 2014"
Name: "2015"; Description: "MotionBuilder 2015"
Name: "2016"; Description: "MotionBuilder 2016"
Name: "2017"; Description: "MotionBuilder 2017"
Name: "2018"; Description: "MotionBuilder 2018"
Name: "2019"; Description: "MotionBuilder 2019"

Name: "custom"; Description: "Custom installation"; Flags: iscustom

[Components]
Name: "MotionBuilder2014"; Description: "MotionBuilder 2014 plugins"; Types: full 2014 custom;
Name: "MotionBuilder2015"; Description: "MotionBuilder 2015 plugins"; Types: full 2015 custom;
Name: "MotionBuilder2016"; Description: "MotionBuilder 2016 plugins"; Types: full 2016 custom;
Name: "MotionBuilder2017"; Description: "MotionBuilder 2017 plugins"; Types: full 2017 custom;
Name: "MotionBuilder2018"; Description: "MotionBuilder 2018 plugins"; Types: full 2018 custom;
Name: "MotionBuilder2019"; Description: "MotionBuilder 2019 plugins"; Types: full 2019 custom;

[Files]

; 2014

Source: "..\bin\x64\common\*.dll"; DestDir: "{code:MoBu_Path64|2014}\bin\x64\plugins\"; Flags: ignoreversion; Components: MotionBuilder2014
Source: "..\bin\x64\plugins_2014\*.dll"; DestDir: "{code:MoBu_Path64|2014}\bin\x64\plugins\"; Flags: ignoreversion; Components: MotionBuilder2014
Source: "..\bin\System\BlendShapeToolkit\*"; DestDir: "{code:MoBu_Path64|2014}\bin\system\BlendShapeToolkit"; Flags: ignoreversion; Components: MotionBuilder2014
Source: "..\bin\System\GLSL\*"; DestDir: "{code:MoBu_Path64|2014}\bin\x64\plugins\GLSL\"; Flags: ignoreversion; Components: MotionBuilder2014
Source: "..\bin\System\GLSL_CS\*"; DestDir: "{code:MoBu_Path64|2014}\bin\x64\plugins\GLSL_CS\"; Flags: ignoreversion; Components: MotionBuilder2014
Source: "..\bin\System\GLSL_FX\*"; DestDir: "{code:MoBu_Path64|2014}\bin\x64\plugins\GLSL_FX\"; Flags: ignoreversion; Components: MotionBuilder2014
Source: "..\bin\System\*"; DestDir: "{code:MoBu_Path64|2014}\bin\system\"; Flags: ignoreversion; Components: MotionBuilder2014
Source: "..\PythonScripts\Startup\*"; DestDir: "{userdocs}\MB\2014-x64\config\PythonStartup\"; Flags: ignoreversion; Components: MotionBuilder2014
Source: "..\PythonScripts\Lib\*"; DestDir: "{userdocs}\MB\2014-x64\config\PythonStartup\"; Flags: ignoreversion; Components: MotionBuilder2014
Source: "..\PythonScripts\Actions\*"; DestDir: "{code:MoBu_Path64|2014}\bin\config\Scripts\MoPlugs\"; Flags: ignoreversion; Components: MotionBuilder2014

; 2015

Source: "..\bin\x64\common\*.dll"; DestDir: "{code:MoBu_Path64|2015}\bin\x64\plugins\"; Flags: ignoreversion; Components: MotionBuilder2015
Source: "..\bin\x64\plugins_2015\*.dll"; DestDir: "{code:MoBu_Path64|2015}\bin\x64\plugins\"; Flags: ignoreversion; Components: MotionBuilder2015
Source: "..\bin\System\BlendShapeToolkit\*"; DestDir: "{code:MoBu_Path64|2015}\bin\system\BlendShapeToolkit"; Flags: ignoreversion; Components: MotionBuilder2015
Source: "..\bin\System\GLSL\*"; DestDir: "{code:MoBu_Path64|2015}\bin\x64\plugins\GLSL\"; Flags: ignoreversion; Components: MotionBuilder2015
Source: "..\bin\System\GLSL_CS\*"; DestDir: "{code:MoBu_Path64|2015}\bin\x64\plugins\GLSL_CS\"; Flags: ignoreversion; Components: MotionBuilder2015
Source: "..\bin\System\GLSL_FX\*"; DestDir: "{code:MoBu_Path64|2015}\bin\x64\plugins\GLSL_FX\"; Flags: ignoreversion; Components: MotionBuilder2015
Source: "..\bin\System\*"; DestDir: "{code:MoBu_Path64|2015}\bin\system\"; Flags: ignoreversion; Components: MotionBuilder2015
Source: "..\PythonScripts\Startup\*"; DestDir: "{userdocs}\MB\2015-x64\config\PythonStartup\"; Flags: ignoreversion; Components: MotionBuilder2015
Source: "..\PythonScripts\Lib\*"; DestDir: "{userdocs}\MB\2015-x64\config\PythonStartup\"; Flags: ignoreversion; Components: MotionBuilder2015
Source: "..\PythonScripts\Actions\*"; DestDir: "{code:MoBu_Path64|2015}\bin\config\Scripts\MoPlugs\"; Flags: ignoreversion; Components: MotionBuilder2015

; 2016

Source: "..\bin\x64\common\*.dll"; DestDir: "{code:MoBu_Path64|2016}\bin\x64\plugins\"; Flags: ignoreversion; Components: MotionBuilder2016
Source: "..\bin\x64\plugins_2016\*.dll"; DestDir: "{code:MoBu_Path64|2016}\bin\x64\plugins\"; Flags: ignoreversion; Components: MotionBuilder2016
Source: "..\bin\System\BlendShapeToolkit\*"; DestDir: "{code:MoBu_Path64|2016}\bin\system\BlendShapeToolkit"; Flags: ignoreversion; Components: MotionBuilder2016
Source: "..\bin\System\GLSL\*"; DestDir: "{code:MoBu_Path64|2016}\bin\x64\plugins\GLSL\"; Flags: ignoreversion; Components: MotionBuilder2016
Source: "..\bin\System\GLSL_CS\*"; DestDir: "{code:MoBu_Path64|2016}\bin\x64\plugins\GLSL_CS\"; Flags: ignoreversion; Components: MotionBuilder2016
Source: "..\bin\System\GLSL_FX\*"; DestDir: "{code:MoBu_Path64|2016}\bin\x64\plugins\GLSL_FX\"; Flags: ignoreversion; Components: MotionBuilder2016
Source: "..\bin\System\*"; DestDir: "{code:MoBu_Path64|2016}\bin\system\"; Flags: ignoreversion; Components: MotionBuilder2016
Source: "..\PythonScripts\Startup\*"; DestDir: "{userdocs}\MB\2016-x64\config\PythonStartup\"; Flags: ignoreversion; Components: MotionBuilder2016
Source: "..\PythonScripts\Lib\*"; DestDir: "{userdocs}\MB\2016-x64\config\PythonStartup\"; Flags: ignoreversion; Components: MotionBuilder2016
Source: "..\PythonScripts\Actions\*"; DestDir: "{code:MoBu_Path64|2016}\bin\config\Scripts\MoPlugs\"; Flags: ignoreversion; Components: MotionBuilder2016

; 2017

Source: "..\bin\x64\common\*.dll"; DestDir: "{code:MoBu_Path64|2017}\bin\x64\plugins\"; Flags: ignoreversion; Components: MotionBuilder2017
Source: "..\bin\x64\plugins_2017\*.dll"; DestDir: "{code:MoBu_Path64|2017}\bin\x64\plugins\"; Flags: ignoreversion; Components: MotionBuilder2017
Source: "..\bin\System\BlendShapeToolkit\*"; DestDir: "{code:MoBu_Path64|2017}\bin\system\BlendShapeToolkit"; Flags: ignoreversion; Components: MotionBuilder2017
Source: "..\bin\System\GLSL\*"; DestDir: "{code:MoBu_Path64|2017}\bin\x64\plugins\GLSL\"; Flags: ignoreversion; Components: MotionBuilder2017
Source: "..\bin\System\GLSL_CS\*"; DestDir: "{code:MoBu_Path64|2017}\bin\x64\plugins\GLSL_CS\"; Flags: ignoreversion; Components: MotionBuilder2017
Source: "..\bin\System\GLSL_FX\*"; DestDir: "{code:MoBu_Path64|2017}\bin\x64\plugins\GLSL_FX\"; Flags: ignoreversion; Components: MotionBuilder2017
Source: "..\bin\System\*"; DestDir: "{code:MoBu_Path64|2017}\bin\system\"; Flags: ignoreversion; Components: MotionBuilder2017
Source: "..\PythonScripts\Startup\*"; DestDir: "{userdocs}\MB\2017-x64\config\PythonStartup\"; Flags: ignoreversion; Components: MotionBuilder2017
Source: "..\PythonScripts\Lib\*"; DestDir: "{userdocs}\MB\2017-x64\config\PythonStartup\"; Flags: ignoreversion; Components: MotionBuilder2017
Source: "..\PythonScripts\Actions\*"; DestDir: "{code:MoBu_Path64|2017}\bin\config\Scripts\MoPlugs\"; Flags: ignoreversion; Components: MotionBuilder2017

; 2018

Source: "..\bin\x64\common\*.dll"; DestDir: "{code:MoBu_Path64|2018}\bin\x64\plugins\"; Flags: ignoreversion; Components: MotionBuilder2018
Source: "..\bin\x64\plugins_2018\*.dll"; DestDir: "{code:MoBu_Path64|2018}\bin\x64\plugins\"; Flags: ignoreversion; Components: MotionBuilder2018
Source: "..\bin\System\BlendShapeToolkit\*"; DestDir: "{code:MoBu_Path64|2018}\bin\system\BlendShapeToolkit"; Flags: ignoreversion; Components: MotionBuilder2018
Source: "..\bin\System\GLSL\*"; DestDir: "{code:MoBu_Path64|2018}\bin\x64\plugins\GLSL\"; Flags: ignoreversion; Components: MotionBuilder2018
Source: "..\bin\System\GLSL_CS\*"; DestDir: "{code:MoBu_Path64|2018}\bin\x64\plugins\GLSL_CS\"; Flags: ignoreversion; Components: MotionBuilder2018
Source: "..\bin\System\GLSL_FX\*"; DestDir: "{code:MoBu_Path64|2018}\bin\x64\plugins\GLSL_FX\"; Flags: ignoreversion; Components: MotionBuilder2018
Source: "..\bin\System\*"; DestDir: "{code:MoBu_Path64|2018}\bin\system\"; Flags: ignoreversion; Components: MotionBuilder2018
Source: "..\PythonScripts\Startup\*"; DestDir: "{userdocs}\MB\2018-x64\config\PythonStartup\"; Flags: ignoreversion; Components: MotionBuilder2018
Source: "..\PythonScripts\Lib\*"; DestDir: "{userdocs}\MB\2018-x64\config\PythonStartup\"; Flags: ignoreversion; Components: MotionBuilder2018
Source: "..\PythonScripts\Actions\*"; DestDir: "{code:MoBu_Path64|2018}\bin\config\Scripts\MoPlugs\"; Flags: ignoreversion; Components: MotionBuilder2018

; 2019

Source: "..\bin\x64\common\*.dll"; DestDir: "{code:MoBu_Path64|2019}\bin\x64\plugins\"; Flags: ignoreversion; Components: MotionBuilder2019
Source: "..\bin\x64\plugins_2019\*.dll"; DestDir: "{code:MoBu_Path64|2019}\bin\x64\plugins\"; Flags: ignoreversion; Components: MotionBuilder2019
Source: "..\bin\System\BlendShapeToolkit\*"; DestDir: "{code:MoBu_Path64|2019}\bin\system\BlendShapeToolkit"; Flags: ignoreversion; Components: MotionBuilder2019
Source: "..\bin\System\GLSL\*"; DestDir: "{code:MoBu_Path64|2019}\bin\x64\plugins\GLSL\"; Flags: ignoreversion; Components: MotionBuilder2019
Source: "..\bin\System\GLSL_CS\*"; DestDir: "{code:MoBu_Path64|2019}\bin\x64\plugins\GLSL_CS\"; Flags: ignoreversion; Components: MotionBuilder2019
Source: "..\bin\System\GLSL_FX\*"; DestDir: "{code:MoBu_Path64|2019}\bin\x64\plugins\GLSL_FX\"; Flags: ignoreversion; Components: MotionBuilder2019
Source: "..\bin\System\*"; DestDir: "{code:MoBu_Path64|2019}\bin\system\"; Flags: ignoreversion; Components: MotionBuilder2019
Source: "..\PythonScripts\Startup\*"; DestDir: "{userdocs}\MB\2019-x64\config\PythonStartup\"; Flags: ignoreversion; Components: MotionBuilder2019
Source: "..\PythonScripts\Lib\*"; DestDir: "{userdocs}\MB\2019-x64\config\PythonStartup\"; Flags: ignoreversion; Components: MotionBuilder2019
Source: "..\PythonScripts\Actions\*"; DestDir: "{code:MoBu_Path64|2019}\bin\config\Scripts\MoPlugs\"; Flags: ignoreversion; Components: MotionBuilder2019

; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Code]

function MoBu_Path32(Param: String): String;
var
  key, path: String;
begin
  key := 'Software\Autodesk\MotionBuilder\' + Param;
  Result := '';
  if RegKeyExists(HKEY_LOCAL_MACHINE, key) then
  begin
    If RegQueryStringValue(HKEY_LOCAL_MACHINE, key, 'InstallPath', path) then
    begin
      Result := path;
    end;
  end;
end;

function MoBu_Path64(Param: String): String;
var
  key, path: String;
begin
  key := 'Software\Autodesk\MotionBuilder\' + Param;
  Result := '';
  if IsWin64 and RegKeyExists(HKLM64, key) then
  begin
    If RegQueryStringValue(HKLM64, key, 'InstallPath', path) then
    begin
      Result := path;
    end;
  end;
end;

function IsMoBu(Param: String): Boolean;
begin
  Result := False;
  if RegKeyExists(HKLM, 'Software\Autodesk\MotionBuilder\' + Param) then
  begin
    Result := True;
  end;
end;

function IsMoBu64(Param: String) : Boolean;
begin
  Result := False;
  if IsWin64 and RegKeyExists(HKLM64, 'Software\Autodesk\MotionBuilder\' + Param) then
  begin
    Result := True;
  end;
end;