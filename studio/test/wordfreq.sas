 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: WORDFREQ                                            */
 /*   TITLE: Textual Analysis of Word Frequency                  */
 /* PRODUCT: SAS                                                 */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS: FREQUENCY COUNT                                     */
 /*   PROCS: FREQ PLOT RANK SORT                                 */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT: aww                         UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/
RUN;TITLE '------------------ WORDFREQ SAMPLE --------------';

DATA WORDS; INPUT WORD  : $ 16.@@; LIST; CARDS;
FOURSCORE AND SEVEN YEARS AGO OUR FATHERS BROUGHT
FORTH ON THIS CONTINENT A NEW NATION , CONCEIVED IN LIBERTY ,
AND DEDICATED TO THE PROPOSITION THAT ALL MEN ARE CREATED
EQUAL . NOW WE ARE ENGAGED IN A GREAT CIVIL WAR , TESTING
WHETHER THAT NATION , OR ANY NATION SO CONCEIVED AND SO
DEDICATED , CAN LONG ENDURE . WE ARE MET ON A GREAT BATTLEFIELD
OF THAT WAR . WE HAVE COME TO DEDICATE A PORTION OF
THAT FIELD , AS A FINAL RESTING PLACE FOR THOSE WHO HERE GAVE
THEIR LIVES THAT THAT NATION MIGHT LIVE . IT IS ALTOGETHER
FITTING AND PROPER THAT WE SHOULD DO THIS . BUT , IN A LARGER
SENSE , WE CANNOT DEDICATE WE CANNOT CONSECRATE WE
CANNOT HALLOW THIS GROUND . THE BRAVE MEN , LIVING AND
DEAD , WHO STRUGGLED HERE , HAVE CONSECRATED IT , FAR ABOVE
OUR POOR POWER TO ADD OR DETRACT . THE WORLD WILL LITTLE
NOTE , NOR LONG REMEMBER , WHAT WE SAY HERE , BUT IT CAN
NEVER FORGET WHAT THEY DID HERE . IT IS FOR US THE LIVING ,
RATHER , TO BE DEDICATED HERE TO THE UNFINISHED WORK WHICH
THEY WHO FOUGHT HERE HAVE THIS FAR SO NOBLY ADVANCED .
IT IS RATHER FOR US TO BE HERE DEDICATED TO THE GREAT TASK
REMAINING BEFORE US , THAT FROM THESE HONORED DEAD WE
TAKE INCREASED DEVOTION TO THAT CAUSE FOR WHICH THEY GAVE
THE LAST FULL MEASURE OF DEVOTION THAT WE HERE HIGHLY
RESOLVE THAT THESE DEAD SHALL NOT HAVE DIED IN VAIN THAT
THIS NATION UNDER GOD SHALL HAVE A NEW BIRTH OF FREEDOM
AND THAT GOVERNMENT OF THE PEOPLE , BY THE PEOPLE ,
FOR THE PEOPLE , SHALL NOT PERISH FROM THE EARTH .
PROC FREQ; TABLES WORD/NOPRINT OUT=COUNTS;
DATA; SET;
   FILE PRINT;
   IF WORD>='A';  N+1; DROP N;
   IF MOD(N,6)=1 THEN PUT;
   PUT WORD $10. COUNT 5. +3 @;
TITLE 'WORD FREQUENCIES OF LINCOLN''S GETTYSBURG ADDRESS';
PROC SORT; BY DESCENDING COUNT;
DATA; FILE PRINT; SET;
   IF MOD(_N_,6)=1 THEN PUT;
   PUT WORD $10. COUNT 5. +3 @;
PROC RANK REVERSE; VAR COUNT; RANKS RANK;
DATA; SET; LOGRANK=LOG(RANK); LOGCOUNT=LOG(COUNT);
PROC PLOT; PLOT COUNT*RANK LOGCOUNT*LOGRANK;
RUN;