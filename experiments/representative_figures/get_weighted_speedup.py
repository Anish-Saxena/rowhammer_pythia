import numpy as np
import pandas as pd
import sys

single_core_bmk_dir = "./mix_workloads/1C_16W/"

stat_dir = sys.argv[1]

if '512GB' in stat_dir:
    print("512GB single core stats used\n\n\n\n")
    single_core_bmk_dir = "./mix_workloads/1C_16W_512GB/"

bmks = pd.read_csv("bmk_1C_names.csv", delimiter='\t')

bmks['1C_IPC'] = 0.0

for bmk in bmks['workload']:
    bmk_filename = single_core_bmk_dir + bmk + '_1T_base/' + bmk + '_1T_base.out'
    bmk_file = open(bmk_filename, 'r')
    content = bmk_file.readlines()
    for line in content:
        if "CORE_0_SIM_IPC" in line:
            bmks.loc[bmks['workload'] == bmk, '1C_IPC'] = float(line.split()[1])
            break
    multicore_filename = bmks.loc[bmks['workload'] == bmk, 'name'].iloc[0]
    multicore_filename = multicore_filename.replace('.champsimtrace.xz', '')
    mc_filename = stat_dir + multicore_filename + \
                    '_4T_base/' + multicore_filename + '_4T_base.out'
    mc_file = open(mc_filename, 'r')
    content = mc_file.readlines()
    core_idx = 0
    ws = 0.0
    for line in content:
        stat_name = "CORE_" + str(core_idx) + "_SIM_IPC"
        if stat_name in line:
            single_core_ipc = bmks.loc[bmks['workload'] == bmk, '1C_IPC'].iloc[0]
            curr_ipc = float(line.split()[1])
            ws += curr_ipc/single_core_ipc
            core_idx += 1
            if core_idx == 8:
                break
    print(bmk, round(ws, 4))
