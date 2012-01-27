;nyquist plug-in
;version 3
;type generate
;name "Segnale Orario SRC..."
;action "Generazione del segnale SRC..."
;info "Generatore di segnale orario RAI-SRC.\nPer maggiori info visitare il sito dell'INRiM all'indirizzo http://www.inrim.it/res/tf/src_i.shtml\n\nPer utilizzare questo segnale in maniera corretta si deve fare in modo che l'inizio dell'ultimo\nsegnale acustico corrisponda all'inizio del minuto a cui il segnale fa riferimento;\nequivalentemente l'inizio del suono generato deve essere allineato con il secondo 52 del minuto precedente.\n\nPlug-in rilasciato con licenza GPL 2 da David Costa <david@zarel.net>.\nRealizzato per O.R.S.A. Officine Radiotecniche Società Anonima."

;; I controlli sono organizzati per tipo
;; Data - Ora - Avvisi

;; Controlli impostazione data
;control anno "Anno" int "" 0 0 99
;control mese "Mese" int "" 1 1 12
;control giorno "Giorno" int "" 1 1 31
;control settimana "Nome giorno" choice "lunedì,martedì,mercoledì,giovedì,venerdì,sabato,domenica" "lunedì"

;; Controlli impostazione orario
;control ore "Ora" int "" 0 0 23
;control minuti "Minuto" int "" 0 0 59
;control legale "Ora estiva (DST)" choice "Ora legale,Ora solare" "Ora legale"

;; Controlli sugli avvisi
;control avviso-legale "Avviso cambio DST" choice "Nessun cambio nei prossimi 7 giorni,Previsto un cambio entro i prossimi 6 giorni,Previsto un cambio entro i prossimi 5 giorni,Previsto un cambio entro i prossimi 4 giorni,Previsto un cambio entro i prossimi 3 giorni,Previsto un cambio entro i prossimi 2 giorni,Previsto un cambio entro un giorno,Cambio all'ora solare (02.00)/legale(03.00) oggi" "Nessun cambio nei prossimi 7 giorni"
;control avviso-intercalare "Avviso secondo intercalare" choice "Nessuno previsto,Anticipo di 1s a fine mese,Ritardo di 1s a fine mese" "Nessuno previsto"

;; Inizializzo il bit di disparità
(setf parity 1) ;; Funziona come un contatore per i bit 1

(defun setparity () (progn (print "cambio parita") (if (= parity 1) (setf parity 0) (setf parity 1))))
(defun clearparity () (progn (print "reset parita") (setf parity 1)))

;; Converte secondi in millisecondi
(defun ms (value) (* 0.001 value))

;; Durata standard di un bit
(setf duration (ms 30))

;; Cifra zero: 30ms a 2kHz
(defun zero () (osc (hz-to-step 2000) duration))

;; Cifra uno: 30ms a 2.5kHz
(defun uno () (progn (setparity)(osc (hz-to-step 2500) duration)))

;; Beep
(defun beep () (osc (hz-to-step 1000) (ms 100)))

;; Genera il suono corretto a seconda del carattere ricevuto
;; 0 -> zero; 1 -> uno
(defun read-char (digit)
	(case digit
		(#\0 (zero))
		(#\1 (uno))
	)
)

;; Modula una stringa binaria con FSK
(defun fsk (stringa) 
	(seqrep (i (length stringa))
		 (read-char (char stringa i))
	)
)

;; Converte una cifra nel corrispondente BCD
(defun BCD (digit)
  	
	(case digit
		(0 "0000")
		(1 "0001")
		(2 "0010")
		(3 "0011")
		(4 "0100")
		(5 "0101")
		(6 "0110")
		(7 "0111")
		(8 "1000")
		(9 "1001")
	)
)

;; Converte un numero a due cifre in BCD
;; Il secondo parametro indica il numero di bit delle decine
(defun BCD2 (number bits)
	(strcat (subseq (BCD (/ number 10)) (- 4 bits)) (BCD (rem number 10)))
)


;; Converte il giorno della settimana in un numero binario
;; 0 - lunedì.... 6 domenica
(defun giorno-settimana (nome)
	(case nome
		(0 "001")
		(1 "010")
		(2 "011")
		(3 "100")
		(4 "101")
		(5 "110")
		(6 "111")
	)
)

;; Converte l'avviso ora legale in un numero binario
(defun avviso-legale-bin (nome)
	(case nome
		(0 "111") ;; nessun cambio
		(1 "110") ;; entro 6gg
		(2 "101")
		(3 "100")
		(4 "011")
		(5 "010")
		(6 "001")
		(7 "000") ;; oggi
	)
)

;; Converte l'avviso del secondo intercalare in un numero binario
;; 0 - nessuno; 1 - uno di anticipo; 2 - uno di ritardo
(defun avviso-intercalare-bin (nome)
	(case nome
		(0 "00")
		(1 "01")
		(2 "10")
	)
)

;; Converte la scelta dell'ora legale in binario
;; 0 - ora legale; 1 - ora solare
(defun legale-bin (nome)
	(case nome
		(0 "1")
		(1 "0")
	)
)

;; Genero il segnale nelle sue parti
;; = significa stringa binaria, * è un behavior
(defun =ID1 () "01")
(defun *ID1 () (progn (clearparity) (fsk (=ID1))))
(defun =OR () (BCD2 ore 2))
(defun *OR () (fsk (=OR)))
(defun =MI () (BCD2 minuti 3))
(defun *MI () (fsk (=MI)))
(defun =OE () (legale-bin legale))
(defun *OE () (fsk (=OE)))

(defun =P1 () (if (= parity 1) "1" "0"))
(defun *P1 () (fsk (progn (print (strcat "P1: " (=P1))) (=P1))))

(defun =ME () (progn (clearparity) (BCD2 mese 1)))
(defun *ME () (fsk (=ME)))
(defun =GM () (BCD2 giorno 2))
(defun *GM () (fsk (=GM)))
(defun =GS () (giorno-settimana settimana))
(defun *GS () (fsk (=GS)))

(defun =P2 () (if (= parity 1) "1" "0"))
(defun *P2 () (fsk (progn (print (strcat "P2: " (=P2))) (=P2))))

(defun =ID2 () "10")
(defun *ID2 () (progn (clearparity) (fsk (=ID2))))
(defun =AN () (BCD2 anno 4))
(defun *AN () (fsk (=AN)))
(defun =SE () (avviso-legale-bin avviso-legale))
(defun *SE () (fsk (=SE)))
(defun =SI () (avviso-intercalare-bin avviso-intercalare))
(defun *SI () (fsk (=SI)))

(defun =PA () (if (= parity 1) "1" "0"))
(defun *PA () (fsk (progn (print (strcat "PA: " (=PA))) (=PA))))

(defun primo-blocco () (seq (*ID1) (*OR) (*MI) (*OE) (*P1) (*ME) (*GM) (*GS) (*P2)))
(defun secondo-blocco () (seq (*ID2) (*AN) (*SE) (*SI) (*PA)))

;; Generazione effettiva del suono
;; Combino i blocchi, mettendoli al posto giusto
(seq
	(primo-blocco)
	(s-rest (ms 40))
	(secondo-blocco)
	(s-rest (ms 520))
	(beep)
	(s-rest (ms 900))
	(beep)
	(s-rest (ms 900))
	(beep)
	(s-rest (ms 900))
	(beep)
	(s-rest (ms 900))
	(beep)
	(s-rest (ms 1900))
	(beep)
)

