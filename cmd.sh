#!/bin/bash
# 预处理
python preprocess.py --text_index 1 --filelists filelists/list.txt filelists/list_val.txt

# 训练单人
PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python python train.py -c configs/chinese_base.json -m diluke

# 合成list.txt
cat spka.json | jq '.[]|["wavs/",.filename,.asr_result] | join("|")' | awk -F '|' '{print $1$2"|"$3}' | grep -Po "wav.*[^\"]" | sort -k 2 -t "/" -n

# slicer
python slicer.py *.wav --out output/

# 音频转换
```shell
#!/bin/bash
for i in `ls`
do
  ffmpeg -i $i -ac 1 -ar 22050 -acodec pcm_s16le ./$i.wav
done
```
