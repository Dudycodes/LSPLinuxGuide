# LSP Linux Guide
Tento návod vznikl jako soubor návodů k vyřešení problémů vzniklých rozdíly v OS (Windows / Linux - primárně Ubuntu),
na které jsem narazil při řešení domácích úloh v předmětu LSP na FEL ČVUT.

## Instalace Quartus II
Instalace je prakticky totožná jako na [Windows](https://dcenet.fel.cvut.cz/edu/fpga/install.aspx) - doporučuji však verzi [20.1](https://www.intel.com/content/www/us/en/software-kit/661017/intel-quartus-prime-lite-edition-design-software-version-20-1-for-linux.html)
Spouštění pak probíhá přes 

```
cd intelFPGA_lite/20.1/quartus/bin 
./quartus
```

(Pozn. cestu bude třeba upravit pokud při instalaci zvolíte jiný adresář než domovský adresář Vašeho uživatelského účtu)

## Připojení desky - zpřístupnění USBBlasteru

postupujte dle: https://www.rocketboards.org/foswiki/Documentation/UsingUSBBlasterUnderLinux

## Simulace (.vwf)

Bude doplněno časem... (prozatím ve zkratce - stačí akorát přečíst, co je doopravdy v chybové hlášce tedy - upravit podle toho nastavení simulace:
To znamená opravit cestu k .vwf souboru, odstranit jeden parametr a případně doinstalovat všechny závislosti quartusu)

## Update souboru v programmeru

Narazil jsem na bug, kdy v programmeru zůstává označený k nahrání jiný soubor, než je aktuální zkompilovaná Top-Level Entity. Stačí je jen nastavit správně:

## Simulace LCD s GHDL

GHDL je další linux nativní nástroj a proto je jeho použití na linuxu ve výsledku jedndodušší, jelikož tak nevyžaduje 
instalaci a běh v subsystému. 

I přesto instalace GHDL přináší menší obtíž - prosím vyvarujte se stránky http://ghdl.free.fr a využívejte pouze https://ghdl.github.io/ghdl/

Pokud používáte ubuntu, instalace je jednoduchá - použijte buď snap, a nebo si stahněte některý z [posledních releasů](https://github.com/ghdl/ghdl/releases) (doporučuje se mcode varianta).
Nevyužívejte apt! Obsahuje zastaralou verzi, která neobsahuje mnohé nutné.

```
sudo snap install ghdl
```

Od roku 2024 je v LSP k simulaci LCD displaye k dispozici .bat script. Ten zde poskytuji přepsaný do bashe.
Návod na úpravu testbench souboru je tedy shodný pro Windows i Linux a mělo by tak stačit pouze opravit cestu 
výstupu v souboru testbench\_LCDlogic.vhd (viz ToDo 1 - constant FILE\_NAME) a případně opravit názvy komponent (viz ToDo 2).

Následná simulace by pak měla být už jen spuštěním skriptu [runtb.sh](ghdl_sim/runtb.sh) přemístěného do složky simulation ve Quartus projektu:

```
./runtb.sh
```

První (a zdá se že i jediný) problém nastává u nutného použití **LSPTools**. Ty jakožto .exe soubor nejsou standardně kompatibilní s Linuxem.
Přesto je lze s větším či menším úspěchem spustit za pomocí nástroje wine. Ten jelikož bylo použito .NET frameworku je třeba pro funkčnost rozšířit o
wine-mono. Ten lze přidat následovně:

1. Stahněte [wine-mono.msi](https://dl.winehq.org/wine/wine-mono/)
2. Spusťte přes příkazovou řádku `wine64 uninstaller`
3. Zvolte ikonu install a vložte stažený .msi soubor
4. Zavřete dialogové okno uninstalleru

U nástrojů **Bitmap to VHDL** a **LCD Geometry Rulers** se zdá by pak již neměl být problém. 

Ovšem **Testbench Viewer** jsem nezprovoznil. Jednodušší bylo připravit [tento python script](ghdl_sim/lsp_txt_to_ppm.py), který převádí výstup simulace na .ppm

