#!/bin/bash
##DGX
#SBATCH --job-name=critical_period_step
#SBATCH --partition=common
#SBATCH --gpus=1
#SBATCH --cpus-per-task=24
#SBATCH --mem-per-cpu=2G
#SBATCH --partition=batch
#SBATCH --time=1-00:00:00
#SBATCH --output=slurm_logs/slurm-%j.out

eval "$(conda shell.bash hook)"
conda activate clpi_env
WANDB__SERVICE_WAIT=300 CUDA_VISIBLE_DEVICES=0 python3 -m scripts.python.$1 $2 3e-3 &
WANDB__SERVICE_WAIT=300 CUDA_VISIBLE_DEVICES=0 python3 -m scripts.python.$1 $2 3e-4 &
WANDB__SERVICE_WAIT=300 CUDA_VISIBLE_DEVICES=0 python3 -m scripts.python.$1 $2 3e-5 &
wait