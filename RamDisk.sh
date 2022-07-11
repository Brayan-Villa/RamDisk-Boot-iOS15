#!/bin/bash
#By: Brayan Villa
#03/07/2022

declare EstructureA10;
declare EstructureA11;

iRecoveryInfo(){ libs/irecovery -q | grep -w $1 | awk '{printf $NF}'; };
Check2(){  if test -z "$(iRecoveryInfo ECID)"; then clear;  echo "DEVICE IN DFU MODE NOT DETECTED!";  Check;  fi; };
iRecovery(){ libs/irecovery -$1 "$2"; };
Check(){ Check2; };
cURL(){ curl -# "$1" --output $2; };
ProductType=$(cat type);
chmod -R 777 ./*
EstructureA10=(
   [SHSH]="shsh.shsh"
   [IBSS]="ibss.$ProductType.img4"
   [IBEC]="ibec.$ProductType.img4"
   [DTR]="devicetree.$ProductType.img4"
   [RDS]="ramdisk.$ProductType.img4"
   [TST]="trust.$ProductType.img4"
   [KNL]="kernel.$ProductType.img4"
);

EstructureA11=(
   [SHSH]="shsh.shsh"
   [IBSS]="ibss.$ProductType.img4"
   [IBEC]="ibec.$ProductType.img4"
   [DTR]="devicetree.$ProductType.img4"
   [RDS]="ramdisk.$ProductType.img4"
   [ADC]="adc.$ProductType.img4"
   [RTS]="rdtrust.$ProductType.img4"
   [KNL]="kernel.$ProductType.img4"
);

EXECUTEA10(){
   iRecovery "-f" "RamDisk/$1/"${EstructureA10[SHSH]};
   iRecovery "-f" "RamDisk/$1/"${EstructureA10[IBSS]};
   iRecovery "-f" "RamDisk/$1/"${EstructureA10[IBEC]};
   iRecovery "-c" "go";
   iRecovery "-f" "RamDisk/$1/"${EstructureA10[DTR]};
   iRecovery "-c" "devicetree";
   iRecovery "-f" "RamDisk/$1/"${EstructureA10[RDS]};
   iRecovery "-c" "ramdisk";
   iRecovery "-f" "RamDisk/$1/"${EstructureA10[TST]};
   iRecovery "-c" "firmware";
   iRecovery "-f" "RamDisk/$1/"${EstructureA10[KNL]};
   iRecovery "-c" "bootx"
};

EXECUTEA11(){
   iRecovery "-f" "RamDisk/$1/"${EstructureA11[SHSH]};
   iRecovery "-f" "RamDisk/$1/"${EstructureA11[IBSS]};
   iRecovery "-f" "RamDisk/$1/"${EstructureA11[IBEC]};
   iRecovery "-c" "go";
   iRecovery "-f" "RamDisk/$1/"${EstructureA11[DTR]};
   iRecovery "-c" "devicetree";
   iRecovery "-f" "RamDisk/$1/"${EstructureA11[RDS]};
   iRecovery "-c" "ramdisk";
   iRecovery "-f" "RamDisk/$1/"${EstructureA11[TST]};
   iRecovery "-c" "firmware";
   iRecovery "-f" "RamDisk/$1/"${EstructureA11[ADC]};
   iRecovery "-f" "RamDisk/$1/"${EstructureA11[RTS]};
   iRecovery "-c" "firmware"
   iRecovery "-f" "RamDisk/$1/"${EstructureA11[KNL]};
   iRecovery "-c" "bootx"
};
Eclipsa8003(){
  cd Exploits/ && sudo ./eclipsa8003;
 }
 Eclipsa8000(){
   cd Exploits/ && sudo ./eclipsa8000;
 }
 iPwndfu8010(){
   cd Exploits/ipwndfu8010 && sudo ./ipwndfu -p;
}
iPwndfu(){
   cd Exploits/ipwndfu && sudo ./ipwndfu -p; sudo ./ipwndfu --patch;
}   
iPwnderlite(){
   cd Exploits/ipwnder_lite-main && ./ipwnder_macosx -p
}
if test -z "$(iRecoveryInfo ECID)"; then Check; fi;

irecovery -q -v &>log; echo "printf \"$(cat log | grep -w Connected | sed 's/Connected to //g' | sed 's/, model /\";#/g')\"" &>pt;chmod +x pt;./pt &>type
echo "aHR0cHM6Ly9pdW5sb2NrLWdzbS5jb20vUmFtZGlzaw" &>enc
URL=$(base64 -d -i enc);
case "iPhone8,1" in
   "$ProductType")
    if  test -z "$(find RamDisk -iname 6s-8.1ok)";
   then
        cURL "$URL/6S81.lzma" "RamDisk/6S81.lzma";
        tar -zxvf RamDisk/6S81.lzma -C RamDisk;
        rm RamDisk/6S81.lzma
   fi
        eclipsa8003;
        EXECUTEA10 "6s-8.1ok";
   ;;
esac
case "iPhone8,2" in
   "$ProductType")
   if  test -z "$(find RamDisk -iname 6sp-8.2)"; 
   then
        cURL "$URL/6SP82N.lzma" "RamDisk/6SP82.lzma";
        tar -zxvf RamDisk/6SP82.lzma -C RamDisk;
        rm RamDisk/6SP82.lzma
    fi		                                 
        eclipsa8000;	
        EXECUTEA10 "6sp-8.2n";
   ;;
esac
case "iPhone9,1" in
   "$ProductType")
   if  test -z "$(find RamDisk -iname 7-9.1)"; 
   then
        cURL "$URL/792.lzma" "RamDisk/792.lzma";
        tar -zxvf RamDisk/792.lzma -C RamDisk;
        rm RamDisk/6SP82.lzma
   fi                                        
        iPwnderlite;
        EXECUTEA10 "7-9.2"
   ;;
esac
case "iPhone9,2" in
   "$ProductType")
   if  test -z "$(find RamDisk -iname 7p-9.2)"; 
   then
        cURL "$URL/7P92.lzma" "RamDisk/7P92.lzma";
        tar -zxvf RamDisk/7P92.lzma -C RamDisk;
		rm RamDisk/7P92.lzma
   fi
        iPwnderlite;
        EXECUTEA10 "7p-9.2"
   ;;
esac
case "iPhone9,3" in
   "$ProductType")
   if  test -z "$(find RamDisk -iname 7-9.3)"; 
   then
        cURL "$URL/793.lzma" "RamDisk/793.lzma";
        tar -zxvf RamDisk/793.lzma -C RamDisk;
        rm RamDisk/793.lzma;
   fi
        iPwnder;
        EXECUTEA10 "7-9.3"
   ;;
esac
case "iPhone9,4" in
   "$ProductType")
   if  test -z "$(find RamDisk -iname 7p-9.4)"; 
   then
        cURL "$URL/7P94.lzma" "RamDisk/7P94.lzma";
        tar -zxvf RamDisk/7P94.lzma -C RamDisk;
        rm RamDisk/7P94.lzma
        EXECUTEA10 "7p-9.4"
   fi
        iPwnder;
        EXECUTEA10 "7-9.4"
   ;;
esac
case "iPhone10,1" in
   "$ProductType")
   if  test -z "$(find RamDisk -iname 8-10.1)"; 
   then
        cURL "$URL/8101.lzma" "RamDisk/8101.lzma";
        tar -zxvf RamDisk/8101.lzma -C RamDisk;
		rm RamDisk/8101.lzma
   fi
        iPwndfu;
        EXECUTEA11 "8-10.1"
   ;;
esac
case "iPhone10,2" in
   "$ProductType")
   if  test -z "$(find RamDisk -iname 8p-10.2)"; 
   then
        cURL "$URL/8P102.lzma" "RamDisk/8P102.lzma";
        tar -zxvf RamDisk/8P102.lzma -C RamDisk;
        rm RamDisk/8P102.lzma
   fi
        iPwndfu;
         EXECUTEA11 "8p-10.2"
   ;;
esac
case "iPhone10,3" in
   "$ProductType")
   if  test -z "$(find RamDisk -iname x-10.3-ok)"; 
   then
        cURL "$URL/10103.lzma" "RamDisk/10103.lzma";
        tar -zxvf RamDisk/10103.lzma -C RamDisk;
        rm RamDisk/10103.lzma
   fi
        iPwndfu;
		EXECUTEA11 "x-10.3-ok"
   ;;
esac
case "iPhone10,4" in
   "$ProductType")
   if  test -z "$(find RamDisk -iname 8-10.4)"; 
   then
        cURL "$URL/8104.lzma" "RamDisk/8104.lzma";
        tar -zxvf RamDisk/8104.lzma -C RamDisk;
		rm RamDisk/8104.lzma
   fi
        iPwndfu;
		EXECUTEA11 "8-10.4"
   ;;
esac
case "iPhone10,5" in
   "$ProductType")
   if  test -z "$(find RamDisk -iname 8p-10.5)"; 
   then
        cURL "$URL/8P105.lzma" "RamDisk/8P105.lzma";
        tar -zxvf RamDisk/8P105.lzma -C RamDisk;
        rm RamDisk/8P105.lzma
   fi
        iPwndfu;
		EXECUTEA11 "8p-10.5"
   ;;
esac
case "iPhone10,6" in
   "$ProductType")
   if  test -z "$(find RamDisk -iname x-10.6)"; 
   then
        cURL "$URL/10106.lzma" "RamDisk/10106.lzma";
        tar -zxvf RamDisk/10106.lzma -C RamDisk;
        rm RamDisk/10106.lzma
   fi
        iPwndfu;
		EXECUTEA11 "x-10.6"
   ;;
esac
