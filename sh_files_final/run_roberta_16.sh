export PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True

EXP_FOL=/home/nlpgpu7/ellt/suyun/bbq_accuracy/EXP_FOL_unlog_roberta
HF_MODEL_NAME=/home/nlpgpu7/ellt/suyun/bbq_accuracy/models/unlog_roberta # UnLoG roberta base
BATCH_SIZE=16

python LRQA/lrqa/scripts/race_preproc.py \
    --data_path ${EXP_FOL}/race
    
python /home/nlpgpu7/ellt/suyun/bbq_accuracy/LRQA/lrqa/run_lrqa.py \
    --model_name_or_path ${HF_MODEL_NAME} \
    --model_mode mc \
    --max_seq_length 512 \
    --task_name custom \
    --task_base_path ${EXP_FOL}/race \
    --output_dir ${EXP_FOL}/race_run \
    --learning_rate 1e-5 \
    --num_train_epochs 3 \
    --warmup_ratio 0.1 \
    --eval_steps 500 \
    --save_steps 500 \
    --save_total_limit 5 \
    --save_strategy steps \
    --evaluation_strategy steps \
    --load_best_model_at_end \
    --per_device_train_batch_size ${BATCH_SIZE} \
    --per_device_eval_batch_size ${BATCH_SIZE} \
    --do_train --do_eval --do_predict --predict_phases validation