#!/bin/bash
# 预处理
python preprocess.py --text_index 1 --filelists filelists/list.txt filelists/list_val.txt

# 训练单人
PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python python train.py -c configs/chinese_base.json -m diluke
