# Windows-batch
Bath tools for file processing, rename, extract, etc.

1)
**premenuj_adresar_pridaj_mesiac_a_rok.bat**

Vstupný parameter je názov adresára, alebo plná cesta uzavretý v úvodzovkách.

Príklad:

	premenuj_adresar_pridaj_mesiac_a_rok.bat "v15.0.563"

Zadaný adresár je premenovaný, ak je povolený zápis, do tvaru, ktorý obsahuje anglický názov aktuálneho mesiaca skrátený na prvé 3 písmená a aktuálny rok:

	v15.0.563 (Feb 2025)

2)
**premenuj_adresar_pridaj_resp_aktualizuj_mesiac_a_rok.bat**

Vstupný parameter je názov adresára, alebo plná cesta uzavretý v úvodzovkách.

Príklad:

	premenuj_adresar_pridaj_mesiac_a_rok.bat "v15.0.563"

alebo

	premenuj_adresar_pridaj_mesiac_a_rok.bat "v15.0.563 (Nov 2024)"

Zadaný adresár je premenovaný resp. dátum ja aktualizovaný, ak je povolený zápis, do tvaru, ktorý obsahuje anglický názov aktuálneho mesiaca skrátený na prvé 3 písmená a aktuálny rok:

	v15.0.563 (Feb 2025)

3)
**check_URL_file_size.bat**

Zisti veľkosť súboru na serveri, parameter je URL súboru:

Príklad:

	check_URL_file_size.bat "https://ardownload2.adobe.com/pub/adobe/acrobat/win/AcrobatDC/2400520399/AcroRdrDCx642400520399_sk_SK.exe"

 Výstup:

	Velkost: 617,853,336
 
Batch vyžaduje prítomnosť **curl**.
