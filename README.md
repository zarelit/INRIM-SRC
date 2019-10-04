# Generatore segnale orario

Il programma è un plug-in per Audacity che genera un segnale orario RAI valido, composto quindi dalla sequenza binaria (“trillo”) e dalla serie di segnali acustici che lo contraddistinguono.

## Installazione

Per installare il plugin è sufficiente copiare il file `INRIM_SRC.ny` in una directory nota ad Audacious: in Linux, per installare il plug-in a un singolo utente il file va copiato nella directory `~/.audacity-files/plug-ins/` (creandola se non esiste).

In caso di dubbio consultare la [pagina dedicata del manuale di Audacity](http://wiki.audacityteam.org/wiki/Download_Nyquist_Plugins#Installing_Plugins).

## Utilizzo

Dopo aver avviato Audacity il plug-in è disponibile nel menù `Genera`/`Generate` alla voce `Segnale orario SRC...`.

Usarlo è semplice, una volta scelti i valori si preme il tasto Ok (o il tasto Debug si vuole vedere quali bit di parità sono stati calcolati).

L'audio così generato si sostituirà alla selezione esistente o verrà creata una nuova traccia se nessuna selezione è presente.

## Licenza e feedback

Il programma è interamente distribuito con licenza GPL2 il cui testo completo è reperibile al seguente indirizzo

https://www.gnu.org/licenses/old-licenses/gpl-2.0.html

Per suggerimenti e feedback generale potete scrivermi all'indirizzo <david@zarel.net>

## Maggiori informazioni

Per maggiori informazioni sul Segnale RAI Codificato è possibile visitare la [pagina su Wikipedia](https://it.wikipedia.org/wiki/Segnale_orario)
