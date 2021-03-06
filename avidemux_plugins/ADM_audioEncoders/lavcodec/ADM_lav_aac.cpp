#define Join(x,y) x##_##y
#define AUDMEncoder_Lavcodec AUDMEncoder_Lavcodec_AAC
#define makeName(x) Join(x,AAC)
#define avMakeName          AV_CODEC_ID_AAC
#define ADM_LAV_VERSION     1,0,0
#define ADM_LAV_NAME        "LavAAC" 
#define ADM_LAV_MENU        "AAC (lav)" 
#define ADM_LAV_DESC        "AAC LavCodec encoder plugin Mean 2008/2016"
#define ADM_LAV_MAX_CHANNEL 6
#define ADM_LAV_SAMPLE_PER_P 1024

#define ADM_LAV_GLOBAL_HEADER 1
#include "audioencoder_lavcodec.cpp"

