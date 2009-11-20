% moiti� de C4

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% architecture

nb_g_pol = 3;			% nbre de lignes de guides poloidales 
nb_modules_tor = 8;		% nbre de modules sur une ligne poloidale 

nb_g_module_pol = 3;    	% nbre de guides par module dans le sens poloidal 

nb_g_module_tor = 3;		% nbre de guides par module ds le sens toroidal 
pass_module_tor = [2];

nb_g_passifs_inter_modules = 1;	% nbre de guides passifs entre les modules
nb_g_passifs_bord = 1;		%nbre de guides passifs sur chaque bord


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% dimensions

espacement_g_pol = 12e-3;	% espacement entre les grills juxtapos�s poloidalement 

a = 76e-3;			% hauteur des guides ds le sens poloidal  

b_g_actif = 14.65e-3;		% largeur des guides actifs 
b_g_pass = 13e-3;		% largeur des guides passifs

e = 3.825e-3;			% �paisseur des parois des guides dans le sens toroidal 

lcc = 1/4;			% longueur du court-circuit (en lambda guid�e);  


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% matrice S des modules ds des fichiers .m (NB : la matrice est rang�e sur une seule colonne)

% chemin_aller = '';
% chemin_retour = '';

chemin_aller = 'cd ../S_HFSS/matrices_HFSS_C4';
chemin_retour = 'cd ../../matlab';

% modules C4
nom_fichiers = ['S_C4_24b';'S_C4_23b';'S_C4_22b';'S_C4_21b';'S_C4_14b';'S_C4_13b';'S_C4_12b';'S_C4_11b'];   
% nom_fichiers = ['S_C4_24h';'S_C4_23h';'S_C4_22h';'S_C4_21h';'S_C4_14h';'S_C4_13h';'S_C4_12h';'S_C4_11h'];


% parametres 1D

T_grill = 2;                % p�riodicit� du grill / diminue les tps de calcul
D_guide_max = 100;          % d�couplage : pr |i-j| > D_guide_max, Kij = 0 avec {i,j} num�ros de deux guides => S  
                            % puis pr |i-j| > D_guide_max -5, Sij = 0 	/ diminue encore les tps de calcul
			    	  
erreur_rel = 1e-6;  	    % erreur sur les int�grales
pertes = 1e-6;              % tangente delta pour �viter les singularit�s	  