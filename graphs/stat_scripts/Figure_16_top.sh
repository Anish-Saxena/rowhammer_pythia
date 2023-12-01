#!/bin/bash

STAT_DIR="../../experiments/representative_figures/"
CURR_DIR=`pwd`
OUT_FILE="${CURR_DIR}/data/start_lite_single_T64.csv"

cd ${STAT_DIR}/;

IDEAL_DIR="8C_ideal_T64/"
START_S_DIR="8C_1b_T64/"
START_L_DIR="8C_mm_lite_T64/"
HYDRA_C_DIR="8C_Hydra_T64.186KB/"
HYDRA_P_DIR="8C_Hydra_T64_RG32_S1K/"
START_D_DIR="8C_2b_T64/"

echo "workload	hydra_c	hydra_p	start_s	start_lite	start_d	ideal" > ${OUT_FILE}

# Bmk names
BMK_NAMES=`python get_norm_ipc.py ${IDEAL_DIR} BMK_NAMES_OUTPUT`
IDEAL=`python get_norm_ipc.py ${IDEAL_DIR} DETAILED_OUTPUT`
START_S=`python get_norm_ipc.py ${START_S_DIR} DETAILED_OUTPUT`
START_D=`python get_norm_ipc.py ${START_D_DIR} DETAILED_OUTPUT`
START_L=`python get_norm_ipc.py ${START_L_DIR} DETAILED_OUTPUT`
HYDRA_C=`python get_norm_ipc.py ${HYDRA_C_DIR} DETAILED_OUTPUT`
HYDRA_P=`python get_norm_ipc.py ${HYDRA_P_DIR} DETAILED_OUTPUT`
paste <(echo "$BMK_NAMES") <(echo "$HYDRA_C") <(echo "$HYDRA_P") <(echo "$START_S") <(echo "$START_L") <(echo "$START_D") <(echo "$IDEAL") >> ${OUT_FILE}