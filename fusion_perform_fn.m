function fusion_perform_fn(xrcw,x)

%%% fusion_perform_fn: Computes the Fusion Performance Parameters.

[QABF,LABF,NABF,NABF1]=objective_fusion_perform_fn(xrcw,x);

% fp=fopen('coded.txt','wb');
% fprintf(fp,'%6.4f\t %6.4f\t %6.4f\t %6.4f\t %6.4f\t %6.4f\t %6.4f\t %6.4f \t \t \t %6.4f\t %6.4f\t %6.4f\t %6.4f\t %6.4f\t %6.4f',API,SD,AG,entropyF,MIF,FS1,corr,SF,QABF,LABF,NABF1,QABF+LABF+NABF1,NABF,QABF+LABF+NABF);
% fclose(fp);
