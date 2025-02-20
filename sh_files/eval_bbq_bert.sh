EXP_FOL=/home/nlpgpu7/ellt/suyun/bbq_accuracy/EXP_FOL_bert
BATCH_SIZE=8
MODEL_PATH=/home/nlpgpu7/ellt/suyun/bbq_accuracy/EXP_FOL_bert/race_run/checkpoint-last
MAX_SEQ_LENGTH=512
BBQ_DATA=/home/nlpgpu7/ellt/suyun/bbq_accuracy/BBQ/data  

python /home/nlpgpu7/ellt/suyun/bbq_accuracy/LRQA/lrqa/scripts/bbq_preproc.py \
    --input_data_path=${BBQ_DATA} \
    --data_path ${EXP_FOL}/bbq

for CATEGORY in Age Disability_status Gender_identity Nationality Physical_appearance Race_ethnicity Race_x_SES Race_x_gender Religion SES Sexual_orientation; do
    echo "Evaluating category: ${CATEGORY}"
    python /home/nlpgpu7/ellt/suyun/bbq_accuracy/evaluation/eval.py \
        --model_name_or_path ${MODEL_PATH} \
        --data_file ${EXP_FOL}/bbq/${CATEGORY}/validation.jsonl \
        --batch_size ${BATCH_SIZE} \
        --max_seq_length ${MAX_SEQ_LENGTH} \
        --output_dir ${EXP_FOL}/bbq/${CATEGORY} > ${EXP_FOL}/bbq/${CATEGORY}/log.txt 2>&1 \
        --device cuda

python /home/nlpgpu7/ellt/suyun/bbq_accuracy/evaluation/combine_results.py \
    --result_dir ${EXP_FOL}/bbq \
    --output_file ${EXP_FOL}/bbq/combined_results.json
done

