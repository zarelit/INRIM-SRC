# Generatore segnale orario

Il programma è un plug-in per Audacity che genera un segnale orario RAI valido, composto quindi dalla sequenza binaria (“trillo”) e dalla serie di segnali acustici che lo contraddistinguono.

## Progetto archiviato
Sono giunte molte idee e richieste per email e su GitHub e ringrazio tutti gli utenti, purtroppo le opzioni di Audacity + Nyquist sono molto limitate e sarebbe necessaria una riscrittura.
Vi invito a provare `srcclock` che è una applicazione capace sia di generare che di decodificare l'SRC, la potete trovare qui: https://github.com/tornio/srcclock (o il fork https://github.com/boyska/srcclock che sistema la compilazione)

## Installazione

Per installare il plugin è sufficiente copiare il file `INRIM_SRC.ny` in una directory nota ad Audacious: in Linux, per installare il plug-in a un singolo utente il file va copiato nella directory `~/.audacity-files/plug-ins/` (creandola se non esiste).

In caso di dubbio consultare la [pagina dedicata del manuale di Audacity](https://wiki.audacityteam.org/wiki/Download_Nyquist_Plugins#Installing_Plugins).

## Utilizzo

Dopo aver avviato Audacity il plug-in è disponibile nel menù `Genera`/`Generate` alla voce `Segnale orario SRC...`.

Usarlo è semplice, una volta scelti i valori si preme il tasto Ok (o il tasto Debug si vuole vedere quali bit di parità sono stati calcolati).

L'audio così generato si sostituirà alla selezione esistente o verrà creata una nuova traccia se nessuna selezione è presente.

## Licenza e feedback

Il programma è interamente distribuito con licenza GPL2 il cui testo completo è reperibile [qui](https://www.gnu.org/licenses/old-licenses/gpl-2.0.html)

Per suggerimenti e feedback generale potete scrivermi all'indirizzo <david@zarel.net>

## Maggiori informazioni

Per maggiori informazioni sul Segnale RAI Codificato è possibile visitare la [pagina su Wikipedia](https://it.wikipedia.org/wiki/Segnale_orario) oppure una versione archiviata della [pagina ufficiale](https://web.archive.org/web/20161223104950/http://www.inrim.it:80/res/tf/src_i.shtml) dal sito web dell'INRiM.
