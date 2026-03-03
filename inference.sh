export TOKENIZERS_PARALLELISM=false
# export MODEL_NAME="path/StableAvatar/checkpoints/Wan2.1-Fun-V1.1-1.3B-InP"

# CUDA_VISIBLE_DEVICES=0 python inference.py \
#   --config_path="deepspeed_config/wan2.1/wan_civitai.yaml" \
#   --pretrained_model_name_or_path=$MODEL_NAME \
#   --transformer_path="path/StableAvatar/checkpoints/StableAvatar-1.3B/transformer3d-square.pt" \
#   --pretrained_wav2vec_path="path/StableAvatar/checkpoints/wav2vec2-base-960h" \
#   --validation_reference_path="path/StableAvatar/examples/case-1/reference.png" \
#   --validation_driven_audio_path="path/StableAvatar/examples/case-1/audio.wav" \
#   --output_dir="path/StableAvatar/output_infer" \
#   --validation_prompts="A middle-aged woman with short light brown hair, wearing pearl earrings and a blue blazer, is speaking passionately in front of a blurred background resembling a government building. Her mouth is open mid-phrase, her expression is engaged and energetic, and the lighting is bright and even, suggesting a television interview or live broadcast. The scene gives the impression she is singing with conviction and purpose." \
#   --seed=42 \
#   --ulysses_degree=1 \
#   --ring_degree=1 \
#   --motion_frame=25 \
#   --sample_steps=50 \
#   --width=512 \
#   --height=512 \
#   --overlap_window_length=5 \
#   --clip_sample_n_frames=81 \
#   --GPU_memory_mode="model_full_load" \
#   --sample_text_guide_scale=3.0 \
#   --sample_audio_guide_scale=5.0


# Runs
# export MODEL_NAME="checkpoints/Wan2.1-Fun-V1.1-1.3B-InP"

# CUDA_VISIBLE_DEVICES=0 python inference.py \
#   --config_path="deepspeed_config/wan2.1/wan_civitai.yaml" \
#   --pretrained_model_name_or_path=$MODEL_NAME \
#   --transformer_path="checkpoints/StableAvatar-1.3B/transformer3d-square.pt" \
#   --pretrained_wav2vec_path="checkpoints/wav2vec2-base-960h" \
#   --validation_reference_path="examples/case-1/reference.png" \
#   --validation_driven_audio_path="examples/case-1/audio.wav" \
#   --output_dir="output_infer" \
#   --validation_prompts="A middle-aged woman with short light brown hair, wearing pearl earrings and a blue blazer, is speaking passionately in front of a blurred background resembling a government building. Her mouth is open mid-phrase, her expression is engaged and energetic, and the lighting is bright and even, suggesting a television interview or live broadcast. The scene gives the impression she is singing with conviction and purpose." \
#   --seed=42 \
#   --ulysses_degree=1 \
#   --ring_degree=1 \
#   --motion_frame=25 \
#   --sample_steps=50 \
#   --width=512 \
#   --height=512 \
#   --overlap_window_length=5 \
#   --clip_sample_n_frames=81 \
#   --GPU_memory_mode="model_full_load" \
#   --sample_text_guide_scale=3.0 \
#   --sample_audio_guide_scale=5.0


export IMAGE="/mnt/c/Users/anwan/OneDrive/Khan/maity/vidLink/local_data/avatars/sales_executive/executive.png"
export AUDIO="/mnt/c/Users/anwan/OneDrive/Khan/maity/vidLink/video_generators/multitalk/local_data/sales_test/executive/s1.wav"


export MODEL_NAME="checkpoints/Wan2.1-Fun-V1.1-1.3B-InP"

CUDA_VISIBLE_DEVICES=0 python inference.py \
  --config_path="deepspeed_config/wan2.1/wan_civitai.yaml" \
  --pretrained_model_name_or_path=$MODEL_NAME \
  --transformer_path="checkpoints/StableAvatar-1.3B/transformer3d-square.pt" \
  --pretrained_wav2vec_path="checkpoints/wav2vec2-base-960h" \
  --validation_reference_path=$IMAGE \
  --validation_driven_audio_path=$AUDIO \
  --output_dir="output_infer" \
  --validation_prompts="A professional speaks confidently directly to the camera." \
  --seed=42 \
  --ulysses_degree=1 \
  --ring_degree=1 \
  --motion_frame=25 \
  --sample_steps=50 \
  --width=512 \
  --height=512 \
  --overlap_window_length=5 \
  --clip_sample_n_frames=81 \
  --GPU_memory_mode="model_full_load" \
  --sample_text_guide_scale=3.0 \
  --sample_audio_guide_scale=5.0

SIZE=$(ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=s=x:p=0 ${IMAGE})

ffmpeg -i output_infer/video_without_audio.mp4 -i $AUDIO -c:v copy -c:a aac -shortest output_infer/video_with_audio.mp4

ffmpeg -i output_infer/video_with_audio.mp4 -vf "scale=$SIZE" output_infer/output_video.mp4


